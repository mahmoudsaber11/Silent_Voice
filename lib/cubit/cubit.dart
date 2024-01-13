import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/chat/data/model/message_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'dart:io';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;

  File? profileImage;
  ImagePicker picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
    } else {
      emit(SocialProfileImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
    required BuildContext context,
  }) {
    emit(SocialUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void updateUser(
      {required String name,
      required String phone,
      required String bio,
      String? image,
      context}) {
    emit(SocialUserUpdateLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: Helper.userModel!.email,
      uId: Helper.userModel!.uId,
      image: image ?? Helper.userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.userModel!.uId)
        .update(model.toMap())
        .then((value) {})
        .then((value) {
      emit(SocialUserUpdateSuccessState());
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  void sendMessage({
    String? receiverId,
    String? text,
    Map<String, Object>? messageImage,
    String? time,
    String? date,
  }) {
    MessageUserModel model = MessageUserModel(
        text: text,
        receiverId: receiverId,
        senderId: Helper.userModel!.uId,
        time: time,
        dateTime: Timestamp.now());
    //set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    //set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(Helper.userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageUserModel> messages = [];
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots()
        .listen((event) {
      messages = [];
      // ignore: avoid_function_literals_in_foreach_calls
      event.docs.forEach((element) {
        messages.add(MessageUserModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  File? messageImage;
  void getMessageImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      emit(GetMessagePicSuccessState());
    } else {
      emit(GetMessagePicErrorState());
    }
  }

  void popMessageImage() {
    messageImage = null;
    emit(DeleteMessagePicState());
  }

  bool isMessageImageLoading = false;
  String? imageURL;
  void uploadMessagePic({
    String? senderId,
    required String? receiverId,
    String? text,
    required String? time,
    String? dateTime,
  }) {
    isMessageImageLoading = true;
    emit(UploadMessagePicLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(Uri.file(messageImage!.path).pathSegments.last)
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageURL = value;
        sendMessage(
          receiverId: receiverId!,
          text: text!,
          messageImage: {'width': 150, 'image': value, 'height': 200},
          time: time,
        );
        emit(UploadMessagePicSuccessState());
        isMessageImageLoading = false;
      }).catchError((error) {
        emit(UploadMessagePicErrorState());
      });
    }).catchError((error) {
      emit(UploadMessagePicErrorState());
    });
  }

  dynamic signOut(context) async {
    await CacheHelper.removeData(
      key: 'uId',
    ).then((value) {
      if (value) {
        navigateAndFinish(context, const SignInView());
        SocialCubit.get(context).currentIndex = 0;
      }
    });
  }

  // bool isDarkMode = true;

  void setUserToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.userModel!.uId)
        .update({'token': token}).then((value) => {});
  }

  Future getMyData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.uId)
        .snapshots()
        .listen((value) async {
      Helper.userModel = UserModel.fromJson(value.data());
      setUserToken();
    });
  }
}

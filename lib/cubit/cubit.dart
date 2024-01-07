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
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:social_app/models/social_app/comment_model.dart';
import 'package:social_app/models/social_app/like_model.dart';
import 'package:social_app/models/social_app/message_model.dart';
import 'package:social_app/features/create_post/data/models/post_model.dart';
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
        .then((value) {
      BlocProvider.of<LayoutCubit>(context).getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  void uploadPost(
      {String? image, String? postText, String? time, String? date}) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          image: image,
          postImage: value,
          postText: postText,
          time: time,
          date: date,
        );
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    String? image,
    String? postText,
    String? postImage,
    String? time,
    String? date,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
        name: Helper.userModel!.name,
        uId: Helper.userModel!.uId,
        image: Helper.userModel!.image,
        text: postText!,
        postImage: postImage ?? '',
        likes: 0,
        comments: 0,
        time: time,
        date: date,
        dateTime: Timestamp.now());

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  File? postImage;
  void getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      emit(SocialPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) async {
      posts = [];
      event.docs.forEach((element) async {
        posts.add(PostModel.fromJson(element.data()));
        var likes = await element.reference.collection('likes').get();
        var comments = await element.reference.collection('comments').get();
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(element.id)
            .update(({
              'likes': likes.docs.length,
              'comments': comments.docs.length,
              'postId': element.id,
            }));
      });
      emit(SocialGetPostSuccessStates());
    });
  }

  void deletePost({required String postId}) {
    emit(DeletePostLoading());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      emit(DeletePostSuccess());
    }).catchError((error) {
      emit(DeletePostError(error: error.toString()));
    });
  }

  Future<bool> likedByMe(
      {context,
      String? postId,
      PostModel? postModel,
      UserModel? postUser}) async {
    emit(SocialLikePostLoadingStates());
    bool isLikedByMe = false;
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((event) async {
      var likes = await event.reference.collection('likes').get();

      likes.docs.forEach((element) {
        if (element.id == Helper.userModel!.uId) {
          isLikedByMe = true;
          //disLikePost(postId);
        }
      });
      if (isLikedByMe == false) {
        likePost(
            postId: postId,
            context: context,
            postModel: postModel,
            postUser: postUser);
      }
      emit(SocialLikePostSuccessStates());
    });
    return isLikedByMe;
  }

  void likePost(
      {context,
      String? postId,
      PostModel? postModel,
      UserModel? postUser,
      String? dateTime}) {
    LikesModel likesModel = LikesModel(
        uId: Helper.userModel!.uId,
        name: Helper.userModel!.name,
        image: Helper.userModel!.image,
        dateTime: FieldValue.serverTimestamp());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(Helper.userModel!.uId)
        .set(likesModel.toMap())
        .then((value) {
      getPosts();

      emit(SocialLikePostSuccessStates());
    }).catchError((error) {
      emit(SocialLikePostErrorStates(error.toString()));
    });
  }

  PostModel? singlePost;
  List<CommentModel> comments = [];
  CommentModel? commentModel;
  void commentPost({
    required String? postId,
    String? comment,
    Map<String, dynamic>? commentImage,
    required String? time,
    String? date,
  }) {
    CommentModel commentModel = CommentModel(
        name: Helper.userModel!.name,
        image: Helper.userModel!.image,
        commentText: comment,
        commentImage: commentImage,
        time: time,
        date: date,
        dateTime: FieldValue.serverTimestamp());
    emit(SocialCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      getPosts();
      emit(SocialCommentSuccessState());
    }).catchError((error) {
      emit(SocialCommentErrorState(error.toString()));
    });
  }

  bool isCommentImageLoading = false;
  String? commentImageURL;
  File? commentImage;
  void uploadCommentPic({
    required String? postId,
    String? commentText,
    required String? time,
    String? date,
  }) {
    isCommentImageLoading = true;
    emit(UploadCommentPicLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(Uri.file(commentImage!.path).pathSegments.last)
        .putFile(commentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        commentImageURL = value;
        commentPost(
          postId: postId,
          comment: commentText,
          commentImage: {'width': 150, 'image': value, 'height': 200},
          time: time,
          date: date,
        );
        emit(UpdatePostLoadingState());
        isCommentImageLoading = false;
      }).catchError((error) {
        emit(UploadCommentPicErrorState());
      });
    }).catchError((error) {
      emit(UploadCommentPicErrorState());
    });
  }

  void getComments(postId) {
    emit(GetCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection("comments")
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments.clear();
      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
        emit(GetCommentPicSuccessState());
      });
    });
  }

  // Future getCommentImage() async {
  //   emit(UpdatePostLoadingState());
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     commentImage = File(pickedFile.path);
  //     emit(GetCommentPicSuccessState());
  //   } else {
  //     emit(GetCommentPicErrorState());
  //   }
  // }

  // void popCommentImage() {
  //   commentImage = null;
  //   emit(DeleteCommentPicState());
  // }

  List<UserModel>? users;

  void getUsers() {
    emit(SocialGetAllUsersLoadingStates());

    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != Helper.userModel!.uId) {
          users!.add(UserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUsersSuccessStates());
    }).catchError((error) {
      emit(SocialGetUserErrorStates(error.toString()));
      print(error);
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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/core/helpers/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;

  // File? profileImage;
  // ImagePicker picker = ImagePicker();
  // Future<void> getProfileImage() async {
  //   final pickedFile = await picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     profileImage = File(pickedFile.path);
  //     emit(SocialProfileImageSuccessState());
  //   } else {
  //     emit(SocialProfileImageErrorState());
  //   }
  // }

  // void uploadProfileImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  //   required BuildContext context,
  // }) {
  //   emit(SocialUploadProfileImageLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
  //       .putFile(profileImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       emit(SocialUploadProfileImageSuccessState());
  //       updateUser(
  //         name: name,
  //         phone: phone,
  //         bio: bio,
  //         image: value,
  //       );
  //     }).catchError((error) {
  //       emit(SocialUploadProfileImageErrorState());
  //     });
  //   }).catchError((error) {
  //     emit(SocialUploadProfileImageErrorState());
  //   });
  // }

  // void updateUser(
  //     {required String name,
  //     required String phone,
  //     required String bio,
  //     String? image,
  //     context}) {
  //   emit(SocialUserUpdateLoadingState());
  //   UserModel model = UserModel(
  //     name: name,
  //     phone: phone,
  //     bio: bio,
  //     email: Helper.userModel!.email,
  //     uId: Helper.userModel!.uId,
  //     image: image ?? Helper.userModel!.image,
  //   );
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(Helper.userModel!.uId)
  //       .update(model.toMap())
  //       .then((value) {})
  //       .then((value) {
  //     emit(SocialUserUpdateSuccessState());
  //   }).catchError((error) {
  //     emit(SocialUserUpdateErrorState());
  //   });
  // }

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

  // void setUserToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(Helper.userModel!.uId)
  //       .update({'token': token}).then((value) => {});
  // }

  // Future getMyData() async {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(Helper.uId)
  //       .snapshots()
  //       .listen((value) async {
  //     Helper.userModel = UserModel.fromJson(value.data());
  //     setUserToken();
  //   });
  // }
}

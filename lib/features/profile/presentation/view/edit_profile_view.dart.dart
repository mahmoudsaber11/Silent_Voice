import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_state.dart';
import 'package:social_app/features/profile/presentation/widgets/edit_profile/edit_profile_form.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarEditProile(context),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                  return CircleAvatar(
                    radius: 64,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundImage: (BlocProvider.of<EditProfileCubit>(context)
                                .profileImage ==
                            null
                        ? NetworkImage('${Helper.userModel!.image}')
                        : FileImage(BlocProvider.of<EditProfileCubit>(context)
                            .profileImage!)) as ImageProvider,
                  );
                }),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  child: const Text('Change Picture'),
                  onTap: () {
                    BlocProvider.of<EditProfileCubit>(context)
                        .getProfileImage(source: ImageSource.gallery);
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                const EditProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBarEditProile(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        "Edit Profile",
        style: AppTextStyles.textStyle25.copyWith(color: Colors.black),
      ),
      leading: InkWell(
        onTap: () {
          context.getBack();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
    );
  }
}

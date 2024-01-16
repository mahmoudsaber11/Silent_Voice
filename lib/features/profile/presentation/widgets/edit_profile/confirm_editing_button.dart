import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/features/profile/data/entities/update_user_params.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_state.dart';

class ConfirmEditingButtons extends StatelessWidget {
  const ConfirmEditingButtons({
    super.key,
    required this.cubit,
    required this.nameController,
    required this.phoneController,
    required this.bioController,
    required this.state,
  });
  final EditProfileCubit cubit;
  final EditProfileState state;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (cubit.profileImage != null)
          Expanded(
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  child: const Text("Update Profile Image"),
                  onPressed: () => cubit.uploadProfileImage(
                    updateUserParams: UpdateUserParams(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    ),
                  ),
                ),
                if (state is UploadImageLoading) ...[
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: screenWidth * 0.4,
                    child: const LinearProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

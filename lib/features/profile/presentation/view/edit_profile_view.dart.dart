import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/core/widgets/custom_general_button.dart';
import 'package:social_app/core/widgets/custom_text_field.dart';

import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/profile/data/entities/update_user_params.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_state.dart';
import 'package:social_app/features/profile/presentation/widgets/edit_profile/text_field_label.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    super.dispose();

    _disposeControllers();
  }

  void _disposeControllers() {
    _nameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        File? profileImage =
            BlocProvider.of<EditProfileCubit>(context).profileImage;
        _nameController.text = Helper.userModel!.name!;
        _bioController.text = Helper.userModel!.bio!;
        _phoneController.text = Helper.userModel!.phone!;
        return Scaffold(
          appBar: AppBar(
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
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    if (state is SocialUserUpdateLoadingState)
                      const LinearProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    if (state is SocialUserUpdateLoadingState)
                      SizedBox(
                        height: 15.h,
                      ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      backgroundImage: (profileImage == null
                          ? NetworkImage('${Helper.userModel!.image}')
                          : FileImage(profileImage)) as ImageProvider,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      child: Text('Change Picture'),
                      onTap: () {
                        BlocProvider.of<EditProfileCubit>(context)
                            .getProfileImage(source: ImageSource.gallery);
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFieldLabel(
                      text: "UserName",
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      prefix: Icon(Icons.person),
                    ),
                    TextFieldLabel(
                      text: "Bio",
                    ),
                    CustomTextField(
                      controller: _bioController,
                      prefix: Icon(Icons.info),
                      keyboardType: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'bio must not be empty';
                        }
                        return null;
                      },
                    ),
                    TextFieldLabel(
                      text: "Phone",
                    ),
                    CustomTextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      prefix: Icon(Icons.phone),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomGeneralButton(
                          text: 'Update',
                          onPressed: () {
                            BlocProvider.of<EditProfileCubit>(context)
                                .updateUser(
                              updateUserParams: UpdateUserParams(
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  bio: _bioController.text),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        // appBar: defaultAppBar(
        //   context: context,
        //   title: 'Edit Profile',
        //   actions: [
        //     TextButton(
        //         onPressed: () {
        // SocialCubit.get(context).updateUser(
        //     name: nameController.text,
        //     phone: phoneController.text,
        //     bio: bioController.text);
        //         },
        //         child: const Text('Update')),
        //     const SizedBox(
        //       width: 15.0,
        //     ),
        //   ],
        // ),
        //     body: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: SingleChildScrollView(
        //     child: Column(children: [
        // if (state is SocialUserUpdateLoadingState)
        //   const LinearProgressIndicator(),
        // if (state is SocialUserUpdateLoadingState)
        //         const SizedBox(
        //           height: 10,
        //         ),
        //       SizedBox(
        //         height: 180,
        //         child: Stack(
        //           alignment: AlignmentDirectional.bottomCenter,
        //           children: [
        //             Stack(
        //               alignment: AlignmentDirectional.bottomEnd,
        //               children: [

        //                 IconButton(
        //                   onPressed: () {
        //                     SocialCubit.get(context).getProfileImage();
        //                   },
        //                   icon: CircleAvatar(
        //                       //   backgroundColor: Colors.grey[400],
        //                       radius: 13,
        //                       child: Icon(
        //                         Icons.camera_alt_outlined,
        //                         size: 16,
        //                         color: Colors.grey[300],
        //                       )),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       //  if (SocialCubit.get(context).profileImage != null ||
        //       //      SocialCubit.get(context).coverImage != null)
        //       Row(
        //         children: [
        // if (SocialCubit.get(context).profileImage != null)
        //             Expanded(
        //               child: Column(
        //                 children: [
        //                   ElevatedButton(
        //                     onPressed: () {
        //                       SocialCubit.get(context).uploadProfileImage(
        //                           context: context,
        //                           name: nameController.text,
        //                           phone: phoneController.text,
        //                           bio: bioController.text);
        //                     },
        //                     child: const Text('Upload Profile'),
        //                   ),
        // if (state is SocialUploadProfileImageLoadingState)
        //   const LinearProgressIndicator(),
        //                 ],
        //               ),
        //             ),
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 15.0,
        //       ),
        //       TextFormField(
        //         controller: nameController,
        //         keyboardType: TextInputType.name,
        //         validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'name must not be empty';
        //   }
        //   return null;
        // },
        //         decoration: const InputDecoration(
        //             border: OutlineInputBorder(),
        //             label: Text('Name'),
        //             prefixIcon: Icon(Icons.person)),
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       TextFormField(
        // controller: bioController,
        // keyboardType: TextInputType.text,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'bio must not be empty';
        //   }
        //   return null;
        // },
        //         decoration: const InputDecoration(
        //             border: OutlineInputBorder(),
        //             label: Text('Bio'),
        //             prefixIcon: Icon(Icons.info)),
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       TextFormField(
        // controller: phoneController,
        // keyboardType: TextInputType.phone,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'phone must not be empty';
        //   }
        //   return null;
        // },
        //         decoration: const InputDecoration(
        //             border: OutlineInputBorder(),
        //             label: Text('Phone'),
        //             prefixIcon: Icon(Icons.call)),
        //       ),
        //     ]),
        //   ),
        // ));
      },
    );
  }
}

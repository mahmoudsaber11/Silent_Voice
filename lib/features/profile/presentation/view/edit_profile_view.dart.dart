import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/core/widgets/custom_circular_progress_indicator.dart';
import 'package:social_app/core/widgets/custom_general_button.dart';
import 'package:social_app/core/widgets/custom_text_field.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';

import 'package:social_app/features/profile/data/entities/update_user_params.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_state.dart';
import 'package:social_app/features/profile/presentation/widgets/edit_profile/text_field_label.dart';

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

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    super.key,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  late final GlobalKey<FormState> _formKey;
  @override
  void dispose() {
    super.dispose();

    _disposeControllers();
  }

  void _initFormAttributes() {
    _formKey = GlobalKey<FormState>();
  }

  void _disposeControllers() {
    _nameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
  }

  @override
  void initState() {
    _assignValuesToControllers();
    _initFormAttributes();
    super.initState();
  }

  void _assignValuesToControllers() {
    _nameController.text = Helper.userModel!.name!;
    _bioController.text = Helper.userModel!.bio!;
    _phoneController.text = Helper.userModel!.phone!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          BlocProvider.of<LayoutCubit>(context).getUserData();
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<EditProfileCubit>(context);
        return Form(
          key: _formKey,
          child: Column(
            children: [
              const TextFieldLabel(
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
                prefix: const Icon(Icons.person),
              ),
              SizedBox(
                height: 15.h,
              ),
              const TextFieldLabel(
                text: "Bio",
              ),
              CustomTextField(
                controller: _bioController,
                prefix: const Icon(Icons.info),
                keyboardType: TextInputType.text,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'bio must not be empty';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              const TextFieldLabel(
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
                prefix: const Icon(Icons.phone),
              ),
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: state is UpdateUserLoading
                    ? const CustomCircularProgressIndicator()
                    : CustomGeneralButton(
                        text: 'Update',
                        onPressed: () {
                          _update(cubit);
                        }),
              ),
            ],
          ),
        );
      },
    );
  }

  void _update(EditProfileCubit cubit) {
    if (_formKey.currentState!.validate() && cubit.profileImage == null) {
      cubit.updateUser(
        updateUserParams: UpdateUserParams(
            name: _nameController.text,
            phone: _phoneController.text,
            bio: _bioController.text),
      );
    }
    if (cubit.profileImage != null) {
      cubit.uploadProfileImage(
          updateUserParams: UpdateUserParams(
        name: _nameController.text,
        phone: _phoneController.text,
        bio: _bioController.text,
      ));
    }
  }
}

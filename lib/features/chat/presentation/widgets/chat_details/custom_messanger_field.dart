import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/widgets/custom_send_button.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/chat/data/entities/send_message_params.dart';
import 'package:social_app/features/chat/presentation/cubit/chat_cubit.dart';

class CustomMessangerField extends StatefulWidget {
  const CustomMessangerField({
    super.key,
    required this.cubit,
    required this.userModel,
  });

  final UserModel userModel;
  final ChatCubit cubit;

  @override
  State<CustomMessangerField> createState() => _CustomMessangerFieldState();
}

class _CustomMessangerFieldState extends State<CustomMessangerField> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String commentText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.h, left: 15.w),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                BlocProvider.of<ChatCubit>(context).getMessageImage(
                  source: ImageSource.camera,
                );
              },
              child: Icon(
                Icons.camera_alt_outlined,
                size: 30.sp,
                color: Colors.black54,
              )),
          SizedBox(
            width: 10.w,
          ),
          InkWell(
              onTap: () {
                BlocProvider.of<ChatCubit>(context).getMessageImage(
                  source: ImageSource.gallery,
                );
              },
              child: Icon(
                Icons.image_outlined,
                size: 30.sp,
                color: Colors.black54,
              )),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _messageController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                    ),
                  ),
                  if (widget.cubit.messageImage != null) ...[
                    SizedBox(height: 8.h),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 120.h,
                          margin: EdgeInsets.only(
                            right: 8.w,
                            bottom: 8.h,
                          ),
                          width: double.infinity,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.r),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(
                                  BlocProvider.of<ChatCubit>(context)
                                      .messageImage!),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10.h,
                          right: 16.w,
                          child: CircleAvatar(
                            radius: 15.r,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () =>
                                  BlocProvider.of<ChatCubit>(context)
                                      .removeMessageImage(),
                              icon: Icon(
                                Icons.close,
                                color: AppColors.primaryColor,
                                size: 20.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),
          CustomSendButton(onPressed: () => sendMessage(context)),
        ],
      ),
    );
  }

  void sendMessage(context) {
    if (widget.cubit.messageImage == null) {
      widget.cubit.sendMessage(
          sendMessageParams: SendMessageParams(
              receiverId: widget.userModel.uId!,
              date: Helper.getDate(),
              text: _messageController.text.trim(),
              time: TimeOfDay.now().format(context)));
    }
    if (widget.cubit.messageImage != null) {
      widget.cubit.uploadMessageImage(
        sendMessageParams: SendMessageParams(
          receiverId: widget.userModel.uId!,
          date: Helper.getDate(),
          time: TimeOfDay.now().format(context),
          text: _messageController.text.trim(),
        ),
      );
    }
    setState(() {
      commentText = '';
    });
    _messageController.clear();
    BlocProvider.of<ChatCubit>(context).messageImage = null;
  }
}

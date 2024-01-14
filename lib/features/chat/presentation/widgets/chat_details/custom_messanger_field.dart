import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
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
      padding: EdgeInsets.only(top: 15.h, bottom: 15, left: 15),
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
            child: TextFormField(
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
          ),
          CustomSendButton(onPressed: () {
            BlocProvider.of<ChatCubit>(context).sendMessage(
                sendMessageParams: SendMessageParams(
                    receiverId: widget.userModel.uId!,
                    date: Helper.getDate(),
                    text: _messageController.text.trim(),
                    time: TimeOfDay.now().format(context)));
            _messageController.clear();
          }),
        ],
      ),
    );
    // return CustomMessangerAndCommentField(
    //     controller: _messageController,
    //     hintText: 'Send Message...',
    //     onChanged: (value) {
    //       setState(() {
    //         _messageController.text = value;
    //       });
    //     },
    //     prefix: IconButton(
    //         onPressed: () {
    //           BlocProvider.of<ChatCubit>(context)
    //               .getMessageImage(source: ImageSource.camera);
    //         },
    //         icon: Icon(
    //           Icons.camera_enhance_outlined,
    //         )),
    // onPressed: () {
    //   BlocProvider.of<ChatCubit>(context).sendMessage(
    //       sendMessageParams: SendMessageParams(
    //           receiverId: widget.userModel.uId!,
    //           date: Helper.getDate(),
    //           text: _messageController.text.trim(),
    //           time: TimeOfDay.now().format(context)));
    // });
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
    setState(() {
      commentText = '';
    });
    _messageController.clear();
  }
}

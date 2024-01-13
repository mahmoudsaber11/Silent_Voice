import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/chat_details_view_body.dart';

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: ChatDetailsViewBody(
        userModel: userModel,
      ),
    );
  }
}

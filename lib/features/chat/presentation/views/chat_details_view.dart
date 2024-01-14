import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/chat/data/repositories/chat_repo_impl.dart';
import 'package:social_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/cubit/chat_state.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/chat_details_view_body.dart';

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(chatRepo: ChatRepoImpl()),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: ChatDetailsViewBody(
          userModel: userModel,
        ),
      ),
    );
  }
}

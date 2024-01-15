import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/cubit/chat_state.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/appbar_chat_details.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/chat_buble.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/custom_messanger_field.dart';

class ChatDetailsViewBody extends StatelessWidget {
  ChatDetailsViewBody({super.key, required this.userModel});
  final UserModel userModel;

  final TextEditingController messangerConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChatCubit>(context);
    return Column(
      children: [
        AppBarChatDetails(userModel: userModel),
        SizedBox(
          height: 10.h,
        ),
        Builder(builder: (context) {
          BlocProvider.of<ChatCubit>(context)
              .getMessages(receiverId: userModel.uId!);
          return BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return Expanded(
                child: CustomCardApp(
                    widget: cubit.messages.isNotEmpty
                        ? Column(
                            children: [
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: cubit.messages.length,
                                      itemBuilder: ((context, index) {
                                        if (Helper.userModel!.uId ==
                                            cubit.messages[index].senderId) {
                                          return ChatBuble(
                                            message: cubit.messages[index],
                                          );
                                        } else {
                                          return ChatBubleForFriend(
                                              message: cubit.messages[index]);
                                        }
                                      }))),
                              CustomMessangerField(
                                userModel: userModel,
                                cubit: cubit,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              const Expanded(
                                  child: Center(
                                child: Text(
                                  "No Message...",
                                  style:
                                      TextStyle(color: AppColors.primaryColor),
                                ),
                              )),
                              CustomMessangerField(
                                userModel: userModel,
                                cubit: cubit,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          )),
              );
            },
          );
        }),
      ],
    );
  }
}

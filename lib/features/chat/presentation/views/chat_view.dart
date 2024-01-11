import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/functions/show_toast.dart';
import 'package:social_app/core/widgets/custom_circular_progress_indicator.dart';
import 'package:social_app/features/chat/presentation/widgets/appbar_chat.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_item.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_state.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarChat(),
        BlocBuilder<LayoutCubit, LayoutState>(builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          if (state is GetAllUserSuccess) {
            return Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ChatItem(userModel: cubit.users![index]);
                },
                itemCount: cubit.users!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.grey[200],
                  );
                },
              ),
            );
          } else if (state is GetAllUserError) {
            return showToast(text: state.error, state: ToastStates.error);
          } else {
            return CustomCircularProgressIndicator();
          }
        }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/functions/show_toast.dart';
import 'package:social_app/core/widgets/custom_circular_progress_indicator.dart';
import 'package:social_app/core/widgets/custom_text_field.dart';
import 'package:social_app/features/chat/presentation/widgets/chat/appbar_chat.dart';
import 'package:social_app/features/chat/presentation/widgets/chat/chat_item.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_state.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarChat(),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 50,
            child: CustomTextField(
              keyboardType: TextInputType.text,
              controller: searchController,
              hintText: "Search 'Your Friend'",
              prefix: Icon(Icons.search),
              suffix: Icon(Icons.mic_outlined),
            ),
          ),
        ),
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

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(builder: (context, state) {
      var cubit = SocialCubit.get(context);
      return ListView.separated(
        itemBuilder: (context, index) {
          return ConditionalBuilder(
            condition: cubit.users!.isNotEmpty,
            builder: (context) {
              return chatItem(context, cubit.users![index]);
            },
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
        itemCount: cubit.users!.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      );
    });
  }

  Widget chatItem(BuildContext context, UserModel model) {
    return InkWell(
      onTap: () {
        navigateTo(context, ChatDetails());
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          CircleAvatar(
              radius: 22, backgroundImage: NetworkImage('${model.image}')),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${model.name}",
                //   style: themeMode.textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(
            width: 3,
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ]),
      ),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/social_app/message_model.dart';
import 'package:social_app/features/chat_details/call_video.dart';
import 'package:social_app/features/chat_details/nlp.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';

class ChatDetails extends StatelessWidget {
  final UserModel? userModel;
  const ChatDetails(this.userModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            String enteredMsg = '';

            return ConditionalBuilder(
              condition: userModel != null,
              builder: (BuildContext context) {
                var messageController = TextEditingController();
                return Scaffold(
                  appBar: AppBar(
                    title: Row(children: [
                      CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage('${userModel?.image}')),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${userModel?.name}",
                            // style: themeMode.textTheme.titleSmall,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ]),
                    actions: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CallPage(callID: "2"),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.video_call,
                                size: 35,
                                color: Colors.deepOrange,
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SpeechScreen()));
                              },
                              icon: const Icon(Icons.call)),
                        ],
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              reverse: true,
                              itemBuilder: (context, index) {
                                var message = cubit.messages[index];
                                if (userModel!.uId == message.senderId) {
                                  return buildMessage(message);
                                } else {
                                  return buildMyMessage(message);
                                }
                              },
                              separatorBuilder: (context, indext) =>
                                  const SizedBox(
                                    height: 15,
                                  ),
                              itemCount: cubit.messages.length),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) {
                                    enteredMsg = value;
                                  },
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Type your message ....",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              // ignore: sized_box_for_whitespace
                              Container(
                                height: 40,
                                child: MaterialButton(
                                  onPressed: () {
                                    // ignore: unused_local_variable
                                    var now = DateTime.now();
                                    enteredMsg.trim().isEmpty
                                        ? null
                                        : cubit.sendMessage(
                                            receiverId: userModel!.uId!,
                                            // date: getDate(),
                                            time:
                                                TimeOfDay.now().format(context),
                                            text: messageController.text);
                                  },
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              fallback: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          });
    });
  }
}

Widget buildMessage(MessageUserModel message) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          // alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.grey[500],
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                bottomEnd: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )),
          child: Text(message.text!),
        ),
        Text(
          ' ${message.time}',
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ],
    ),
  );
}

Widget buildMyMessage(MessageUserModel message) {
  return Align(
    alignment: Alignment.centerRight,
    child: Column(
      children: [
        Container(
          // alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )),
          child: Text(message.text!),
        ),
        Text(
          ' ${message.time}',
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ],
    ),
  );
}

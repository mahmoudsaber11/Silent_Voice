import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/chat/data/entities/send_message_params.dart';
import 'package:social_app/features/chat/data/model/message_model.dart';
import 'package:social_app/features/chat/data/repositories/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  @override
  Future<void> sendMessage(
      {required SendMessageParams sendMessageParams}) async {
    MessageUserModel messageModel = MessageUserModel(
      text: sendMessageParams.text,
      dateTime: Timestamp.now(),
      senderId: Helper.userModel!.uId,
      receiverId: sendMessageParams.receiverId,
      date: sendMessageParams.date,
      time: sendMessageParams.time,
      messageImage: sendMessageParams.messageImage,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.userModel!.uId)
        .collection('chats')
        .doc(sendMessageParams.receiverId)
        .collection('messages')
        .add(messageModel.toMap());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/chat/data/model/message_model.dart';
import 'package:social_app/features/chat/data/repositories/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  @override
  Future<void> sendMessage(
      {required String receiverId,
      required String time,
      required String date,
      required Map<String, dynamic>? messageImage,
      required String text}) async {
    MessageUserModel messageModel = MessageUserModel(
      text: text,
      dateTime: Timestamp.now(),
      senderId: Helper.userModel!.uId,
      receiverId: receiverId,
      date: date,
      time: time,
      messageImage: messageImage,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap());
  }
}

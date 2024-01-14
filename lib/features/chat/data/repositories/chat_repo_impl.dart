import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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
    // set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.userModel!.uId)
        .collection('chats')
        .doc(sendMessageParams.receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      //set receiver chat
      FirebaseFirestore.instance
          .collection('users')
          .doc(sendMessageParams.receiverId)
          .collection('chats')
          .doc(Helper.userModel!.uId)
          .collection('messages')
          .add(messageModel.toMap());
    });
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      {required String receiverId}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots();
  }

  @override
  Future<XFile?> getMessageImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(source: source);
  }

  @override
  Future<TaskSnapshot> uploadMessageImage({File? messageImage}) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(Uri.file(messageImage!.path).pathSegments.last)
        .putFile(messageImage);
  }
}

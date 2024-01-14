import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/chat/data/entities/send_message_params.dart';

abstract class ChatRepo {
  Future<void> sendMessage({required SendMessageParams sendMessageParams});
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String receiverId,
  });
  Future<XFile?> getMessageImage({required ImageSource source});

  Future<TaskSnapshot> uploadMessageImage({
    File? messageImage,
  });
}

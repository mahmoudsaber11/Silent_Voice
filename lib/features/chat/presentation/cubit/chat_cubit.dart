import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/chat/data/entities/send_message_params.dart';
import 'package:social_app/features/chat/data/model/message_model.dart';
import 'package:social_app/features/chat/data/repositories/chat_repo.dart';
import 'package:social_app/features/chat/presentation/cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.chatRepo}) : super(ChatInitial());
  final ChatRepo chatRepo;

  void sendMessage({required SendMessageParams sendMessageParams}) {
    chatRepo.sendMessage(sendMessageParams: sendMessageParams).then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError(error: error));
    });
  }

  List<MessageUserModel> messages = [];
  void getMessages({required String receiverId}) {
    chatRepo.getMessages(receiverId: receiverId).listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageUserModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccess(messages: messages));
    }).onError((error) {
      emit(GetMessagesError(error: error));
    });
  }

  File? messageImage;
  void getMessageImage({required ImageSource source}) {
    chatRepo.getMessageImage(source: source).then((value) {
      if (value != null) {
        messageImage = File(value.path);
        emit(GetMessagePicSuccess(messageImage: messageImage!));
      }
    }).catchError((error) {
      emit(GetMessagePicError(error: error));
    });
  }

  void uploadMessageImage({required SendMessageParams sendMessageParams}) {
    emit(const UploadMessagePicLoading());
    chatRepo.uploadMessageImage().then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
            sendMessageParams: SendMessageParams(
          receiverId: sendMessageParams.receiverId,
          date: sendMessageParams.date,
          time: sendMessageParams.time,
          messageImage: {'width': 150, 'image': value, 'height': 200},
          text: sendMessageParams.text,
        ));
        emit(UploadMessagePicSuccess(imageUrl: value));
      });
    }).catchError((error) {
      emit(UploadMessagePicError(error: error));
    });
  }

  void removeMessageImage() {
    messageImage = null;

    emit(const RemovedMessageImageSuccess());
  }
}

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:social_app/features/chat/data/model/message_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class SendMessageSuccess extends ChatState {
  const SendMessageSuccess();
}

class SendMessageError extends ChatState {
  final String error;

  const SendMessageError({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetMessagesSuccess extends ChatState {
  final List<MessageUserModel> messages;

  const GetMessagesSuccess({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class GetMessagesError extends ChatState {
  final String error;

  const GetMessagesError({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetMessagePicSuccess extends ChatState {
  final File messageImage;

  const GetMessagePicSuccess({required this.messageImage});

  @override
  List<Object?> get props => [messageImage];
}

class GetMessagePicError extends ChatState {
  final String error;

  const GetMessagePicError({required this.error});

  @override
  List<Object?> get props => [error];
}

class UploadMessagePicLoading extends ChatState {
  const UploadMessagePicLoading();
}

class UploadMessagePicSuccess extends ChatState {
  final String imageUrl;

  const UploadMessagePicSuccess({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class UploadMessagePicError extends ChatState {
  final String error;

  const UploadMessagePicError({required this.error});

  @override
  List<Object?> get props => [error];
}

class RemovedMessageImageSuccess extends ChatState {
  const RemovedMessageImageSuccess();
}

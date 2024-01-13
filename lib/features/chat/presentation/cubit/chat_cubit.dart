import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/chat/data/entities/send_message_params.dart';
import 'package:social_app/features/chat/data/repositories/chat_repo.dart';
import 'package:social_app/features/chat/presentation/cubit/chat_state.dart';

class ChatCubit extends Cubit {
  ChatCubit({required this.chatRepo}) : super(ChatInitial());
  final ChatRepo chatRepo;

  void sendMessage({required SendMessageParams sendMessageParams}) {
    chatRepo.sendMessage(sendMessageParams: sendMessageParams).then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError(error: error));
    });
  }
}

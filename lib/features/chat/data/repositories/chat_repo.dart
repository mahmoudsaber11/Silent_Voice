import 'package:social_app/features/chat/data/entities/send_message_params.dart';

abstract class ChatRepo {
  Future<void> sendMessage({required SendMessageParams sendMessageParams});
}

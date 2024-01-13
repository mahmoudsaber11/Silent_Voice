import 'package:equatable/equatable.dart';

class SendMessageParams extends Equatable {
  final String receiverId;
  final String date;
  final String time;
  final String? text;
  final Map<String, dynamic>? messageImage;

  const SendMessageParams({
    required this.receiverId,
    required this.date,
    required this.time,
    this.text,
    this.messageImage,
  });

  @override
  List<Object?> get props => [
        receiverId,
        date,
        time,
        text,
        messageImage,
      ];
}

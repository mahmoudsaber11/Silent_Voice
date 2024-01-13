import 'package:cloud_firestore/cloud_firestore.dart';

class MessageUserModel {
  final String? senderId;
  final String? receiverId;
  final String? time;
  final String? date;
  final Timestamp? dateTime;
  final String? text;
  final Map<String, dynamic>? messageImage;

  MessageUserModel({
    this.receiverId,
    this.senderId,
    this.dateTime,
    this.time,
    this.date,
    this.text,
    this.messageImage,
  });
  factory MessageUserModel.fromJson(Map<String, dynamic>? json) {
    return MessageUserModel(
        senderId: json!['senderId'],
        receiverId: json['receiverId'],
        messageImage: json['messageImage'],
        time: json['time'],
        date: json['date'],
        dateTime: json['dateTime'],
        text: json['text']);
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'messageImage': messageImage,
      'date': date,
      'time': time,
      'dateTime': dateTime,
      'text': text,
    };
  }
}

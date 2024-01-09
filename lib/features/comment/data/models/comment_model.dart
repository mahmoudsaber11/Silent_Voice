import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String? name;
  final String? image;
  final String? commentText;
  final String? time;
  final String? date;
  final FieldValue? dateTime;
  final String? uId;

  CommentModel(
      {this.name,
      this.image,
      this.commentText,
      this.time,
      this.date,
      this.dateTime,
      this.uId});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        name: json['name'],
        image: json['image'],
        commentText: json['commentText'],
        time: json['time'],
        date: json['date'],
        dateTime: json['dateTime'],
        uId: json['uId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'commentText': commentText,
      'time': time,
      'dateTime': dateTime,
      'date': date,
      'uId': uId
    };
  }

  @override
  List<Object?> get props =>
      [name, image, commentText, time, dateTime, date, uId];
}

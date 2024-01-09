import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? name;
  String? image;
  String? commentText;
  String? time;
  String? date;
  FieldValue? dateTime;

  CommentModel({
    this.name,
    this.image,
    this.commentText,
    this.time,
    this.date,
    this.dateTime,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    commentText = json['commentText'];
    time = json['time'];
    date = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'commentText': commentText,
      'time': time,
      'dateTime': dateTime,
      'date': date,
    };
  }
}

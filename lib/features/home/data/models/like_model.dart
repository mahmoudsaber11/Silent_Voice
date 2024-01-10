import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class LikesModel extends Equatable {
 final String? uId;
 final String? name;
 final String? image;
 final Timestamp? dateTime;

 const LikesModel({
    this.uId,
    this.name,
    this.image,
    this.dateTime,
  });

  factory LikesModel.fromJson(Map<String, dynamic>? json) {
    return LikesModel(
      uId: json!['uId'],
      name: json['name'],
      image: json['image'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'dateTime': dateTime,
    };
  }

  @override
  List<Object?> get props => [uId, name, image, dateTime];
}

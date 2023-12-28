import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? image;
  final String? cover;
  final String? uId;
  // bool? isEmailVerified;
  final String? bio;

  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.cover,
    this.password,
    required this.uId,
    required this.bio,
    //  required this.isEmailVerified,
  });
  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
        name: json!['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        cover: json['cover'],
        uId: json['uId'],
        bio: json['bio']);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'uId': uId,
      'cover': cover,
      'image': image,
      'bio': bio,
    };
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        password,
        image,
        cover,
        uId,
        bio,
      ];
}

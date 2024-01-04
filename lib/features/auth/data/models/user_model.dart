import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? image;
  final String? uId;
  final String? bio;

  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    this.password,
    required this.uId,
    required this.bio,
  });
  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
        name: json!['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
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
        uId,
        bio,
      ];
}

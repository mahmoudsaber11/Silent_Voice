import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? uId;
  final String? bio;

  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.uId,
    required this.bio,
  });
  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
        name: json!['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        image: json['image'] as String?,
        uId: json['uId'] as String?,
        bio: json['bio'] as String?);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
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
        image,
        uId,
        bio,
      ];
}

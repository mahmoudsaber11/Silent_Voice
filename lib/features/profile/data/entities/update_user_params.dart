import 'package:equatable/equatable.dart';

class UpdateUserParams extends Equatable {
  final String name;
  final String phone;
  final String bio;
  final String? image;

  const UpdateUserParams({
    required this.name,
    required this.phone,
    required this.bio,
    this.image,
  });

  @override
  List<Object?> get props => [name, phone, bio, image];
}

import 'package:equatable/equatable.dart';

class PostParams extends Equatable {
  final String name;
  final String uId;
  final String time;
  final String image;
  final String text;

  PostParams(
      {required this.name,
      required this.uId,
      required this.time,
      required this.image,
      required this.text});

  @override
  List<Object?> get props => [name, uId, time, image, text];
}

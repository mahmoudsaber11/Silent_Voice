import 'package:equatable/equatable.dart';

class PostParams extends Equatable {
  final String date;
  final String time;
  final String? postImage;
  final String text;

  const PostParams(
      {required this.time,
      this.postImage,
      required this.date,
      required this.text});

  @override
  List<Object?> get props => [date, postImage, time, text];
}

import 'package:equatable/equatable.dart';

class CommentPostParams extends Equatable {
  final String? commentText;
  final String? postId;
  final String? time;
  final String? date;

  CommentPostParams({
    required this.commentText,
    required this.postId,
    required this.time,
    required this.date,
  });
  @override
  List<Object?> get props => [commentText, postId, time, date];
}

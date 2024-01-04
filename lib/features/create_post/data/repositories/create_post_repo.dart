import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/create_post/data/entities/post_params.dart';
import 'package:social_app/features/create_post/data/models/post_model.dart';

abstract class PostRepo {
  Future<Either<Failure, PostModel>> createNewPost({
    required PostParams postParams,
  });
}

import 'package:flutter/material.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';

class StoriesUserItem extends StatelessWidget {
  const StoriesUserItem({
    super.key,
    required this.userModel,
  });

  final UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: Colors.grey[300],
      child: CircleAvatar(
        radius: 26,
        backgroundImage: NetworkImage("${userModel!.image}"),
      ),
    );
  }
}

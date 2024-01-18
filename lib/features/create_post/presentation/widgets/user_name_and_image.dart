import 'package:flutter/material.dart';
import 'package:social_app/core/helpers/helper.dart';

class UserNameAndImage extends StatelessWidget {
  const UserNameAndImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage('${Helper.userModel!.image}'),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Text('${Helper.userModel!.name}'),
      ],
    );
  }
}

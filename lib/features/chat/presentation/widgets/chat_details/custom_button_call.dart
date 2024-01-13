import 'package:flutter/material.dart';

class CustomButtonCall extends StatelessWidget {
  const CustomButtonCall({
    super.key,
    required this.icon,
    this.onPressed,
  });
  final IconData icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black38,
      radius: 21,
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Colors.white,
            size: 22,
          )),
    );
  }
}

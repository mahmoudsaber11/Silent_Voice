import 'package:flutter/material.dart';

class NoComments extends StatelessWidget {
  const NoComments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Text(
          "no comments",
        ),
      ),
    );
  }
}

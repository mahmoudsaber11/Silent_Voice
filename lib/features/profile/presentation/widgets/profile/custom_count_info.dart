import 'package:flutter/material.dart';

class CustomCountInfo extends StatelessWidget {
  const CustomCountInfo({
    super.key,
    required this.text,
    required this.count,
  });
  final String text;
  final String count;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            count,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

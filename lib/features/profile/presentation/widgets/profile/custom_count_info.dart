import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_text_style.dart';

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
            style: AppTextStyles.textStyle20.copyWith(color: Colors.black),
          ),
          Text(
            text,
          ),
        ],
      ),
    );
  }
}

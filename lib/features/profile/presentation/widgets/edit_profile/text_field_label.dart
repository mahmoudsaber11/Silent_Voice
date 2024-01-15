import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_text_style.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: AppTextStyles.textStyle15,
        ));
  }
}

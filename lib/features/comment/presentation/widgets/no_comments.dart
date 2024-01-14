import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_text_style.dart';

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
          "No comments...",
          style: AppTextStyles.textStyle16Bold
              .copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

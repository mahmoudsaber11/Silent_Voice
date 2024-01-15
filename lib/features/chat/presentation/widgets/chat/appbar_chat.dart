import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_text_style.dart';

class AppBarChat extends StatelessWidget {
  const AppBarChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Message",
            style: AppTextStyles.textStyle30.copyWith(
              color: Colors.black,
            ),
          ),
          const Icon(Icons.edit_calendar_outlined)
        ],
      ),
    );
  }
}

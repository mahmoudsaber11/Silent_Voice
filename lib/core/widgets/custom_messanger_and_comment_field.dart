import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/widgets/custom_button.dart';

class CustomMessangerAndCommentField extends StatelessWidget {
  const CustomMessangerAndCommentField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefix,
    required this.onPressed,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? prefix;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextFormField(
        controller: controller,
        autofocus: true,
        cursorColor: Colors.black,
        validator: (value) {
          if (value!.isEmpty) {
            return "Write something!";
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[300]),
          prefixIcon: prefix,
          suffixIcon: SizedBox(
            width: 50.w,
            child: CustomButton(onPressed: onPressed),
          ),
          filled: true,
        ),
      ),
    );
  }
}

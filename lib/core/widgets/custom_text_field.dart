import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.keyboardType,
    required this.controller,
    required this.hintText,
    this.validate,
    this.onChange,
    this.isPassword,
    this.suffix,
    this.onSubmit,
    this.autofillHints,
    this.focusNode,
    this.onEditingComplete,
    this.textCapitalization = TextCapitalization.none,
    this.prefix,
  });

  final TextInputType keyboardType;
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  final ValueSetter? onChange;
  final bool? isPassword;
  final Widget? suffix;
  final Function(String submittedText)? onSubmit;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final TextCapitalization textCapitalization;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isPassword ?? false,
        autofillHints: autofillHints,
        validator: validate,
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        onEditingComplete: onEditingComplete,
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        cursorColor: Colors.grey,
        textCapitalization: textCapitalization,
        // textAlign: TextAlign.center,
        decoration: InputDecoration(
          suffixIcon: suffix,
          contentPadding: EdgeInsets.symmetric(vertical: 20.h),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: prefix,
          filled: true,
          fillColor: Colors.grey[50],
          border: _buildTextFieldOutlinedBorder(),
          errorBorder: _buildTextFieldOutlinedBorder(),
          focusedBorder: _buildTextFieldOutlinedBorder(),
          enabledBorder: _buildTextFieldOutlinedBorder(),
        ));
  }

  OutlineInputBorder _buildTextFieldOutlinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: const BorderSide(color: Colors.white),
    );
  }
}

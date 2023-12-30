import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.keyboardType,
    required this.controller,
    this.hintText,
    this.validate,
    this.onChange,
    this.isPassword,
    this.suffix,
    this.onSubmit,
    this.autofillHints,
    this.focusNode,
    this.onEditingComplete,
    this.textCapitalization = TextCapitalization.none,
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
      cursorColor: Colors.black,
      textCapitalization: textCapitalization,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        suffixIcon: suffix,
        contentPadding: EdgeInsets.zero,
        hintText: hintText!,
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }
}

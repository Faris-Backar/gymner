import 'package:flutter/material.dart';

import 'package:gym/core/resources/style_resources.dart';

class TextInputFormField extends StatelessWidget {
  const TextInputFormField({
    super.key,
    this.hint,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.isPasswordVisible,
    this.textInputAction,
    this.textInputType,
    this.onChanged,
    this.fillColor,
    this.borderRadius,
    this.validator,
    this.contentPadding,
    this.hintDecoration,
    this.style,
    this.cursorColor,
    this.maxLines,
  });
  final String? hint;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isPasswordVisible;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final Color? fillColor;
  final double? borderRadius;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintDecoration;
  final TextStyle? style;
  final Color? cursorColor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordVisible ?? false,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscuringCharacter: '*',
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor ?? const Color(0xff3f4f6ff),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
            borderSide: const BorderSide(color: StyleResources.primaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
            borderSide: const BorderSide(color: StyleResources.primaryColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
            borderSide: const BorderSide(color: StyleResources.primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
            borderSide: BorderSide.none),
        hintText: hint,
        hintStyle: hintDecoration,
      ),
      maxLines: maxLines,
      style: style,
      cursorColor: cursorColor,
    );
  }
}

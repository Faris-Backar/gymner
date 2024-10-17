import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;

  const HeaderText(this.text, {super.key, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white),
      textAlign: textAlign,
    );
  }
}

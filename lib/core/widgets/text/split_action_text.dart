import 'package:flutter/material.dart';

class SplitActionText extends StatelessWidget {
  final String text;
  final String actionText;

  const SplitActionText({
    super.key,
    required this.text,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: actionText,
            style: const TextStyle(
              color: Color(0xFF087E8B),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
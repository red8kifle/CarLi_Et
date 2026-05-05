import 'package:flutter/material.dart';

class OutlinedBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;

  const OutlinedBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.5, // 55% of screen
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Color(0xFF087E8B),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ), // no horizontal padding needed since we made the width fixed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Color(0xFF087E8B), width: 1),
          ),
          elevation: 2,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

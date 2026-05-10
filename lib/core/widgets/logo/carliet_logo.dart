import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;

  const Logo({
    super.key,
    this.height = 100, // default value 
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      height: height,
      color: const Color(0xFF087E8B),
    );
  }
}

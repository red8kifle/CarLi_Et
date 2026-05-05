import 'package:flutter/material.dart';
import './features/company/presentation/post_internship_2.dart';

void main() {
  runApp(MyApp()); // starts the app
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      debugShowCheckedModeBanner: false,
      home: PostInternship2(),
    );
  }
}

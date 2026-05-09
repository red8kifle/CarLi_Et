import 'package:flutter/material.dart';

// shared widgets
import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/text/auth_subtitel.dart';
import '../../../core/widgets/input/input_field.dart';

class PostInternship1 extends StatelessWidget {
  const PostInternship1({super.key});

  void _onNextPressed() {
    print("Next");
  }

  void _onGoBackPressed() {
    print("Go Back");
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 35),
              Header(),
              SizedBox(height: screenHeight * 0.03),
              AuthSubtitle(text: 'Enter Internship Info', fontSize: 24),
              SizedBox(height: screenHeight * 0.007),
              InputField(
                label: 'Internship Title',
                hintText: 'Enter internship title',
              ),
              SizedBox(height: 15),
              InputField(label: 'Company Name', hintText: 'Enter company name'),
              SizedBox(height: 15),
              InputField(label: 'Location', hintText: 'Enter your location'),
              SizedBox(height: 15),
              InputField(
                label: 'Internship Type',
                hintText: 'Enter internship type',
              ),
              SizedBox(height: 30),
          
              InputField(label: 'Required skills', hintText: 'React, js, ..'),
          
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedBtn(
                      text: 'Go Back',
                      onPressed: _onGoBackPressed,
                      width: 130,
                    ),
                    SizedBox(width: 10),
                    FilledBtn(
                      text: 'Next',
                      onPressed: _onNextPressed,
                      width: 130,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

//_____________________________________________

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, top: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Logo(height: 60),
            SizedBox(width: 8),
            AppTitle(fontSize: 16, textAlign: TextAlign.left),
          ],
        ),
      ),
    );
  }
}



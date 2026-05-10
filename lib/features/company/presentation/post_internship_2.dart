import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/input/input_field.dart';

class PostInternship2 extends StatelessWidget {
  const PostInternship2({super.key});

  void _onNextPressed(BuildContext context) {
    context.pushNamed('view_internships');
  }

  void _onGoBackPressed(BuildContext context) {
    context.pop();
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
              InputField(
                label: 'Internship Description',
                hintText: 'Enter internship description',
                height: 100,
              ),
              SizedBox(height: 15),
              InputField(label: 'Responsibilities', hintText: ''),
              SizedBox(height: 15),
              InputField(label: 'Duration', hintText: '6 months'),

              SizedBox(height: 15),
              InputField(label: 'Compensation', hintText: 'unpaid'),
              SizedBox(height: 30),

              InputField(label: 'Application Deadline', hintText: '23/03/26'),

              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedBtn(
                      text: 'Go Back',
                      onPressed: () => _onGoBackPressed(context),
                      width: 130,
                    ),
                    SizedBox(width: 10),
                    FilledBtn(
                      text: 'Post Internship',
                      onPressed: () => _onNextPressed(context),
                      width: 160,
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



import 'package:flutter/material.dart';

import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../../core/widgets/text/split_action_text.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/text/auth_subtitel.dart';
import '../../../core/widgets/input/input_field.dart';

class StudentSignup extends StatelessWidget {
  const StudentSignup({super.key});

  void _onCreateAccountPressed() {
    print("Student Sign In");
  }

  void _onGoBackPressed() {
    print("Student Sign In");
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 55),
            Header(),
            SizedBox(height: screenHeight * 0.03),
            AuthSubtitle(text: 'Create a new account', fontSize: 24),
            SizedBox(height: screenHeight * 0.007),
            InputField(label: 'First Name', hintText: 'Enter your first name'),
            SizedBox(height: 15),
            InputField(label: 'Last Name', hintText: 'Enter your last name'),
            SizedBox(height: 15),
            InputField(label: 'Password', hintText: 'Enter your password'),
            SizedBox(height: 15),
            InputField(
              label: 'Re-enter your Password',
              hintText: 'Re-enter your password',
            ),
            SizedBox(height: 30),
            SplitActionText(
              text: "I agree with  ",
              actionText: "Terms and policy",
            ),
            SizedBox(height: 10),
            FilledBtn(
              text: 'Create account',
              onPressed: _onCreateAccountPressed,
            ),
            SizedBox(height: 10),
            OutlinedBtn(text: 'Go Back', onPressed: _onGoBackPressed),
            SizedBox(height: 10),
            SplitActionText(
              text: "If you already have an account  ",
              actionText: "Login",
            ),
          ],
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

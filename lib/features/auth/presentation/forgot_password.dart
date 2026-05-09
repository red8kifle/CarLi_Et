import 'package:flutter/material.dart';

import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/text/auth_subtitel.dart';
import '../../../core/widgets/text/action_text.dart';
import '../../../core/widgets/input/input_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  void _onResetPressed() {
    print("Reset email");
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.09),
              Header(),
              SizedBox(height: screenHeight * 0.04),
              AuthSubtitle(text: 'Reset your password'),
              SizedBox(height: screenHeight * 0.03),
              InputField(
                label: 'Email/username',
                hintText: 'Enter your Email / username',
              ),
              SizedBox(height: 10),
              ActionText(text: 'Login with password'),
              SizedBox(height: 40),
              FilledBtn(text: 'Reset', onPressed: _onResetPressed),
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
    return const Center(
      child: Column(
        children: [
          Logo(),
          SizedBox(height: 1),
          AppTitle(fontSize: 22, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

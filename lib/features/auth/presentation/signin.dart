import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/text/split_action_text.dart';
import '../../../core/widgets/input/input_field.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/text/auth_subtitel.dart';
import '../../../core/widgets/text/action_text.dart';

class Signin extends StatelessWidget {
  final String role; // 'student' or 'company'

  const Signin({super.key, required this.role});

  void _onLoginPressed(BuildContext context) {
    if (role == 'student') {
      context.goNamed('student_home');
    } else {
      context.goNamed('company_home');
    }
  }

  void _onGoBackPressed(BuildContext context) {
    context.pop();
  }

  void _onCreateAccountPressed(BuildContext context) {
    if (role == 'student') {
      context.pushNamed('student_signup');
    } else {
      context.pushNamed('company_signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final fieldWidth = MediaQuery.of(context).size.width * 0.85;
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.09),
              const Header(),
              SizedBox(height: screenHeight * 0.04),
              const AuthSubtitle(text: 'Sign into your account'),
              SizedBox(height: screenHeight * 0.03),
              const InputField(
                label: 'Email/username',
                hintText: 'Enter your Email / username',
              ),
              const SizedBox(height: 15),
              const InputField(label: 'Password', hintText: 'Enter password'),
              const SizedBox(height: 10),

              // Forgot Password
              SizedBox(
                width: fieldWidth,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => context.pushNamed('forgot_password'),
                    child: const ActionText(text: 'Forgot password?'),
                 ),
                ),
              ),


              const SizedBox(height: 40),
              FilledBtn(
                text: 'Login',
                onPressed: () => _onLoginPressed(context),
              ),
              const SizedBox(height: 10),
              OutlinedBtn(
                text: 'Go Back',
                onPressed: () => _onGoBackPressed(context),
              ),
              const SizedBox(height: 30),

              // Create Account
              GestureDetector(
                onTap: () => _onCreateAccountPressed(context),
                child: const SplitActionText(
                  text: "If you don't have an account, ",
                  actionText: "Create new Account",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//─────────────────────────────────────────────────────────────────
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

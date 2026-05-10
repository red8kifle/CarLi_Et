import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/buttons/outlined_btn.dart';
import '../../core/widgets/text/split_action_text.dart';
import '../../core/widgets/logo/carliet_logo.dart';
import '../../core/widgets/text/app_title.dart';
import '../../core/widgets/buttons/filled_btn.dart';
import '../../core/widgets/text/auth_subtitel.dart';
import '../../core/widgets/input/input_field.dart';

class StudentSignup extends StatefulWidget {
  const StudentSignup({super.key});

  @override
  State<StudentSignup> createState() => _StudentSignupState();
}

class _StudentSignupState extends State<StudentSignup> {
  bool _agreedToTerms = false;

  void _onCreateAccountPressed(BuildContext context) {
    if (_agreedToTerms) {
      context.pushNamed('complete_profile_one');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to Terms and Policy first'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 55),
              const Header(),
              SizedBox(height: screenHeight * 0.03),
              const AuthSubtitle(text: 'Create a new account', fontSize: 24),
              SizedBox(height: screenHeight * 0.007),
              const InputField(
                label: 'First Name',
                hintText: 'Enter your first name',
              ),
              const SizedBox(height: 15),
              const InputField(
                label: 'Last Name',
                hintText: 'Enter your last name',
              ),
              const SizedBox(height: 15),
              const InputField(label: 'Email', hintText: 'Enter your email'),
              const SizedBox(height: 15),
              const InputField(
                label: 'Password',
                hintText: 'Enter your password',
              ),
              const SizedBox(height: 15),
              const InputField(
                label: 'Re-enter your Password',
                hintText: 'Re-enter your password',
              ),
              const SizedBox(height: 30),

              // ── CHECKBOX + TERMS ──────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    activeColor: const Color(0xFF087E8B),
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = value ?? false;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () => context.pushNamed('terms'),
                    child: const SplitActionText(
                      text: "I agree with  ",
                      actionText: "Terms and policy",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ── CREATE ACCOUNT BUTTON ─────────────────────
              FilledBtn(
                text: 'Create account',
                onPressed: () => _onCreateAccountPressed(context),
              ),

              const SizedBox(height: 10),

              // ── GO BACK BUTTON ────────────────────────────
              OutlinedBtn(
                text: 'Go Back',
                onPressed: () => context.pushNamed('home'),
              ),

              const SizedBox(height: 10),

              // ── LOGIN LINK ────────────────────────────────
              GestureDetector(
                onTap: () => context.pushNamed('student_signin'),
                child: const SplitActionText(
                  text: "If you already have an account  ",
                  actionText: "Login",
                ),
              ),

              const SizedBox(height: 80),
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

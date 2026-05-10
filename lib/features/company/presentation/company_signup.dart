import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/text/split_action_text.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/text/auth_subtitel.dart';
import '../../../core/widgets/input/input_field.dart';

class CompanySignup extends StatefulWidget {
  const CompanySignup({super.key});

  @override
  State<CompanySignup> createState() => _CompanySignupState();
}

class _CompanySignupState extends State<CompanySignup> {
  bool _agreedToTerms = false;

  void _onCreateAccountPressed(BuildContext context) {
    if (_agreedToTerms) {
      context.pushNamed('company_profile_setup');
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
              SizedBox(height: screenHeight * 0.03),
              const InputField(
                label: 'Company Name',
                hintText: 'Enter your company name',
              ),
              const SizedBox(height: 15),
              const InputField(
                label: 'Email',
                hintText: 'Enter your email',
              ),
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
              FilledBtn(
                text: 'Create account',
                onPressed: () => _onCreateAccountPressed(context),
              ),

              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => context.pushNamed('company_signin'),
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
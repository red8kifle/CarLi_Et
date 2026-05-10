import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/text/auth_subtitel.dart';
import '../../../core/widgets/text/action_text.dart';
import '../../../core/widgets/input/input_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  void _onResetPressed(BuildContext context) {
    context.pop(); // go back after reset
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width * 0.85;
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.09),
              const Header(),
              SizedBox(height: screenHeight * 0.04),
              const AuthSubtitle(text: 'Reset your password'),
              SizedBox(height: screenHeight * 0.03),
              const InputField(
                label: 'Email/username',
                hintText: 'Enter your Email / username',
              ),
              const SizedBox(height: 10),

              // Login with password - go back to signin
              SizedBox(
                width: screenWidth,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: const ActionText(text: 'Login with password'),
                  ),
                ),
              ),

              const SizedBox(height: 40),
              FilledBtn(
                text: 'Reset',
                onPressed: () => _onResetPressed(context),
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

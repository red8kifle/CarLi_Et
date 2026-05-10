import 'package:carli_et/core/widgets/buttons/filled_btn.dart';
import 'package:carli_et/core/widgets/buttons/outlined_btn.dart';
import 'package:carli_et/core/widgets/input/input_field.dart';
import 'package:carli_et/core/widgets/logo/carliet_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthSignUpPage extends StatelessWidget {
  const AuthSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  Logo(height: 35),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "CarLi_ET ",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF747474),
                        ),
                        children: [
                          TextSpan(
                            text: "Internship Management",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Create a new account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF005E5E),
                ),
              ),
              const SizedBox(height: 32),
              Form(
                child: Column(
                  children: [
                    const InputField(
                      label: "First Name",
                      hintText: "Enter your first name",
                      width: 1.0,
                    ),
                    const SizedBox(height: 16),
                    const InputField(
                      label: "Last Name",
                      hintText: "Enter your last name",
                      width: 1.0,
                    ),
                    const SizedBox(height: 16),
                    const InputField(
                      label: "Password",
                      hintText: "Enter your password",
                      width: 1.0,
                    ),
                    const SizedBox(height: 16),
                    const InputField(
                      label: 'Re-enter Password',
                      hintText: "Re-enter your password",
                      width: 1.0,
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text.rich(
                        TextSpan(
                          text: "I agree with ",
                          style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(text: "Terms", style: TextStyle(color: Color(0xFF008080))),
                            TextSpan(text: " and ", style: TextStyle(color: Colors.black)),
                            TextSpan(text: "Privacy", style: TextStyle(color: Color(0xFF008080))),
                          ],
                        ),
                      ),
                      value: false,
                      onChanged: (value) => {},
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 32),
                    FilledBtn(
                      onPressed: () => context.push('/complete-profile-one'),
                      text: 'Create Account',
                      width: double.infinity,
                    ),
                    const SizedBox(height: 12),
                    OutlinedBtn(
                      onPressed: () => context.pop(),
                      text: "Go Back",
                      width: double.infinity,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

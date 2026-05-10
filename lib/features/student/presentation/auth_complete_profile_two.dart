import 'package:carli_et/core/widgets/buttons/filled_btn.dart';
import 'package:carli_et/core/widgets/buttons/outlined_btn.dart';
import 'package:carli_et/core/widgets/input/input_field.dart';
import 'package:carli_et/core/widgets/input/pdf_upload_box_widget.dart';
import 'package:carli_et/core/widgets/step_slide/step_slide_widget.dart';
import 'package:carli_et/core/widgets/logo/carliet_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthCompleteProfileTwo extends StatelessWidget {
  const AuthCompleteProfileTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
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
              const SizedBox(height: 19),
              const StepSlideWidget(currentStep: 2),
              const SizedBox(height: 29),
              const Text(
                'Complete your profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF005E5E),
                ),
              ),
              const SizedBox(height: 29),
              Form(
                child: Column(
                  children: [
                    const InputField(
                      label: 'Skills',
                      hintText: 'Enter your skills',
                      width: 0.85,
                    ),
                    const SizedBox(height: 16),
                    const PdfUploadBoxWidget(label: "Resume / CV"),
                    const SizedBox(height: 16),
                    const InputField(
                      label: "LinkedIn URL",
                      hintText: "LinkedIn URL",
                      width: 0.85,
                    ),
                    const SizedBox(height: 16),
                    const InputField(
                      label: "Portfolio / GitHub",
                      hintText: "URL (Portfolio / GitHub)",
                      width: 0.85,
                    ),
                    const SizedBox(height: 16),
                    const InputField(
                      label: "Languages",
                      hintText: "English",
                      width: 0.85,
                    ),
                    const SizedBox(height: 16),
                    const InputField(
                      label: 'Previous Internships (Optional)',
                      hintText: 'Enter your previous internships',
                      width: 0.85,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: OutlinedBtn(
                      text: "Go Back",
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledBtn(
                      text: 'Next    >',
                      onPressed: () => context.push('/complete-profile-three'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

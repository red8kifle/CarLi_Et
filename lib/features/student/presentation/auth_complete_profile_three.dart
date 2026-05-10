import 'package:carli_et/core/widgets/buttons/filled_btn.dart';
import 'package:carli_et/core/widgets/buttons/outlined_btn.dart';
import 'package:carli_et/core/widgets/input/dropdown_input_field.dart';
import 'package:carli_et/core/widgets/logo/carliet_logo.dart';
import 'package:carli_et/core/widgets/step_slide/step_slide_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthCompleteProfileThree extends StatelessWidget {
  const AuthCompleteProfileThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
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
              const StepSlideWidget(currentStep: 3),
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
                    DropdownField(
                      label: "Work Authorization",
                      hintText: "Citizen, Permanent Resident, etc...",
                      width: 0.85,
                      items: const [
                        "Citizen",
                        "Permanent Resident",
                        "Work visa holder",
                        "Temporary Resident with work permit"
                      ],
                      selectedValue: null,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 16),
                    DropdownField(
                      label: "Need visa sponsorship?",
                      hintText: "Yes / No",
                      width: 0.85,
                      items: const ["Yes", "No"],
                      selectedValue: null,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 16),
                    DropdownField(
                      label: "Gender",
                      hintText: "Male / Female",
                      width: 0.85,
                      items: const ["Male", "Female"],
                      selectedValue: null,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 16),
                    DropdownField(
                      label: "Disability status",
                      hintText: "Yes / No",
                      width: 0.85,
                      items: const ["Yes", "No"],
                      selectedValue: null,
                      onChanged: (value) {},
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
                      onPressed: () {},
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

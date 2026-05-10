import 'package:carli_et/core/widgets/buttons/filled_btn.dart';
import 'package:carli_et/core/widgets/buttons/outlined_btn.dart';
import 'package:carli_et/core/widgets/input/dropdown_input_field.dart';
import 'package:carli_et/core/widgets/input/image_upload_box_widget.dart';
import 'package:carli_et/core/widgets/input/input_field.dart';
import 'package:carli_et/core/widgets/logo/carliet_logo.dart';
import 'package:carli_et/core/widgets/step_slide/step_slide_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthCompleteProfileOne extends StatelessWidget {
  const AuthCompleteProfileOne({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fieldWidth = screenWidth * 0.85;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Logo(height: 35),
                  const SizedBox(width: 10),
                  const Expanded(
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
              const StepSlideWidget(currentStep: 1),
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
              SizedBox(
                width: fieldWidth,
                child: Form(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 120,
                            height: 220,
                            child: ImageUploadBoxWidget(label: "Profile Image"),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: const [
                                InputField(
                                  label: "First Name",
                                  hintText: "Enter first name",
                                ),
                                SizedBox(height: 16),
                                InputField(
                                  label: "Last Name",
                                  hintText: "Enter last name",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const InputField(
                        label: 'University / Institution',
                        hintText: "Choose university",
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: DropdownField(
                              label: 'Year of Study',
                              hintText: "1st Year",
                              items: const [
                                'Freshman (1st Year)',
                                '2nd Year',
                                '3rd Year',
                                '4th Year',
                                '5th Year'
                              ],
                              selectedValue: null,
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: InputField(
                              label: "Expected Year",
                              hintText: "2018 E.C. / 2026 G.C.",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const InputField(
                        label: "Current GPA (Optional)",
                        hintText: "GPA",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: fieldWidth,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedBtn(
                        text: "Go Back",
                        onPressed: () => context.goNamed('student_signin'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledBtn(
                        text: 'Next    >',
                        onPressed: () => context.pushNamed('complete_profile_two'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
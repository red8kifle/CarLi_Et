import 'package:carli_et/core/widgets/buttons/filled_btn.dart';
import 'package:carli_et/core/widgets/buttons/outlined_btn.dart';
import 'package:carli_et/core/widgets/input/dropdown_input_field.dart';
import 'package:carli_et/core/widgets/logo/carliet_logo.dart';
import 'package:carli_et/core/widgets/step_slide/step_slide_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/student_profile_provider.dart';

// ✅ CORRECT CLASS NAME - AuthCompleteProfileThree (NOT Two)
class AuthCompleteProfileThree extends ConsumerStatefulWidget {
  const AuthCompleteProfileThree({super.key});

  @override
  ConsumerState<AuthCompleteProfileThree> createState() =>
      _AuthCompleteProfileThreeState();
}

class _AuthCompleteProfileThreeState
    extends ConsumerState<AuthCompleteProfileThree> {
  String? _workAuth;
  String? _visaSponsorship;
  String? _gender;
  String? _disability;
  bool _isLoading = false;

  Future<void> _onFinishPressed() async {
    setState(() => _isLoading = true);

    final existingData = ref.read(studentProfileProvider);

    final finalProfile = {
      ...existingData,
      'work_authorization': _workAuth ?? '',
      'visa_sponsorship': _visaSponsorship ?? '',
      'gender': _gender ?? '',
      'disability_status': _disability ?? '',
    };

    ref.read(studentProfileProvider.notifier).update((state) => finalProfile);

    setState(() => _isLoading = false);

    if (mounted) {
      context.pushReplacementNamed('student_home');
    }
  }

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
                children: const [
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
              SizedBox(
                width: fieldWidth,
                child: Column(
                  children: [
                    DropdownField(
                      label: "Work Authorization",
                      hintText: "Citizen, Permanent Resident, etc...",
                      items: const [
                        "Citizen",
                        "Permanent Resident",
                        "Work visa holder",
                        "Temporary Resident with work permit",
                      ],
                      selectedValue: _workAuth,
                      onChanged: (v) => setState(() => _workAuth = v),
                    ),
                    const SizedBox(height: 16),
                    DropdownField(
                      label: "Need visa sponsorship?",
                      hintText: "Yes / No",
                      items: const ["Yes", "No"],
                      selectedValue: _visaSponsorship,
                      onChanged: (v) => setState(() => _visaSponsorship = v),
                    ),
                    const SizedBox(height: 16),
                    DropdownField(
                      label: "Gender",
                      hintText: "Male / Female",
                      items: const ["Male", "Female"],
                      selectedValue: _gender,
                      onChanged: (v) => setState(() => _gender = v),
                    ),
                    const SizedBox(height: 16),
                    DropdownField(
                      label: "Disability status",
                      hintText: "Yes / No",
                      items: const ["Yes", "No"],
                      selectedValue: _disability,
                      onChanged: (v) => setState(() => _disability = v),
                    ),
                  ],
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
                        onPressed: () => context.pop(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF087E8B),
                              ),
                            )
                          : FilledBtn(
                              text: 'Finish    ',
                              onPressed: _onFinishPressed,
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

import 'package:carli_et/core/widgets/buttons/filled_btn.dart';
import 'package:carli_et/core/widgets/buttons/outlined_btn.dart';
import 'package:carli_et/core/widgets/input/dropdown_input_field.dart';
import 'package:carli_et/core/widgets/input/image_upload_box_widget.dart';
import 'package:carli_et/core/widgets/input/input_field.dart';
import 'package:carli_et/core/widgets/logo/carliet_logo.dart';
import 'package:carli_et/core/widgets/step_slide/step_slide_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import '../application/student_profile_provider.dart';

class AuthCompleteProfileOne extends ConsumerStatefulWidget {
  const AuthCompleteProfileOne({super.key});

  @override
  ConsumerState<AuthCompleteProfileOne> createState() =>
      _AuthCompleteProfileOneState();
}

class _AuthCompleteProfileOneState
    extends ConsumerState<AuthCompleteProfileOne> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _universityCtrl = TextEditingController();
  final _gpaCtrl = TextEditingController();
  final _expectedYearCtrl = TextEditingController();
  String? _selectedYear;
  File? _profileImage;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _universityCtrl.dispose();
    _gpaCtrl.dispose();
    _expectedYearCtrl.dispose();
    super.dispose();
  }

  void _onImageSelected(File? image) {
    setState(() {
      _profileImage = image;
    });
    ref.read(studentImageFileProvider.notifier).state = image;
  }

  void _onNextPressed() {
    if (_firstNameCtrl.text.trim().isEmpty ||
        _lastNameCtrl.text.trim().isEmpty ||
        _universityCtrl.text.trim().isEmpty ||
        _selectedYear == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final profileData = {
      'firstName': _firstNameCtrl.text.trim(),
      'lastName': _lastNameCtrl.text.trim(),
      'fullName': '${_firstNameCtrl.text.trim()} ${_lastNameCtrl.text.trim()}',
      'university': _universityCtrl.text.trim(),
      'year': _selectedYear,
      'expectedYear': _expectedYearCtrl.text.trim(),
      'gpa': _gpaCtrl.text.trim(),
    };

    ref
        .read(studentProfileProvider.notifier)
        .update((state) => {...state, ...profileData});
    context.pushNamed('complete_profile_two');
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
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          child: ImageUploadBoxWidget(
                            label: "Profile Image",
                            onImageSelected: _onImageSelected,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              InputField(
                                label: "First Name",
                                hintText: "Enter first name",
                                controller: _firstNameCtrl,
                              ),
                              const SizedBox(height: 16),
                              InputField(
                                label: "Last Name",
                                hintText: "Enter last name",
                                controller: _lastNameCtrl,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    InputField(
                      label: 'University / Institution',
                      hintText: "Choose university",
                      controller: _universityCtrl,
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
                              '5th Year',
                            ],
                            selectedValue: _selectedYear,
                            onChanged: (v) => setState(() => _selectedYear = v),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InputField(
                            label: "Expected Year",
                            hintText: "2018 E.C. / 2026 G.C.",
                            controller: _expectedYearCtrl,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    InputField(
                      label: "Current GPA (Optional)",
                      hintText: "GPA",
                      controller: _gpaCtrl,
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
                        onPressed: () => context.goNamed('student_signin'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledBtn(
                        text: 'Next    >',
                        onPressed: _onNextPressed,
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

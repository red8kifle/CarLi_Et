import 'dart:io';
import 'package:carli_et/features/auth/application/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../../core/widgets/input/input_field.dart';
import '../../../core/widgets/input/pdf_upload_box_widget.dart';
import '../../../core/widgets/step_slide/step_slide_widget.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/network/api_client.dart';
import '../../../core/providers/providers.dart';
import '../application/student_profile_provider.dart';

class AuthCompleteProfileTwo extends ConsumerStatefulWidget {
  const AuthCompleteProfileTwo({super.key});

  @override
  ConsumerState<AuthCompleteProfileTwo> createState() =>
      _AuthCompleteProfileTwoState();
}

class _AuthCompleteProfileTwoState
    extends ConsumerState<AuthCompleteProfileTwo> {
  final _skillsCtrl = TextEditingController();
  final _linkedInCtrl = TextEditingController();
  final _portfolioCtrl = TextEditingController();
  final _languagesCtrl = TextEditingController();
  final _prevCtrl = TextEditingController();

  File? _resumeFile;
  String? _resumeFileName;
  bool _isUploading = false;
  bool _isNextPressed = false;

  void _onResumeSelected(File? file) {
    setState(() {
      _resumeFile = file;
      if (file != null) {
        _resumeFileName = file.path.split('/').last;
      } else {
        _resumeFileName = null;
      }
    });
  }

  Future<String?> _uploadResume() async {
    if (_resumeFile == null) return null;

    try {
      final apiClient = ref.read(apiClientProvider);
      final token = ref.read(authNotifierProvider).value?.token;

      if (token == null) return null;

      String fileName = _resumeFile!.path.split('/').last;

      FormData formData = FormData.fromMap({
        'resume': await MultipartFile.fromFile(
          _resumeFile!.path,
          filename: fileName,
          contentType: MediaType('application', 'pdf'),
        ),
      });

      final response = await apiClient.dio.post(
        '/upload/resume',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.data != null && response.data['url'] != null) {
        return response.data['url'];
      }
      return null;
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }

  Future<void> _saveProfileToBackend(Map<String, dynamic> profileData) async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final token = ref.read(authNotifierProvider).value?.token;

      if (token == null) return;

      String? resumeUrl;
      if (_resumeFile != null) {
        resumeUrl = await _uploadResume();
      }

      await apiClient.dio.put(
        '/auth/profile/student',
        data: {
          'skills': profileData['skills'],
          'bio': profileData['languages'],
          'resume_url': resumeUrl,
        },
      );
    } catch (e) {
      print('Save profile error: $e');
    }
  }

  void _onNextPressed() async {
    if (_isNextPressed) return;

    setState(() {
      _isNextPressed = true;
      _isUploading = true;
    });

    final profileData = {
      'skills': _skillsCtrl.text.trim(),
      'linkedin_url': _linkedInCtrl.text.trim(),
      'portfolio_url': _portfolioCtrl.text.trim(),
      'languages': _languagesCtrl.text.trim(),
      'prev_internship': _prevCtrl.text.trim(),
    };

    ref
        .read(studentProfileProvider.notifier)
        .update((state) => {...state, ...profileData});

    await _saveProfileToBackend(profileData);

    setState(() => _isUploading = false);

    if (mounted) {
      context.pushNamed('complete_profile_three');
    }
  }

  void _onGoBack() {
    if (!_isUploading) {
      context.pop();
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
              SizedBox(
                width: fieldWidth,
                child: Column(
                  children: [
                    InputField(
                      label: 'Skills',
                      hintText: 'e.g. Flutter, Python, SQL',
                      controller: _skillsCtrl,
                    ),
                    const SizedBox(height: 16),
                    PdfUploadBoxWidget(
                      label: "Resume / CV",
                      onFileSelected: _onResumeSelected,
                    ),
                    if (_resumeFileName != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Resume uploaded: $_resumeFileName',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    InputField(
                      label: "LinkedIn URL",
                      hintText: "LinkedIn URL",
                      controller: _linkedInCtrl,
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      label: "Portfolio / GitHub",
                      hintText: "URL (Portfolio / GitHub)",
                      controller: _portfolioCtrl,
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      label: "Languages",
                      hintText: "English, Amharic...",
                      controller: _languagesCtrl,
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      label: 'Previous Internships (Optional)',
                      hintText: 'Enter your previous internships',
                      controller: _prevCtrl,
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
                        onPressed:
                            _onGoBack, // Fixed: Use method instead of inline condition
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _isUploading
                          ? const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: Color(0xFF087E8B),
                                    strokeWidth: 2,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Uploading...',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          : FilledBtn(
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

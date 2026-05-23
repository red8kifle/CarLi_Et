import 'package:carli_et/features/auth/application/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/input/input_field.dart';
import '../../../core/widgets/input/image_upload_box_widget.dart';
import '../../../core/network/api_client.dart';
import '../../../core/providers/providers.dart';
import '../application/company_profile_provider.dart';

class CompanyProfileSetup extends ConsumerStatefulWidget {
  const CompanyProfileSetup({super.key});

  @override
  ConsumerState<CompanyProfileSetup> createState() =>
      _CompanyProfileSetupState();
}

class _CompanyProfileSetupState extends ConsumerState<CompanyProfileSetup> {
  final _companyNameCtrl = TextEditingController();
  final _industryCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  File? _logoImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final existingData = ref.read(companyProfileProvider);
    _companyNameCtrl.text = existingData['company_name'] ?? '';
    _industryCtrl.text = existingData['industry'] ?? '';
    _locationCtrl.text = existingData['location'] ?? '';
    _descriptionCtrl.text = existingData['description'] ?? '';
  }

  Future<String?> _uploadLogo(File imageFile) async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final token = ref.read(authNotifierProvider).value?.token;

      if (token == null) return null;

      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        'logo': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ),
      });

      final response = await apiClient.dio.post(
        '/upload/company-logo',
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

  void _onLogoSelected(File? image) {
    setState(() {
      _logoImage = image;
    });
    ref.read(companyLogoFileProvider.notifier).state = image;
  }

  Future<void> _onFinishPressed() async {
    setState(() => _isLoading = true);

    // Upload logo if selected
    String? logoUrl;
    if (_logoImage != null) {
      logoUrl = await _uploadLogo(_logoImage!);
    }

    final profileData = {
      'company_name': _companyNameCtrl.text.trim(),
      'industry': _industryCtrl.text.trim(),
      'location': _locationCtrl.text.trim(),
      'description': _descriptionCtrl.text.trim(),
      'logo_url': logoUrl,
    };

    // Save to provider
    ref
        .read(companyProfileProvider.notifier)
        .update((state) => {...state, ...profileData});

    // Save to backend
    try {
      final apiClient = ref.read(apiClientProvider);
      await apiClient.dio.put('/auth/profile/company', data: profileData);
    } catch (e) {
      print('Save to backend error: $e');
    }

    setState(() => _isLoading = false);

    if (mounted) {
      context.pushReplacementNamed('company_home');
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
              const SizedBox(height: 48),
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
              const SizedBox(height: 32),
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
                            label: "Company Logo",
                            onImageSelected: _onLogoSelected,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              InputField(
                                label: "Company Name",
                                hintText: "Enter company name",
                                width: 1.0,
                                controller: _companyNameCtrl,
                              ),
                              const SizedBox(height: 16),
                              InputField(
                                label: "Industry",
                                hintText: "Enter Industry",
                                width: 1.0,
                                controller: _industryCtrl,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      label: 'Location',
                      hintText: 'Location',
                      width: 1.0,
                      controller: _locationCtrl,
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      label: 'Description',
                      hintText: 'Enter company description',
                      width: 1.0,
                      height: 100,
                      controller: _descriptionCtrl,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: fieldWidth,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF087E8B),
                        ),
                      )
                    : FilledBtn(
                        text: 'Finish    >',
                        onPressed: _onFinishPressed,
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

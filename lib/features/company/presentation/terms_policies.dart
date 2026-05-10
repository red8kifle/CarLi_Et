import 'package:flutter/material.dart';
import 'package:carli_et/core/widgets/logo/carliet_logo.dart';
import 'package:go_router/go_router.dart';
import 'package:carli_et/core/widgets/text/split_action_text.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Logo(height: 50),
                  const SizedBox(width: 15),
                  const Text(
                    "CarLi_ET Internship\nManagement",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Terms and Conditions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _TermsSection(
                        "1. Introduction",
                        "Welcome to the CarLi_Et Internship Management Platform. By accessing or using this application, you agree to be bound by these Terms and Conditions in their entirety. This platform is designed specifically to connect ambitious university students across Ethiopia with high-quality internship opportunities offered by our network of registered companies and institutions. If you do not agree to any part of these terms, please refrain from using the application immediately.",
                      ),
                      _TermsSection(
                        "2. Eligibility and Registration",
                        "This platform is intended for currently enrolled university or college students in Ethiopia who are actively seeking professional internship placements to further their careers. Registered companies and institutions must provide valid credentials to offer internship positions to our user base. By completing the registration process, you confirm that all information provided is accurate, current, and complete at all times. Users must be at least 18 years old or have explicit institutional approval to engage with the services provided.",
                      ),
                      _TermsSection(
                        "3. Privacy and Data Collection",
                        "CarLi_Et prioritizes your privacy by collecting personal information such as your name, academic records, GPA, and professional skills solely to facilitate placements. We maintain a strict policy where your personal data will never be sold to third parties for marketing or advertising purposes. Data is only shared with verified institutions and companies when it is necessary to support and process your specific internship applications. By using this app, you provide explicit consent to this data usage and may request data deletion at any time.",
                      ),
                      _TermsSection(
                        "4. User Conduct and Responsibility",
                        "All users are expected to interact respectfully and professionally within the platform to maintain a productive environment for everyone. Harassment, discrimination, or any form of abusive behavior toward other users, company representatives, or platform administrators is strictly prohibited. You are solely responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your profile. CarLi_Et reserves the right to suspend or terminate accounts that violate these community standards or provide false information.",
                      ),
                      _TermsSection(
                        "5. Limitation of Liability",
                        "CarLi_Et acts as an intermediary service and does not guarantee that every user will secure an internship placement through the platform. The final decision to accept or reject an application lies exclusively with the hosting company or institution based on their specific requirements. We are not liable for any loss, damage, or inconvenience resulting from your use of the platform, including technical issues or missed opportunities. The service is provided on an 'as is' basis, and we do not guarantee uninterrupted or error-free performance.",
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 25),
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: isChecked,
                              activeColor: const Color(0xFF087E8B),
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: SplitActionText(
                              text: "I have read and agreed to the ",
                              actionText: "Terms and Conditions.",
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: 280,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isChecked
                              ? const Color(0xFF087E8B)
                              : Colors.grey.shade400,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: isChecked
                            ? () {
                                context.goNamed('company_profile_setup');
                              }
                            : null,
                        child: const Text(
                          "Accept & Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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

class _TermsSection extends StatelessWidget {
  final String title;
  final String content;

  const _TermsSection(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

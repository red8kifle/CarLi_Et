import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/text/auth_subtitel.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/input/input_field.dart';

class CompanyProfileSetup extends StatelessWidget {
  const CompanyProfileSetup({super.key});

  void _onFinishPressed(BuildContext context) {
    context.pushNamed('company_home');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 75),
            const Header(),
            SizedBox(height: screenHeight * 0.07),

            const AuthSubtitle(text: 'Complete your profile', fontSize: 24),

            SizedBox(height: screenHeight * 0.03),

            FirstInputs(),

            SizedBox(height: screenHeight * 0.03),

            const InputField(label: 'Location', hintText: 'Location'),

            const SizedBox(height: 15),

            const InputField(
              label: 'Description',
              hintText: 'Enter company description',
            ),

            const SizedBox(height: 25),

            FilledBtn(
              text: 'Finish  >',
              onPressed: () => _onFinishPressed(context),
            ),
          ],
        ),
      ),
    );
  }
}

// _____________________________________________

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, top: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Logo(height: 60),
            SizedBox(width: 8),
            AppTitle(fontSize: 16, textAlign: TextAlign.left),
          ],
        ),
      ),
    );
  }
}

// _____________________________________________

class FirstInputs extends StatelessWidget {
  const FirstInputs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CompanyLogoField(),
        const SizedBox(width: 16),
        Column(
          children: [
            const InputField(
              label: 'Company Name',
              hintText: 'Enter company name',
              width: 0.40,
            ),

            const SizedBox(height: 5),

            const InputField(
              label: 'Industry',
              hintText: 'Enter Industry',
              width: 0.40,
            ),
          ],
        ),
      ],
    );
  }
}

//___________________________________________________
class CompanyLogoField extends StatelessWidget {
  CompanyLogoField({super.key});

  //  fixed values
  static const double leftMargin = 30;
  static const double rightMargin = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: leftMargin, right: rightMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Company Logo",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),

          GestureDetector(
            child: Container(
              height: 150,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo_outlined, size: 28),
                  SizedBox(height: 6),
                  Text("Upload", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

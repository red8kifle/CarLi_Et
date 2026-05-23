import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/input/input_field.dart';
import '../../../core/widgets/input/dropdown_input_field.dart';

final postInternshipProvider = StateProvider<Map<String, dynamic>>((ref) => {});

class PostInternship1 extends ConsumerStatefulWidget {
  const PostInternship1({super.key});

  @override
  ConsumerState<PostInternship1> createState() => _PostInternship1State();
}

class _PostInternship1State extends ConsumerState<PostInternship1> {
  final _titleCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  String? _type;
  final _skillsCtrl = TextEditingController();
  final _requirementsCtrl = TextEditingController();

  void _onNextPressed() {
    if (_titleCtrl.text.isEmpty ||
        _locationCtrl.text.isEmpty ||
        _type == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ref.read(postInternshipProvider.notifier).state = {
      'title': _titleCtrl.text,
      'location': _locationCtrl.text,
      'type': _type,
      'skills': _skillsCtrl.text,
      'requirements': _requirementsCtrl.text,
    };

    context.pushNamed('post_internship_2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 35),
              const _Header(),
              const SizedBox(height: 30),
              const Text(
                'Post New Internship',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF087E8B),
                ),
              ),
              const SizedBox(height: 30),
              InputField(
                label: 'Internship Title',
                hintText: 'e.g. Software Engineering Intern',
                controller: _titleCtrl,
              ),
              const SizedBox(height: 16),
              InputField(
                label: 'Location',
                hintText: 'e.g. Addis Ababa',
                controller: _locationCtrl,
              ),
              const SizedBox(height: 16),
              DropdownField(
                label: 'Type',
                hintText: 'Select type',
                items: const ['Remote', 'On-site', 'Hybrid'],
                selectedValue: _type,
                onChanged: (v) => setState(() => _type = v),
              ),
              const SizedBox(height: 16),
              InputField(
                label: 'Required Skills',
                hintText: 'e.g. Flutter, Python, SQL',
                controller: _skillsCtrl,
              ),
              const SizedBox(height: 16),
              InputField(
                label: 'Requirements',
                hintText: 'List additional requirements',
                controller: _requirementsCtrl,
                height: 80,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedBtn(
                    text: 'Cancel',
                    onPressed: () => context.pop(),
                    width: 120,
                  ),
                  const SizedBox(width: 12),
                  FilledBtn(
                    text: 'Next →',
                    onPressed: _onNextPressed,
                    width: 120,
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

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Logo(height: 50),
            SizedBox(width: 8),
            AppTitle(fontSize: 16, textAlign: TextAlign.left),
          ],
        ),
      ),
    );
  }
}

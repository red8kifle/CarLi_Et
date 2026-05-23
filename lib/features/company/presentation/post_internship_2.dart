import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/input/input_field.dart';
import '../../internships/application/internship_notifier.dart';
import 'post_internship_1.dart';

class PostInternship2 extends ConsumerStatefulWidget {
  const PostInternship2({super.key});

  @override
  ConsumerState<PostInternship2> createState() => _PostInternship2State();
}

class _PostInternship2State extends ConsumerState<PostInternship2> {
  final _descriptionCtrl = TextEditingController();
  final _responsibilitiesCtrl = TextEditingController();
  final _durationCtrl = TextEditingController();
  final _compensationCtrl = TextEditingController();
  final _deadlineCtrl = TextEditingController();
  bool _isPosting = false;

  Future<void> _onPostPressed() async {
    final page1Data = ref.read(postInternshipProvider);

    final fullData = {
      'title': page1Data['title'],
      'location': page1Data['location'],
      'type': page1Data['type'],
      'skills': page1Data['skills'],
      'requirements': page1Data['requirements'],
      'description': _descriptionCtrl.text,
      'deadline': _deadlineCtrl.text,
    };

    setState(() => _isPosting = true);

    final success = await ref
        .read(internshipNotifierProvider.notifier)
        .createInternship(fullData);

    setState(() => _isPosting = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Internship posted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      // Refresh both lists
      ref.read(internshipNotifierProvider.notifier).fetchAll();
      ref.read(internshipNotifierProvider.notifier).fetchMyInternships();
      context.goNamed('view_internships');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to post internship. Try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
              InputField(
                label: 'Internship Description',
                hintText: 'Describe the role',
                height: 100,
                controller: _descriptionCtrl,
              ),
              const SizedBox(height: 16),
              InputField(
                label: 'Responsibilities',
                hintText: 'List key responsibilities',
                controller: _responsibilitiesCtrl,
              ),
              const SizedBox(height: 16),
              InputField(
                label: 'Duration',
                hintText: 'e.g. 3 months, 6 months',
                controller: _durationCtrl,
              ),
              const SizedBox(height: 16),
              InputField(
                label: 'Compensation',
                hintText: 'Paid / Unpaid / Stipend',
                controller: _compensationCtrl,
              ),
              const SizedBox(height: 16),
              InputField(
                label: 'Application Deadline',
                hintText: 'YYYY-MM-DD',
                controller: _deadlineCtrl,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedBtn(
                    text: 'Go Back',
                    onPressed: () => context.pop(),
                    width: 130,
                  ),
                  const SizedBox(width: 12),
                  _isPosting
                      ? const CircularProgressIndicator(
                          color: Color(0xFF087E8B),
                        )
                      : FilledBtn(
                          text: 'Post Internship',
                          onPressed: _onPostPressed,
                          width: 160,
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

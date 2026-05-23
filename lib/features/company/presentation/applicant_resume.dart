import 'package:carli_et/domain/entities/application_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../applications/application/application_notifier.dart';

class ApplicantResume extends ConsumerStatefulWidget {
  final ApplicationEntity application;

  const ApplicantResume({super.key, required this.application});

  @override
  ConsumerState<ApplicantResume> createState() => _ApplicantResumeState();
}

class _ApplicantResumeState extends ConsumerState<ApplicantResume> {
  bool _isProcessing = false;
  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.application.status;
  }

  Future<void> _updateStatus(String newStatus) async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      final success = await ref
          .read(applicationNotifierProvider.notifier)
          .updateStatus(widget.application.id, newStatus);

      if (success) {
        setState(() {
          _currentStatus = newStatus;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Application ${newStatus == 'accepted' ? 'accepted' : 'rejected'}',
              ),
              backgroundColor: newStatus == 'accepted'
                  ? Colors.green
                  : Colors.orange,
            ),
          );
          // Wait a moment then go back
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            Navigator.pop(context);
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update status'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _onAccept() {
    if (!_isProcessing) {
      _updateStatus('accepted');
    }
  }

  void _onReject() {
    if (!_isProcessing) {
      _updateStatus('rejected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final app = widget.application;
    final isPending = _currentStatus == 'pending';
    final isAccepted = _currentStatus == 'accepted';
    final isRejected = _currentStatus == 'rejected';

    // Parse skills - handle different formats
    String skillsText = app.skills ?? '';
    if (skillsText.isEmpty) {
      skillsText = 'No skills listed';
    }

    final skillsList = skillsText.split(',').map((s) => s.trim()).toList();
    final nonEmptySkills = skillsList
        .where((s) => s.isNotEmpty && s != 'No skills listed')
        .toList();
    final displaySkills = nonEmptySkills.isNotEmpty
        ? nonEmptySkills
        : ['No skills listed'];

    // Format year display
    String yearText = 'N/A';
    if (app.year != null) {
      yearText = '${app.year}th Year';
    }

    // Format GPA display
    String gpaText = app.gpa ?? 'N/A';
    if (gpaText.isEmpty) {
      gpaText = 'N/A';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF087E8B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Applicant Resume',
          style: TextStyle(
            color: Color(0xFF087E8B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Chip (only show if not pending)
            if (!isPending)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isAccepted
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isAccepted ? 'ACCEPTED' : 'REJECTED',
                  style: TextStyle(
                    color: isAccepted ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Student Name and University
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF087E8B),
                  ),
                  child: Center(
                    child: Text(
                      app.studentName?.isNotEmpty == true
                          ? app.studentName![0].toUpperCase()
                          : 'S',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.studentName ?? 'Student',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        app.university ?? 'University not specified',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Year of Study and CGPA
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Year of study: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: yearText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'CGPA: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: gpaText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Skills Section
            const Text(
              'Skills',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ...displaySkills.map(
              (skill) => Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Expanded(
                      child: Text(
                        skill,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Previous Internships Section
            const Text(
              'Previous Internships',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Expanded(
                    child: Text(
                      'Software Engineering Intern — NexaTech Solutions',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Expanded(
                    child: Text(
                      'Backend Developer Intern — CodeCraft Technologies',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Expanded(
                    child: Text(
                      'IT Support Intern — Bright Systems Ltd.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Download Resume Button
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.github,
                    color: Colors.black87,
                    size: 38,
                  ),
                  const SizedBox(width: 10),
                  const FaIcon(
                    FontAwesomeIcons.linkedin,
                    color: Color(0xFF0077B5),
                    size: 38,
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    width: 180,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        if (app.resumeUrl != null &&
                            app.resumeUrl!.isNotEmpty) {
                          // Show resume URL for now (can implement actual download later)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Resume available at: ${app.resumeUrl}',
                              ),
                              backgroundColor: Colors.orange,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No resume uploaded by this student',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.black54, width: 1),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(
                        Icons.insert_drive_file_outlined,
                        size: 18,
                      ),
                      label: const Text(
                        'Download Resume',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Accept/Reject Buttons (only show if status is pending)
            if (isPending)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Accept Button
                  _isProcessing
                      ? const SizedBox(
                          width: 130,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF087E8B),
                            ),
                          ),
                        )
                      : FilledBtn(
                          text: 'Accept',
                          width: 130,
                          onPressed: _onAccept,
                        ),
                  const SizedBox(width: 16),
                  // Reject Button
                  _isProcessing
                      ? const SizedBox(
                          width: 130,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.red),
                          ),
                        )
                      : OutlinedBtn(
                          text: 'Reject',
                          width: 130,
                          onPressed: _onReject,
                        ),
                ],
              ),

            // Show message if already accepted or rejected
            if (!isPending)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isAccepted
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isAccepted
                        ? '✓ This application has been ACCEPTED'
                        : '✗ This application has been REJECTED',
                    style: TextStyle(
                      color: isAccepted ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

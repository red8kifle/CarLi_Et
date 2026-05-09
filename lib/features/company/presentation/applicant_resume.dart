import 'package:go_router/go_router.dart';
import 'package:carli_et/core/widgets/buttons/outlined_btn.dart';
import 'package:flutter/material.dart';
import 'package:carli_et/core/widgets/buttons/filled_btn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicantResume extends StatelessWidget {
  const ApplicantResume({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //App bar─────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF087E8B)),
          onPressed: () => context.goNamed('company_home'),
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

      //Body ────────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Applicant info ────────────────────────────
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Addis Ababa University',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            //Year of study and CGPA ──────────────────────
            Row(
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Year of study: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: '3rd yr',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24),

                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'CGPA: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: '3.78',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Skills ───────────────────────────────────
            const Text(
              'Skills',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            const _BulletItem(
              text:
                  'Programming: Python, Java, C++\n(adjust based on what you know)',
            ),
            const _BulletItem(
              text:
                  'Data Structures & Algorithms\n(arrays, linked lists, hashing, trees)',
            ),
            const _BulletItem(text: 'Object-Oriented Programming (OOP)'),
            const _BulletItem(text: 'SQL & Database Design'),
            const _BulletItem(text: 'Basic Networking Concepts'),

            const SizedBox(height: 20),

            // Previous Internships ────────────────────
            const Text(
              'Previous Internships',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            const _BulletItem(
              text: 'Software Engineering Intern — NexaTech Solutions',
            ),
            const _BulletItem(
              text: 'Backend Developer Intern — CodeCraft Technologies',
            ),
            const _BulletItem(text: 'IT Support Intern — Bright Systems Ltd.'),

            const SizedBox(height: 24),

            // Social and Download resume──────────────────
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      onPressed: () {},
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

            // Accept + Reject Buttons ─────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Accept → go to view applicants
                FilledBtn(
                  text: 'Accept',
                  width: 130,
                  onPressed: () => context.goNamed('view_applicants'),
                ),

                const SizedBox(width: 16),

                // Reject → go to view applicants
                OutlinedBtn(
                  text: 'Reject',
                  width: 130,
                  onPressed: () => context.goNamed('view_applicants'),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Bullet Item ─────────────────────────────────────────────────────
class _BulletItem extends StatelessWidget {
  final String text;

  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

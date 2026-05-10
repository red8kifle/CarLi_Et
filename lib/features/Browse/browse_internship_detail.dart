import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/buttons/outlined_btn.dart';

class BrowseInternshipDetail extends StatelessWidget {
  const BrowseInternshipDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // TOP SECTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: const BoxDecoration(
                color: Color(0xFF0A8785),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: Column(
                children: [
                  // TOP BAR
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),

                      const Spacer(),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // COMPANY INFO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/ethiotelecom.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),

                            Text(
                              'Ethio telecom',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Software Engineering Intern',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // INFO BOXES
                  Row(
                    children: [
                      Expanded(
                        child: _infoCard(
                          Icons.location_on_outlined,
                          'Location',
                          'Addis Ababa',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _infoCard(
                          Icons.calendar_today_outlined,
                          'Duration',
                          '3 Months',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _infoCard(Icons.attach_money, 'Stipend', 'Paid'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // BODY CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About the Role',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Lorem ipsum a dolor sit amet, consectetur adipiscing elit, sed diam nonomous high incididunt position, coming with Lorem issum, toopnoy, and senir service and cell your consissins.',
                      style: TextStyle(fontSize: 12, height: 1.5),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Key Responsibilities',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      '• Development of new features to encieyore and updates.\n'
                      '• Collaboration with senior engineers to remote and endioromonis.\n'
                      '• Unit testing and oreasu unit testing.',
                      style: TextStyle(fontSize: 12, height: 1.6),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Requirements',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      '• Minimum 3.0 GPA (link; data left)\n'
                      '• Proficiency in Python/Java and proficiency\n'
                      '• Strong problem-solving skills to understanding',
                      style: TextStyle(fontSize: 12, height: 1.6),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Deadline: Apply before- 2/03/2026',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 45),

                    Center(
                      child: OutlinedBtn(
                        text: ' < Back ',
                        onPressed: () => context.goNamed('browse_as_guest'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: const Color(0xFF0A8785)),

              const SizedBox(width: 4),

              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

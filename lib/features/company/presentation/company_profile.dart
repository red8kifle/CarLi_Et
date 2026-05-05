import 'package:flutter/material.dart';
import 'package:carli_et/core/widgets/buttons/filled_btn.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //APP BAR ─────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 45,
                color: const Color(0xFF087E8B),
              ),
              const SizedBox(width: 8),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: 'CarLi_ET ',
                      style: TextStyle(color: Color(0xFF087E8B)),
                    ),
                    TextSpan(
                      text: 'Internship\nManagement',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //BODY ────────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Profile Info',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF087E8B),
                  ),
                ),
                FilledBtn(text: 'Edit Profile', width: 100, onPressed: () {}),
              ],
            ),

            const SizedBox(height: 24),

            //COMPANY LOGO + INFO ───────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Box
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Company Logo',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 25),

                // Company Details
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 28),
                    Text(
                      'Ethio Telecom',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Industry: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Telecommunication',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location : ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Addis Ababa,\nEthiopia',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 60),

            //DESCRIPTION ───────────────────────────────
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Ethio Telecom is the national telecommunications provider of Ethiopia, delivering mobile, internet, and fixed-line services across the country. The company focuses on expanding digital connectivity, improving network infrastructure, and supporting innovation through technology and communication services.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.6,
              ),
            ),

            // SPACER SO BUTTONS SHOW ONLY ON SCROLL ─────
            const SizedBox(height: 300),

            //LOGOUT + DELETE BUTTONS ───────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logout Button
                SizedBox(
                  width: 130,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF087E8B),
                      side: const BorderSide(
                        color: Color(0xFF087E8B),
                        width: 1,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Logout', style: TextStyle(fontSize: 16)),
                  ),
                ),

                const SizedBox(width: 16),

                // Delete Account Button
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red, width: 1),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Delete account',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // BOTTOM NAV BAR ─────────────────────────
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF087E8B),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Left Icon
              IconButton(
                icon: const Icon(
                  Icons.people_outline,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {},
              ),

              // Middle Icon
              IconButton(
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {},
              ),

              // Right Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.bar_chart_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

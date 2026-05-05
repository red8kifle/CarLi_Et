
import 'package:flutter/material.dart';

class CompanyHomePage extends StatelessWidget {
  const CompanyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //APP BAR ─────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color(0xFF087E8B),
        elevation: 0,
        title: const Text(
          'CarLi_ET',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      //BODY ────────────────────────────────────────────────
      body: Stack(
        children: [
          //TEAL BACKGROUND TOP ───────────────────────────
          Container(
            height: 200,
            color: const Color(0xFF087E8B),
          ),

          Column(
            children: [

              //COMPANY INFO ────────────────────────────
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 16,
                  bottom: 100,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ethio telecom',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Addis Ababa, Ethiopia',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //WHITE curved body ────────────────────────
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [

                      _MenuButton(
                        icon: Icons.send_outlined,
                        label: 'Post Internship',
                        onTap: () {},
                      ),

                      const SizedBox(height: 16),

                      _MenuButton(
                        icon: Icons.person_outline,
                        label: 'View Applicants',
                        onTap: () {},
                      ),

                      const SizedBox(height: 16),

                      _MenuButton(
                        icon: Icons.list_outlined,
                        label: 'View Internships',
                        onTap: () {},
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      //Bottom nav bar─────────────────────────
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 24,
        ),
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              // Right Icon
              IconButton(
                icon: const Icon(
                  Icons.bar_chart_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {},
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF087E8B),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
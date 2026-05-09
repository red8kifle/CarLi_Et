import 'package:flutter/material.dart';
import 'package:carli_et/core/widgets/logo/carliet_logo.dart';
import 'package:go_router/go_router.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final Color primaryTeal = const Color(0xFF087E8B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Logo(height: 50),
                  const SizedBox(width: 15),
                  Text(
                    "CarLi_ET Internship\nManagement",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "Hi, \$firstname",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryTeal,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile Info",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryTeal,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryTeal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    child: const Text("Edit Profile"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Profile Image",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Icon(Icons.person, size: 60, color: Colors.grey.shade300),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "John Doe",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text("Male", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 12),
                        const Text(
                          "University / Institution",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "University / Institution Name",
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildUnderlineField("Expected Year of Graduation", "2016 E.C. / 2026 G.C."),
              _buildUnderlineField("Current GPA", "GPA"),
              _buildUnderlineField("Year of Study", "1st Year"),
              _buildUnderlineField("Skills", "Skills..."),
              _buildUnderlineField("Previous Internships", "Previous Participated Internships"),
              const SizedBox(height: 32),
              Text(
                "Links",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryTeal),
              ),
              const SizedBox(height: 16),
              _buildUnderlineField("LinkedIn URL:", "LinkedIn URL"),
              _buildUnderlineField("Portfolio / GitHub", "URL (Portfolio / GitHub)"),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton("Logout", primaryTeal, () {
                    context.go('/');
                  }),
                  const SizedBox(width: 20),
                  _buildActionButton("Delete account", Colors.redAccent, () {}),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {},
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: 140,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          label,
          style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildUnderlineField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryTeal)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryTeal = Color(0xFF087E8B);

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      height: 72,
      decoration: BoxDecoration(
        color: primaryTeal,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.grid_view_rounded, 0, 24, false),
          _buildNavItem(Icons.home_outlined, 1, 30, false),
          _buildNavItem(Icons.people_alt_rounded, 2, 26, currentIndex == 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, double size, bool isActive) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? const Color(0xFF087E8B) : Colors.white.withOpacity(0.9),
          size: size,
        ),
      ),
    );
  }
}
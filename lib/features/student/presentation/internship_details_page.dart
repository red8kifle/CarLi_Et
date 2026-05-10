import 'package:flutter/material.dart';
import '../../../../core/widgets/logo/carliet_logo.dart'; 
import '../../../../core/widgets/buttons/filled_btn.dart';
import '../../../../core/widgets/buttons/outlined_btn.dart';

class InternshipDetailsPage extends StatelessWidget {
  final Map<String, String> data;

  const InternshipDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeaderSection(data: data),
            _BodyContent(data: data),
            _FooterActions(companyName: data['company']!),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

//Header section
class _HeaderSection extends StatelessWidget {
  final Map<String, String> data;
  const _HeaderSection({required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 90),
          decoration: const BoxDecoration(
            color: Color(0xFF087E8B), 
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              const Align(alignment: Alignment.topLeft, child: Logo(height: 25)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 70, height: 70, padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset(
                      data['image']!, 
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => const Icon(Icons.business, color: Colors.grey, size: 35),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['company']!, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        Text(data['title']!, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -35,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _InfoTile(icon: Icons.location_on_outlined, title: "Location", value: data['loc']!),
                Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.3)),
                _InfoTile(icon: Icons.calendar_today_outlined, title: "Duration", value: data['dur']!),
                Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.3)),
                _InfoTile(icon: Icons.attach_money_outlined, title: "Stipend", value: data['sal']!),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _InfoTile({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF087E8B)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF011627))),
      ],
    );
  }
}
// Body section
class _BodyContent extends StatelessWidget {
  final Map<String, String> data;
  const _BodyContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 70, 25, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("About the Role", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF011627))),
          const SizedBox(height: 10),
          Text(
            "Join the ${data['company']} team. ${data['desc']} We are looking for students to work on ${data['tags']}.",
            style: const TextStyle(color: Colors.black54, height: 1.5),
          ),
          const SizedBox(height: 25),
          const Text("Key Responsibilities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF011627))),
          _buildBullet("Development of new features and updates."),
          _buildBullet("Collaboration with senior engineers."),
          _buildBullet("Writing clean, maintainable code."),
          const SizedBox(height: 25),
          const Text("Requirements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF011627))),
          _buildBullet("Minimum 3.0 GPA."),
          _buildBullet("Proficiency in relevant languages."),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),
          const Text("Deadline: 2/03/2026", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF087E8B)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87))),
        ],
      ),
    );
  }
}

class _FooterActions extends StatelessWidget {
  final String companyName;
  const _FooterActions({required this.companyName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(child: OutlinedBtn(text: "Back", onPressed: () => Navigator.pop(context))),
          const SizedBox(width: 15),
          Expanded(
            child: FilledBtn(
              text: "Apply Now",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: const Text("Applied Successfully", style: TextStyle(color: Color(0xFF087E8B))),
                    content: Text("Your application was sent to $companyName."),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:carli_et/domain/entities/internship_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../applications/application/application_notifier.dart';


class InternshipDetailsPage extends ConsumerStatefulWidget {
  final InternshipEntity internship;
  const InternshipDetailsPage({super.key, required this.internship});

  @override
  ConsumerState<InternshipDetailsPage> createState() =>
      _InternshipDetailsPageState();
}

class _InternshipDetailsPageState extends ConsumerState<InternshipDetailsPage> {
  bool _isApplying = false;

  Future<void> _apply() async {
    setState(() => _isApplying = true);
    final success = await ref
        .read(applicationNotifierProvider.notifier)
        .apply(widget.internship.id);
    setState(() => _isApplying = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Application submitted successfully!'
                : 'Failed to apply. You may have already applied.',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
      if (success) {
        ref.read(applicationNotifierProvider.notifier).fetchMyApplications();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final internship = widget.internship;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeaderSection(internship: internship),
            _BodyContent(internship: internship),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedBtn(
                      text: "Back",
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _isApplying
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF087E8B),
                            ),
                          )
                        : FilledBtn(text: "Apply Now", onPressed: _apply),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final InternshipEntity internship;
  const _HeaderSection({required this.internship});

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
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Logo(height: 25),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        internship.companyName.isNotEmpty
                            ? internship.companyName[0].toUpperCase()
                            : 'C',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF087E8B),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          internship.companyName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          internship.title,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _InfoTile(
                  icon: Icons.location_on_outlined,
                  title: "Location",
                  value: internship.location,
                ),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
                _InfoTile(
                  icon: Icons.category_outlined,
                  title: "Type",
                  value: internship.type,
                ),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
                _InfoTile(
                  icon: Icons.access_time_outlined,
                  title: "Deadline",
                  value: internship.deadline ?? 'N/A',
                ),
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
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF087E8B)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _BodyContent extends StatelessWidget {
  final InternshipEntity internship;
  const _BodyContent({required this.internship});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 70, 25, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About the Role",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            internship.description ?? 'No description available.',
            style: const TextStyle(color: Colors.black54, height: 1.5),
          ),
          const SizedBox(height: 25),
          const Text(
            "Required Skills",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            internship.skills ?? 'No skills listed.',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 25),
          const Text(
            "Requirements",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            internship.requirements ?? 'No additional requirements.',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

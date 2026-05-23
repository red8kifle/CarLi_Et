import 'package:carli_et/domain/entities/application_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../internships/application/internship_notifier.dart';
import '../../applications/application/application_notifier.dart';
import 'applicant_resume.dart';

class ViewApplicants extends ConsumerStatefulWidget {
  const ViewApplicants({super.key});

  @override
  ConsumerState<ViewApplicants> createState() => _ViewApplicantsState();
}

class _ViewApplicantsState extends ConsumerState<ViewApplicants> {
  int? _selectedInternshipId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(internshipNotifierProvider.notifier).fetchMyInternships();
    });
  }

  @override
  Widget build(BuildContext context) {
    final internshipsState = ref.watch(internshipNotifierProvider);
    final applicantsState = ref.watch(applicationNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF087E8B)),
          onPressed: () => context.goNamed('company_home'),
        ),
        title: const Text(
          "Applicants",
          style: TextStyle(
            color: Color(0xFF087E8B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black26),
              ),
              child: DropdownButtonHideUnderline(
                child: internshipsState.when(
                  loading: () => const SizedBox(
                    height: 48,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (e, _) => Text('Error: $e'),
                  data: (internships) => DropdownButton<int>(
                    value: _selectedInternshipId,
                    hint: const Text("Select Internship"),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Select an internship'),
                      ),
                      ...internships.map(
                        (i) =>
                            DropdownMenuItem(value: i.id, child: Text(i.title)),
                      ),
                    ],
                    onChanged: (id) {
                      setState(() => _selectedInternshipId = id);
                      if (id != null) {
                        ref
                            .read(applicationNotifierProvider.notifier)
                            .fetchApplicants(id);
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: applicantsState.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFF087E8B)),
                ),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (applications) {
                  if (applications.isEmpty) {
                    return const Center(child: Text('No applicants yet.'));
                  }
                  return ListView.builder(
                    itemCount: applications.length,
                    itemBuilder: (context, i) {
                      final app = applications[i];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ApplicantResume(application: app),
                            ),
                          );
                        },
                        child: _ApplicantCard(application: app),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApplicantCard extends StatelessWidget {
  final ApplicationEntity application;

  const _ApplicantCard({required this.application});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (application.status) {
      case 'accepted':
        statusColor = Colors.green;
        break;
      case 'rejected':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: statusColor.withOpacity(0.2),
            child: Text(
              application.studentName?.isNotEmpty == true
                  ? application.studentName![0].toUpperCase()
                  : 'S',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  application.studentName ?? 'Student',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  application.university ?? 'University not specified',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Year: ${application.year ?? 'N/A'}',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'GPA: ${application.gpa ?? 'N/A'}',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              application.status.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

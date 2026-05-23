import 'package:carli_et/domain/entities/internship_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

import '../../../core/widgets/logo/carliet_logo.dart';
import '../../internships/application/internship_notifier.dart';

import '../../auth/application/auth_notifier.dart';
import '../../applications/application/application_notifier.dart';
import '../application/student_profile_provider.dart';
import 'internship_details_page.dart';

class StudentHomePage extends ConsumerStatefulWidget {
  const StudentHomePage({super.key});

  @override
  ConsumerState<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends ConsumerState<StudentHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(internshipNotifierProvider.notifier).fetchAll();
      ref.read(applicationNotifierProvider.notifier).fetchMyApplications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: const _BottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            const _HeaderSection(),
            const Expanded(child: _BodyContent()),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends ConsumerWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(studentProfileProvider);
    final authState = ref.watch(authNotifierProvider);
    final user = authState.value;

    final firstName =
        profileData['firstName'] ??
        user?.fullName?.split(' ').first ??
        'Student';

    final applicationsState = ref.watch(applicationNotifierProvider);
    final pendingCount =
        applicationsState.value?.where((a) => a.isPending).length ?? 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 45),
      decoration: const BoxDecoration(color: Color(0xFF087E8B)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    child: const Logo(height: 60),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'CarLi_ET Internship',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  if (pendingCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$pendingCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 35),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, $firstName ',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Internship\nOpportunity',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: ElevatedButton(
                            onPressed: () =>
                                context.pushNamed('browse_internships'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'Browse Internships',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE5A93D), width: 5),
                ),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.white,
                  child: Text(
                    firstName.isNotEmpty ? firstName[0].toUpperCase() : 'S',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF087E8B),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// BODY CONTENT

class _BodyContent extends ConsumerWidget {
  const _BodyContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internshipsState = ref.watch(internshipNotifierProvider);

    return Transform.translate(
      offset: const Offset(0, -25),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: internshipsState.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF087E8B)),
                  SizedBox(height: 12),
                  Text(
                    'Loading internships...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          error: (e, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(
                    'Error: $e',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(internshipNotifierProvider.notifier)
                        .fetchAll(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF087E8B),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          data: (internships) {
            if (internships.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.work_outline, size: 48, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        'No internships available.',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Check back later!',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Show only first 6 internships on home page
            final displayInternships = internships.length > 6
                ? internships.sublist(0, 6)
                : internships;

            // Display in rows of 2
            final chunks = <List<InternshipEntity>>[];
            for (int i = 0; i < displayInternships.length; i += 2) {
              chunks.add(
                displayInternships.sublist(
                  i,
                  i + 2 > displayInternships.length
                      ? displayInternships.length
                      : i + 2,
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
              child: Column(
                children: chunks
                    .map(
                      (row) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: row
                              .map(
                                (internship) => Expanded(
                                  child: _InternshipCard(
                                    internship: internship,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

// INDIVIDUAL INTERNSHIP CARD

class _InternshipCard extends ConsumerWidget {
  final InternshipEntity internship;
  const _InternshipCard({required this.internship});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Logo Placeholder
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Text(
                  internship.companyName.isNotEmpty
                      ? internship.companyName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF087E8B),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Company Name
          Text(
            internship.companyName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Internship Title
          Text(
            internship.title,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // Read more and Apply buttons
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          InternshipDetailsPage(internship: internship),
                    ),
                  );
                },
                child: const Text(
                  "Read more",
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF087E8B),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 26,
                child: ElevatedButton(
                  onPressed: () => _showApplyDialog(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showApplyDialog(BuildContext context, WidgetRef ref) {
    final coverCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Apply to ${internship.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              internship.companyName,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: coverCtrl,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Cover letter (optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF087E8B),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              final success = await ref
                  .read(applicationNotifierProvider.notifier)
                  .apply(
                    internship.id,
                    coverLetter: coverCtrl.text.trim().isEmpty
                        ? null
                        : coverCtrl.text.trim(),
                  );

              if (context.mounted) {
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
                  // Refresh applications count
                  ref
                      .read(applicationNotifierProvider.notifier)
                      .fetchMyApplications();
                }
              }
            },
            child: const Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xFF087E8B),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Browse Internships
            IconButton(
              icon: const Icon(
                Icons.grid_view_rounded,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () => context.pushNamed('browse_internships'),
            ),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.home_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
            // Profile
            IconButton(
              onPressed: () => context.pushNamed('profile'),
              icon: const Icon(Icons.person, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}

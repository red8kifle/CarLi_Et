import 'package:carli_et/domain/entities/internship_entity.dart';
import 'package:carli_et/features/Browse_as_guest/browse_internship_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/internships/application/internship_notifier.dart';

class BrowseAsGuest extends ConsumerStatefulWidget {
  const BrowseAsGuest({super.key});

  @override
  ConsumerState<BrowseAsGuest> createState() => _BrowseAsGuestState();
}

class _BrowseAsGuestState extends ConsumerState<BrowseAsGuest> {
  @override
  void initState() {
    super.initState();
    // Load internships from backend when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(internshipNotifierProvider.notifier).fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final internshipsState = ref.watch(internshipNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A8785),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CarLi_ET Internship',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Internship\nOpportunity',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => context.goNamed('student_signup'),
                            child: Container(
                              width: 150,
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xFF005C5B),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Center(
                                child: Text(
                                  'Get started\nas student',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () => context.goNamed('company_signup'),
                            child: Container(
                              width: 150,
                              height: 52,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Center(
                                child: Text(
                                  'Get started\nas Company',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF0A8785),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: internshipsState.when(
                          loading: () => const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF0A8785),
                            ),
                          ),
                          error: (e, _) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Error loading internships: $e',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(
                                          internshipNotifierProvider.notifier,
                                        )
                                        .fetchAll();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0A8785),
                                  ),
                                  child: const Text(
                                    'Retry',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          data: (internships) {
                            if (internships.isEmpty) {
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.work_outline,
                                      size: 48,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'No internships available.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Check back later!',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 18,
                                    childAspectRatio: 0.55,
                                  ),
                              itemCount: internships.length,
                              itemBuilder: (context, index) {
                                final internship = internships[index];
                                return _InstitutionCard(internship: internship);
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A8785),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 6),
                              color: const Color(0xFF0A8785),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.home_outlined,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: () => context.goNamed('home'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _InstitutionCard extends StatelessWidget {
  final InternshipEntity internship;

  const _InstitutionCard({required this.internship});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BrowseInternshipDetail(internship: internship),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF087E8B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                internship.companyName.isNotEmpty
                    ? internship.companyName[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF087E8B),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            internship.companyName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            internship.title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.location_on, size: 10, color: Colors.grey),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  internship.location,
                  style: const TextStyle(color: Colors.grey, fontSize: 9),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF087E8B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              internship.type,
              style: const TextStyle(
                fontSize: 8,
                color: Color(0xFF087E8B),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

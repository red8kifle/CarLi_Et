import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../internships/application/internship_notifier.dart';


class ViewInternships extends ConsumerStatefulWidget {
  const ViewInternships({super.key});

  @override
  ConsumerState<ViewInternships> createState() => _ViewInternshipsState();
}

class _ViewInternshipsState extends ConsumerState<ViewInternships> {
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF087E8B)),
          onPressed: () => context.goNamed('company_home'),
        ),
        title: const Text(
          "My Internships",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF087E8B),
          ),
        ),
      ),
      body: internshipsState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF087E8B)),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (internships) {
          if (internships.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No internships posted yet.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap + to create one',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: internships.length,
            itemBuilder: (context, index) {
              final internship = internships[index];
              return Card(
                color: const Color(0xFFE3F8F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    internship.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('${internship.location} • ${internship.type}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Delete Internship'),
                              content: const Text(
                                'Are you sure? This cannot be undone.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await ref
                                .read(internshipNotifierProvider.notifier)
                                .deleteInternship(internship.id);
                            ref
                                .read(internshipNotifierProvider.notifier)
                                .fetchMyInternships();
                            ref
                                .read(internshipNotifierProvider.notifier)
                                .fetchAll();
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Internship deleted'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

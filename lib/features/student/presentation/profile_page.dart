import 'package:carli_et/domain/entities/application_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../auth/application/auth_notifier.dart';
import '../../applications/application/application_notifier.dart';

import '../application/student_profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(applicationNotifierProvider.notifier).fetchMyApplications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(studentProfileProvider);
    final authState = ref.watch(authNotifierProvider);
    final user = authState.value;
    final applicationsState = ref.watch(applicationNotifierProvider);
    final applications = applicationsState.value ?? [];

    final firstName =
        profileData['firstName'] ??
        user?.fullName?.split(' ').first ??
        'Student';
    final fullName =
        profileData['fullName'] ?? user?.fullName ?? 'Student Name';
    final email = user?.email ?? 'No email';
    final university = profileData['university'] ?? 'Not specified';
    final year = profileData['year'] ?? 'Not specified';
    final expectedYear = profileData['expectedYear'] ?? 'Not specified';
    final gpa = profileData['gpa'] ?? 'Not specified';
    final skills = profileData['skills'] ?? 'Not specified';
    final languages = profileData['languages'] ?? 'Not specified';
    final linkedin = profileData['linkedin_url'] ?? 'Not specified';
    final portfolio = profileData['portfolio_url'] ?? 'Not specified';
    final prevInternship = profileData['prev_internship'] ?? 'None';
    final gender = profileData['gender'] ?? 'Not specified';
    final workAuth = profileData['work_authorization'] ?? 'Not specified';
    final visaSponsorship = profileData['visa_sponsorship'] ?? 'Not specified';
    final disability = profileData['disability_status'] ?? 'Not specified';

    final pendingCount = applications.where((a) => a.isPending).length;
    final acceptedCount = applications.where((a) => a.isAccepted).length;
    final rejectedCount = applications.where((a) => a.isRejected).length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Logo
              Row(
                children: [
                  const Logo(height: 45),
                  const SizedBox(width: 12),
                  Text(
                    "CarLi_ET Internship\nManagement",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Greeting
              Text(
                "Hi, $firstName",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF087E8B),
                ),
              ),
              const SizedBox(height: 16),

              // Profile Info Header with Edit Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Profile Info",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF087E8B),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.goNamed('complete_profile_one'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF087E8B),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text("Edit Profile"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Profile Image and Basic Info
              const Text(
                "Profile Image",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF087E8B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        firstName.isNotEmpty ? firstName[0].toUpperCase() : 'S',
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF087E8B),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          gender,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Divider
              const Divider(thickness: 1),
              const SizedBox(height: 16),

              // Academic Information
              const Text(
                "Academic Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF087E8B),
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow("University / Institution", university),
              _buildInfoRow("Year of Study", year),
              _buildInfoRow("Expected Year of Graduation", expectedYear),
              _buildInfoRow("Current GPA", gpa),
              const SizedBox(height: 24),

              // Skills & Experience
              const Text(
                "Skills & Experience",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF087E8B),
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow("Skills", skills),
              _buildInfoRow("Languages", languages),
              _buildInfoRow("Previous Internships", prevInternship),
              const SizedBox(height: 24),

              // Links
              const Text(
                "Links",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF087E8B),
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow("LinkedIn", linkedin),
              _buildInfoRow("Portfolio / GitHub", portfolio),
              const SizedBox(height: 24),

              // Additional Information
              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF087E8B),
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow("Work Authorization", workAuth),
              _buildInfoRow("Need Visa Sponsorship", visaSponsorship),
              _buildInfoRow("Disability Status", disability),
              const SizedBox(height: 24),

              // My Applications Section
              const Text(
                "My Applications",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF087E8B),
                ),
              ),
              const SizedBox(height: 12),

              // Stats Row
              Row(
                children: [
                  _buildStatChip(
                    "Total",
                    applications.length.toString(),
                    const Color(0xFF087E8B),
                  ),
                  const SizedBox(width: 10),
                  _buildStatChip(
                    "Pending",
                    pendingCount.toString(),
                    Colors.orange,
                  ),
                  const SizedBox(width: 10),
                  _buildStatChip(
                    "Accepted",
                    acceptedCount.toString(),
                    Colors.green,
                  ),
                  const SizedBox(width: 10),
                  _buildStatChip(
                    "Rejected",
                    rejectedCount.toString(),
                    Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Applications List
              applicationsState.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(color: Color(0xFF087E8B)),
                  ),
                ),
                error: (e, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Error loading applications: $e',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                data: (_) {
                  if (applications.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 48,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "You haven't applied to any internships yet.",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Browse internships and apply!",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: applications.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (ctx, index) => _ApplicationTile(
                      application: applications[index],
                      ref: ref,
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Divider
              const Divider(thickness: 1),
              const SizedBox(height: 16),

              // Account Actions
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF087E8B),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildActionButton(
                    "Logout",
                    const Color(0xFF087E8B),
                    Icons.logout,
                    () async {
                      await ref.read(authNotifierProvider.notifier).logout();
                      if (mounted) context.goNamed('home');
                    },
                  ),
                  const SizedBox(width: 16),
                  _buildActionButton(
                    "Delete Account",
                    Colors.red,
                    Icons.delete_forever,
                    () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Delete Account'),
                          content: const Text(
                            'Are you sure you want to delete your account?\n\n'
                            'This action is PERMANENT and cannot be undone.\n'
                            'All your applications and data will be lost.',
                            style: TextStyle(fontSize: 14),
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
                      if (confirm == true && mounted) {
                        await ref
                            .read(authNotifierProvider.notifier)
                            .deleteAccount();
                        if (mounted) context.goNamed('home');
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) context.goNamed('browse_internships');
          if (index == 1) context.goNamed('student_home');
          if (index == 2) context.goNamed('profile');
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not specified' : value,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 10, color: color)),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    Color color,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: color, size: 18),
        label: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

// Application Tile Widget
class _ApplicationTile extends StatelessWidget {
  final ApplicationEntity application;
  final WidgetRef ref;

  const _ApplicationTile({required this.application, required this.ref});

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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.work_outline, color: statusColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  application.internshipTitle ?? 'Internship',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  application.companyName ?? '',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  'Applied on: ${_formatDate(application.appliedAt)}',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
              if (application.isPending) ...[
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Withdraw Application'),
                        content: const Text(
                          'Are you sure you want to withdraw this application?\n'
                          'This action cannot be undone.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text(
                              'Withdraw',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await ref
                          .read(applicationNotifierProvider.notifier)
                          .withdraw(application.id);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Application withdrawn successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Withdraw',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}

// Bottom Navigation Bar
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
    const primaryColor = Color(0xFF087E8B);

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      height: 65,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.grid_view_rounded, 0, 26, false),
          _buildNavItem(Icons.home_outlined, 1, 30, false),
          _buildNavItem(Icons.person, 2, 28, currentIndex == 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, double size, bool isActive) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isActive ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Icon(icon, color: Colors.white, size: size),
      ),
    );
  }
}

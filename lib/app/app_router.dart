import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/application/auth_notifier.dart';
import '../features/Browse_as_guest/browse_as_guest.dart';

import '../features/student/presentation/terms.dart';
import '../features/company/presentation/company_signup.dart';
import '../features/student/presentation/student_signup.dart';
import '../features/company/presentation/terms_policies.dart';
import '../features/student/presentation/profile_page.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/auth/presentation/signin.dart';
import '../features/auth/presentation/forgot_password.dart';
import '../features/company/presentation/company_home_page.dart';
import '../features/company/presentation/company_profile.dart';
import '../features/company/presentation/company_profile_setup.dart';
import '../features/company/presentation/applicant_resume.dart';
import '../features/company/presentation/view_applicants.dart';
import '../features/company/presentation/view_internships.dart';
import '../features/company/presentation/post_internship_1.dart';
import '../features/company/presentation/post_internship_2.dart';
import '../features/student/presentation/student_home_page.dart';
import '../features/student/presentation/browse_internships_page.dart';
import '../features/student/presentation/auth_complete_profile_one.dart';
import '../features/student/presentation/auth_complete_profile_two.dart';
import '../features/student/presentation/auth_complete_profile_three.dart';

// Routes accessible without login
const _publicRoutes = [
  '/',
  '/student_signin',
  '/company_signin',
  '/student_signup',
  '/company_signup',
  '/forgot_password',
  '/browse_as_guest',
  '/terms',
  '/termsStudent',
];

// Routes only for students
const _studentRoutes = [
  '/student_home',
  '/browse_internships',
  '/profile',
  '/complete_profile_one',
  '/complete_profile_two',
  '/complete_profile_three',
];

// Routes only for companies
const _companyRoutes = [
  '/company_home',
  '/company_profile',
  '/company_profile_setup',
  '/post_internship_1',
  '/post_internship_2',
  '/view_applicants',
  '/view_internships',
  '/applicant_resume',
];

GoRouter createRouter(WidgetRef ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final user = authState.value;
      final path = state.matchedLocation;

      // Still loading auth — wait
      if (authState.isLoading) {
        return null;
      }

      final isPublic = _publicRoutes.any(
        (r) => path == r || path.startsWith(r),
      );
      final isStudent = _studentRoutes.any((r) => path.startsWith(r));
      final isCompany = _companyRoutes.any((r) => path.startsWith(r));

      // Not logged in trying to access protected route
      if (user == null && (isStudent || isCompany)) {
        return '/';
      }

      // Logged in student trying to access company routes
      if (user != null && user.isStudent && isCompany) {
        return '/student_home';
      }

      // Logged in company trying to access student routes
      if (user != null && user.isCompany && isStudent) {
        return '/company_home';
      }

      // Logged-in user going to home/signin — redirect to their dashboard
      if (user != null && (path == '/' || path.contains('signin'))) {
        return user.isStudent ? '/student_home' : '/company_home';
      }

      // After signup, student should go to profile completion
      if (user != null && user.isStudent && path == '/student_signup') {
        return '/complete_profile_one';
      }

      // After signup, company should go to profile setup
      if (user != null && user.isCompany && path == '/company_signup') {
        return '/company_profile_setup';
      }

      return null;
    },
    routes: [
      // Home
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const Home(),
      ),

      // Terms
      GoRoute(
        path: '/terms',
        name: 'terms',
        builder: (context, state) => const TermsScreen(),
      ),
      GoRoute(
        path: '/termsStudent',
        name: 'termsStudent',
        builder: (context, state) => const TermsStudent(),
      ),

      // Auth
      GoRoute(
        path: '/student_signin',
        name: 'student_signin',
        builder: (context, state) => const Signin(role: 'student'),
      ),
      GoRoute(
        path: '/company_signin',
        name: 'company_signin',
        builder: (context, state) => const Signin(role: 'company'),
      ),
      GoRoute(
        path: '/forgot_password',
        name: 'forgot_password',
        builder: (context, state) => const ForgotPassword(),
      ),

      // Student Auth
      GoRoute(
        path: '/student_signup',
        name: 'student_signup',
        builder: (context, state) => const StudentSignup(),
      ),

      // Student Profile Completion
      GoRoute(
        path: '/complete_profile_one',
        name: 'complete_profile_one',
        builder: (context, state) => const AuthCompleteProfileOne(),
      ),
      GoRoute(
        path: '/complete_profile_two',
        name: 'complete_profile_two',
        builder: (context, state) => const AuthCompleteProfileTwo(),
      ),
      GoRoute(
        path: '/complete_profile_three',
        name: 'complete_profile_three',
        builder: (context, state) => const AuthCompleteProfileThree(),
      ),

      // Student Main Screens
      GoRoute(
        path: '/student_home',
        name: 'student_home',
        builder: (context, state) => const StudentHomePage(),
      ),
      GoRoute(
        path: '/browse_internships',
        name: 'browse_internships',
        builder: (context, state) => const BrowseInternshipsPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Guest Browse
      GoRoute(
        path: '/browse_as_guest',
        name: 'browse_as_guest',
        builder: (context, state) => const BrowseAsGuest(),
      ),

      // Company Auth
      GoRoute(
        path: '/company_signup',
        name: 'company_signup',
        builder: (context, state) => const CompanySignup(),
      ),
      GoRoute(
        path: '/company_profile_setup',
        name: 'company_profile_setup',
        builder: (context, state) => const CompanyProfileSetup(),
      ),

      // Company Main Screens
      GoRoute(
        path: '/company_home',
        name: 'company_home',
        builder: (context, state) => const CompanyHomePage(),
      ),
      GoRoute(
        path: '/company_profile',
        name: 'company_profile',
        builder: (context, state) => const CompanyProfile(),
      ),

      // Company Internship Management
      GoRoute(
        path: '/post_internship_1',
        name: 'post_internship_1',
        builder: (context, state) => const PostInternship1(),
      ),
      GoRoute(
        path: '/post_internship_2',
        name: 'post_internship_2',
        builder: (context, state) => const PostInternship2(),
      ),
      GoRoute(
        path: '/view_internships',
        name: 'view_internships',
        builder: (context, state) => const ViewInternships(),
      ),

      // Company Applicant Management
      GoRoute(
        path: '/view_applicants',
        name: 'view_applicants',
        builder: (context, state) => const ViewApplicants(),
      ),
      // REMOVED: '/applicant_resume' route because it's now pushed with parameters
    ],
  );
}

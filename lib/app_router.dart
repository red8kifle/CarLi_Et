
import 'package:go_router/go_router.dart';
// Importing screens
import 'package:carli_et/features/auth/presentation/terms_policies.dart';
import 'package:carli_et/features/student/profile_page.dart';
import 'package:carli_et/features/home/presentation/home_screen.dart';
import 'package:carli_et/features/auth/presentation/signin.dart';
import 'package:carli_et/features/company/presentation/company_home_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Landing/Home Page
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const Home(),
    ),

    // Profile Page
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),

    // Terms and Policies Page
    GoRoute(
      path: '/terms',
      name: 'terms',
      builder: (context, state) => const TermsScreen(),
    ),
    // Student signin page
    GoRoute(
      path: '/student_signin',
      name: 'student_signin',
      builder: (context, state) => const StudentSignin(),
    ),
    // Company signin page
    GoRoute(
      path: '/company_signin',
      name: 'company_signin',
      builder: (context, state) => const CompanyHomePage(),
    ),
  ],
); 

import 'package:go_router/go_router.dart';
import 'package:carli_et/features/company/presentation/company_signup.dart';
import 'package:carli_et/features/student/student_signup.dart';
import 'package:carli_et/features/company/presentation/terms_policies.dart';
import 'package:carli_et/features/student/profile_page.dart';
import 'package:carli_et/features/home/presentation/home_screen.dart';
import 'package:carli_et/features/auth/presentation/signin.dart';
import 'package:carli_et/features/auth/presentation/forgot_password.dart';
import 'package:carli_et/features/company/presentation/company_home_page.dart';
import 'package:carli_et/features/company/presentation/company_profile.dart';
import 'package:carli_et/features/company/presentation/company_profile_setup.dart';
import 'package:carli_et/features/company/presentation/applicant_resume.dart';
import 'package:carli_et/features/company/presentation/view_applicants.dart';
import 'package:carli_et/features/company/presentation/view_internships.dart';
import 'package:carli_et/features/company/presentation/post_internship_1.dart';
import 'package:carli_et/features/company/presentation/post_internship_2.dart';
import 'package:carli_et/features/student/presentation/student_home_page.dart';
import 'package:carli_et/features/student/presentation/browse_internships_page.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/terms',
      name: 'terms',
      builder: (context, state) => const TermsScreen(),
    ),
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
      path: '/view_applicants',
      name: 'view_applicants',
      builder: (context, state) => const ViewApplicants(),
    ),
    GoRoute(
      path: '/view_internships',
      name: 'view_internships',
      builder: (context, state) => const ViewInternships(),
    ),
    GoRoute(
      path: '/applicant_resume',
      name: 'applicant_resume',
      builder: (context, state) => const ApplicantResume(),
    ),
    GoRoute(
      path: '/Student_signup',
      name: 'student_signup',
      builder: (context, state) => const StudentSignup(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
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
    
  ],
);

import 'package:carli_et/features/Browse/browse_as_guest.dart';
import 'package:carli_et/features/Browse/browse_internship_detail.dart';
import 'package:go_router/go_router.dart';
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



final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', name: 'home', builder: (context, state) => const Home()),
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
    GoRoute(
      path: '/browse_as_guest',
      name: 'browse_as_guest',
      builder: (context, state) => const BrowseAsGuest(),
    ),
    GoRoute(
      path: '/browse_internship_detail',
      name: 'browse_internship_detail',
      builder: (context, state) => const BrowseInternshipDetail(),
    ),
    GoRoute( 
      path: '/browse_as_guest',
      name: 'browse_as_guest',
      builder: (context, state) => const BrowseAsGuest (),
    ),
    GoRoute(
      path: '/AuthCompleteProfileOne',
      name: 'AuthCompleteProfileOne',
      builder: (context, state) => const AuthCompleteProfileOne(),
      ),
  ],
);

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/buttons/light_btn.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _onStudentPressed(BuildContext context) {
    context.pushNamed('student_signin');
  }

  void _onCompanyPressed(BuildContext context) {
    context.pushNamed('company_signin');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D3B46), Color(0xFF087E8B)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            // to make the child scrollable if content does not fit in the screen
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),

                const Header(),

                SizedBox(height: screenHeight * 0.1),

                AuthButtons(
                  onStudentPressed: () => _onStudentPressed(context),
                  onCompanyPressed: () => _onCompanyPressed(context),
                ),

                const SizedBox(height: 30),

                GuestLink(onTap: () => context.goNamed('browse_as_guest')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//_____________________________________________________________________________

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Logo(),
        SizedBox(height: 7),
        AppTitle(),
        SizedBox(height: 10),
        AppSubtitle(),
      ],
    );
  }
}

//_____________________________________________________________________________

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo.png', height: 170);
  }
}

//_____________________________________________________________________________

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'CarLi_Et',
      style: TextStyle(
        fontSize: 44,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

//_____________________________________________________________________________

class AppSubtitle extends StatelessWidget {
  const AppSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Career Link Ethiopia \nbridging Ethiopian talent and \nIndustry',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 22, color: Colors.white),
    );
  }
}

//_____________________________________________________________________________

class AuthButtons extends StatelessWidget {
  final VoidCallback onStudentPressed; // a function that returns nothing
  final VoidCallback onCompanyPressed;

  const AuthButtons({
    super.key,
    required this.onStudentPressed,
    required this.onCompanyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LightBtn(text: 'Student Sign in', onPressed: onStudentPressed),
        const SizedBox(height: 12),
        LightBtn(text: 'Company Sign in', onPressed: onCompanyPressed),
      ],
    );
  }
}
//_____________________________________________________________________________

class GuestLink extends StatelessWidget {
  final VoidCallback onTap;

  const GuestLink({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Browse as Guest',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white.withOpacity(0.8),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

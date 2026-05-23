import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/text/split_action_text.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/text/auth_subtitel.dart';
import '../../../core/widgets/input/input_field.dart';
import '../../auth/application/auth_notifier.dart';

class CompanySignup extends ConsumerStatefulWidget {
  const CompanySignup({super.key});

  @override
  ConsumerState<CompanySignup> createState() => _CompanySignupState();
}

class _CompanySignupState extends ConsumerState<CompanySignup> {
  bool _agreedToTerms = false;
  bool _isLoading = false;
  final _companyNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  Future<void> _onCreateAccountPressed() async {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to Terms and Policy first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_passwordCtrl.text != _confirmPassCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_passwordCtrl.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 6 characters.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .signup(
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text,
            role: 'company',
            companyName: _companyNameCtrl.text.trim(),
          );
      if (mounted) {
        context.pushNamed('company_profile_setup');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 55),
              const _Header(),
              SizedBox(height: screenHeight * 0.03),
              const AuthSubtitle(text: 'Create a new account', fontSize: 24),
              SizedBox(height: screenHeight * 0.03),
              InputField(
                label: 'Company Name',
                hintText: 'Enter your company name',
                controller: _companyNameCtrl,
              ),
              const SizedBox(height: 15),
              InputField(
                label: 'Email',
                hintText: 'Enter your email',
                controller: _emailCtrl,
              ),
              const SizedBox(height: 15),
              InputField(
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                controller: _passwordCtrl,
              ),
              const SizedBox(height: 15),
              InputField(
                label: 'Re-enter your Password',
                hintText: 'Re-enter your password',
                obscureText: true,
                controller: _confirmPassCtrl,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    activeColor: const Color(0xFF087E8B),
                    onChanged: (value) =>
                        setState(() => _agreedToTerms = value ?? false),
                  ),
                  GestureDetector(
                    onTap: () => context.pushNamed('terms'),
                    child: const SplitActionText(
                      text: "I agree with  ",
                      actionText: "Terms and policy",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _isLoading
                  ? const CircularProgressIndicator(color: Color(0xFF087E8B))
                  : FilledBtn(
                      text: 'Create account',
                      onPressed: _onCreateAccountPressed,
                    ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => context.pushNamed('company_signin'),
                child: const SplitActionText(
                  text: "If you already have an account  ",
                  actionText: "Login",
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, top: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Logo(height: 60),
            SizedBox(width: 8),
            AppTitle(fontSize: 16, textAlign: TextAlign.left),
          ],
        ),
      ),
    );
  }
}

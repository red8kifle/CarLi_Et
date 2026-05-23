import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/auth_notifier.dart';
import '../../../core/widgets/input/input_field.dart';
import '../../../core/widgets/buttons/filled_btn.dart';
import '../../../core/widgets/buttons/outlined_btn.dart';
import '../../../core/widgets/logo/carliet_logo.dart';
import '../../../core/widgets/text/app_title.dart';
import '../../../core/widgets/text/auth_subtitel.dart';
import '../../../core/widgets/text/action_text.dart';
import '../../../core/widgets/text/split_action_text.dart';

class Signin extends ConsumerStatefulWidget {
  final String role;
  const Signin({super.key, required this.role});

  @override
  ConsumerState<Signin> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;

  Future<void> _onLoginPressed() async {
    if (_emailCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter email and password'), backgroundColor: Colors.red));
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(authNotifierProvider.notifier).login(_emailCtrl.text.trim(), _passwordCtrl.text, widget.role);
      if (mounted) {
        final user = ref.read(authNotifierProvider).value;
        if (user?.isStudent == true) {
          context.goNamed('student_home');
        } else if (user?.isCompany == true) {
          context.goNamed('company_home');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceFirst('Exception: ', '')), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.09),
              const Center(child: Column(children: [Logo(), SizedBox(height: 1), AppTitle(fontSize: 22)])),
              SizedBox(height: screenHeight * 0.04),
              const AuthSubtitle(text: 'Sign into your account'),
              SizedBox(height: screenHeight * 0.03),
              InputField(label: 'Email', hintText: 'Enter your email', controller: _emailCtrl),
              const SizedBox(height: 15),
              InputField(label: 'Password', hintText: 'Enter password', controller: _passwordCtrl, obscureText: true),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => context.pushNamed('forgot_password'),
                    child: const ActionText(text: 'Forgot password?'),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator(color: Color(0xFF087E8B))
                  : FilledBtn(text: 'Login', onPressed: _onLoginPressed),
              const SizedBox(height: 10),
              OutlinedBtn(text: 'Go Back', onPressed: () => context.pop()),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => context.pushNamed(widget.role == 'student' ? 'student_signup' : 'company_signup'),
                child: SplitActionText(text: "If you don't have an account, ", actionText: "Create new Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
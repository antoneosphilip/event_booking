import 'package:booking/feature/explore/presentation/view/widget/app_logo.dart';
import 'package:booking/feature/explore/presentation/view/widget/bottom_link.dart';
import 'package:booking/feature/explore/presentation/view/widget/fordet_password.dart';
import 'package:booking/feature/explore/presentation/view/widget/input_field.dart';
import 'package:booking/feature/explore/presentation/view/widget/or_driver.dart';
import 'package:booking/feature/explore/presentation/view/widget/password_field.dart';
import 'package:booking/feature/explore/presentation/view/widget/primary_button.dart';
import 'package:booking/feature/explore/presentation/view/widget/remember_me.dart';
import 'package:booking/feature/explore/presentation/view/widget/screen_title.dart';
import 'package:booking/feature/explore/presentation/view/widget/social_button.dart';
import 'package:flutter/material.dart';

import 'package:booking/utils/colors.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(onPressed: () => Navigator.pop(context)),
              const SizedBox(height: 24),
              const ScreenTitle(title: 'Sign up'),
              const SizedBox(height: 24),
              InputField(
                controller: nameController,
                hint: 'Full name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 14),
              InputField(
                controller: emailController,
                hint: 'abc@email.com',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 14),
              PasswordField(
                controller: passwordController,
                hint: 'Your password',
                obscure: obscurePassword,
                onToggle: () => setState(() => obscurePassword = !obscurePassword),
              ),
              const SizedBox(height: 14),
              PasswordField(
                controller: confirmController,
                hint: 'Confirm password',
                obscure: obscureConfirm,
                onToggle: () => setState(() => obscureConfirm = !obscureConfirm),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'SIGN UP',
                onTap: () {},
              ),
              const SizedBox(height: 24),
              const OrDivider(),
              const SizedBox(height: 24),
              SocialButton(
                logo: 'assets/icons/google.png',
                label: 'Login with Google',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              SocialButton(
                logo: 'assets/icons/facebook.png',
                label: 'Login with Facebook',
                onTap: () {},
              ),
              const SizedBox(height: 28),
              BottomLink(
                question: 'Already have an account? ',
                linkText: 'Signin',
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

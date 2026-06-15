import 'package:booking/feature/explore/presentation/view/home/home_layout.dart';
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

import 'Sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              const AppLogo(),
              const SizedBox(height: 32),
              const ScreenTitle(title: 'Sign in'),
              const SizedBox(height: 24),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RememberMe(
                    value: rememberMe,
                    onChanged: (v) => setState(() {
                      rememberMe = v;
                    }),
                  ),
                  ForgotPassword(onTap: () {}),
                ],
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'SIGN IN',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeLayout()));

                },
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
                question: "Don't have an account? ",
                linkText: 'Sign up',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

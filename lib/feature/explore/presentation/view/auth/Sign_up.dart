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
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking/utils/colors.dart';
import '../../cubit/auth/auth_cubit.dart';
import '../home/home_layout.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomeLayout()));
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
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
                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          label: 'SIGN UP',
                          onTap: () {
                            if (passwordController.text == confirmController.text) {
                              context.read<AuthCubit>().signUp(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Passwords do not match')),
                              );
                            }
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
                    question: 'Already have an account? ',
                    linkText: 'Signin',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

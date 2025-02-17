import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pennywise/core/utils/extension_methods/string_extensions.dart';
import 'package:pennywise/core/widgets/loader_indicator.dart';
import 'package:pennywise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pennywise/features/auth/presentation/widgets/auth_text_form_field.dart';

class AuthPageLayout extends StatelessWidget {
  final bool isLogin;

  AuthPageLayout({super.key, required this.isLogin});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withAlpha(255),
              Theme.of(context).colorScheme.primary.withAlpha(150),
              Theme.of(context).colorScheme.primary.withAlpha(64),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLogin ? 'Login' : 'Sign Up',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    isLogin ? 'Welcome back' : 'Create your account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AuthTextFormField(
                              isPassword: false,
                              hintText: 'Enter your email',
                              controller: _emailController,
                              validator: (value) {
                                if (value.isNullOrEmpty()) {
                                  return 'Email must not be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            AuthTextFormField(
                              isPassword: true,
                              hintText: isLogin ? 'Enter your password' : 'Choose your password',
                              controller: _passwordController,
                              validator: (value) {
                                if (value.isNullOrEmpty()) {
                                  return 'Password must not be empty';
                                }
                                return null;
                              },
                            ),
                            if (!isLogin) ...[
                              const SizedBox(height: 20),
                              AuthTextFormField(
                                isPassword: true,
                                hintText: 'Confirm your password',
                                controller: _passwordConfirmController,
                                validator: (value) {
                                  if (value.isNullOrEmpty()) {
                                    return 'Please, confirm your password';
                                  }
                                  if (_passwordController.text.isNotNullOrEmpty() &&
                                      value != _passwordController.text) {
                                    return 'Passwords are different';
                                  }
                                  return null;
                                },
                              ),
                            ],
                            const SizedBox(height: 60),
                            SizedBox(
                              width: 200,
                              height: 60,
                              child: BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  assert(
                                    state is AuthFailureState ||
                                        state is AuthLoadingState ||
                                        state is LoginSuccessState ||
                                        state is AuthInitialState,
                                  );
                                  if (state is AuthFailureState) {
                                    state.failure.show(context);
                                  } else if (state is LoginSuccessState) {
                                    context.go('/');
                                  }
                                },
                                builder: (context, state) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.primary.withAlpha(200),
                                      elevation: 5,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                          isLogin
                                              ? AuthLoginEvent(
                                                email: _emailController.text.trim(),
                                                password: _passwordController.text.trim(),
                                              )
                                              : AuthSignUpEvent(
                                                email: _emailController.text.trim(),
                                                password: _passwordController.text.trim(),
                                                passwordConfirmation:
                                                    _passwordConfirmController.text.trim(),
                                              ),
                                        );
                                      }
                                    },
                                    child:
                                        state is AuthLoadingState
                                            ? const LoaderIndicator()
                                            : Text(
                                              isLogin ? 'Login' : 'Sign Up',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.headlineSmall!.copyWith(
                                                color: Theme.of(context).colorScheme.onPrimary,
                                              ),
                                            ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: isLogin ? "Don't have an account? " : 'Already have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: isLogin ? 'Sign Up' : 'Login',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      if (isLogin) {
                                        context.go('/signup');
                                      } else {
                                        context.go('/login');
                                      }
                                    },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

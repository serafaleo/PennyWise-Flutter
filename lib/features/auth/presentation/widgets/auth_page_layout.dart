import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pennywise/features/auth/presentation/enums/form_type_enum.dart';
import 'package:pennywise/features/auth/presentation/widgets/auth_form.dart';

class AuthPageLayout extends StatefulWidget {
  final FormTypeEnum formType;

  const AuthPageLayout({super.key, required this.formType});

  @override
  State<AuthPageLayout> createState() => _AuthPageLayoutState();
}

class _AuthPageLayoutState extends State<AuthPageLayout> {
  late String _headerText;
  late String _headerDescriptionText;
  late String _footerText;
  late String _footerClickableText;

  @override
  void initState() {
    switch (widget.formType) {
      case FormTypeEnum.login:
        _headerText = "Login";
        _headerDescriptionText = "Welcome back";
        _footerText = "Don't have an account? ";
        _footerClickableText = "Sign Up";
        break;
      case FormTypeEnum.signUp:
        _headerText = "Sign Up";
        _headerDescriptionText = "Create your account";
        _footerText = "Already have an account? ";
        _footerClickableText = "Login";
        break;
    }

    super.initState();
  }

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
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_headerText, style: Theme.of(context).textTheme.displayMedium),
                  Text(_headerDescriptionText, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                  child: Column(
                    children: [
                      AuthForm(formType: widget.formType),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: _footerText,
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: _footerClickableText,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      if (widget.formType == FormTypeEnum.login) {
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

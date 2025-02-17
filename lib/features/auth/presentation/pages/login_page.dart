import 'package:flutter/material.dart';
import 'package:pennywise/features/auth/presentation/widgets/auth_page_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(isLogin: true);
  }
}

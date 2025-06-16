import 'package:flutter/material.dart';
import 'package:pennywise/core/helpers/functions/show_snackbar.dart';
import 'package:pennywise/features/auth/presentation/widgets/auth_page_layout.dart';

class LoginPage extends StatefulWidget {
  final bool showSessionExpiredWarning;
  const LoginPage({super.key, this.showSessionExpiredWarning = false});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    if (widget.showSessionExpiredWarning) {
      showSnackBar(context, 'Session expired. Please, log in again.');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const AuthPageLayout(isLogin: true);
  }
}

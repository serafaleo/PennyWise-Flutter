import 'package:flutter/material.dart';
import 'package:pennywise/core/helpers/functions/show_snackbar.dart';
import 'package:pennywise/features/auth/presentation/widgets/auth_page_layout.dart';

class LoginPage extends StatelessWidget {
  final bool showSessionExpiredWarning;
  const LoginPage({super.key, this.showSessionExpiredWarning = false});

  @override
  Widget build(BuildContext context) {
    if (showSessionExpiredWarning) {
      showSnackBar(context, 'Session expired. Please, log in again.');
    }
    return const AuthPageLayout(isLogin: true);
  }
}

import 'package:flutter/material.dart';
import 'package:pennywise/core/helpers/functions/show_snackbar.dart';

final class Failure {
  final String message;
  Failure([this.message = 'An unexpected error occured.']);

  void show(BuildContext context) {
    showSnackBar(context, message, Colors.red);
  }
}

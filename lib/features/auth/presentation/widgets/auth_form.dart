import 'package:flutter/material.dart';
import 'package:pennywise/features/auth/presentation/enums/form_field_type_enum.dart';
import 'package:pennywise/features/auth/presentation/enums/form_type_enum.dart';
import 'package:pennywise/features/auth/presentation/widgets/auth_text_form_field.dart';

class AuthForm extends StatefulWidget {
  final FormTypeEnum formType;

  const AuthForm({super.key, required this.formType});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late String _passwordHint;
  late String _buttonText;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    switch (widget.formType) {
      case FormTypeEnum.login:
        _passwordHint = "Enter your password";
        _buttonText = "Login";
        break;
      case FormTypeEnum.signUp:
        _passwordHint = "Choose a password";
        _buttonText = "Sign Up";
        break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextFormField(
            controller: emailController,
            hintText: "Enter your email",
            fieldType: FormFieldTypeEnum.email,
          ),
          SizedBox(height: 20),
          AuthTextFormField(
            controller: passwordController,
            hintText: _passwordHint,
            fieldType: FormFieldTypeEnum.password,
          ),
          Visibility(
            visible: widget.formType == FormTypeEnum.signUp,
            child: Column(
              children: [
                SizedBox(height: 20),
                AuthTextFormField(
                  controller: passwordConfirmController,
                  hintText: "Confirm the password",
                  fieldType: FormFieldTypeEnum.password,
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(200),
              elevation: 5,
              shadowColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Processing Data')));
              }
            },
            child: Text(
              _buttonText,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

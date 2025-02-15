import 'package:flutter/material.dart';
import 'package:pennywise/features/auth/presentation/enums/form_field_type_enum.dart';

class AuthTextFormField extends StatefulWidget {
  final FormFieldTypeEnum fieldType;
  final String hintText;
  final TextEditingController controller;

  const AuthTextFormField({
    super.key,
    required this.fieldType,
    required this.hintText,
    required this.controller,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  late bool _obscureText;
  late String _validationFieldTypeString;
  final Color? _iconsColor = Colors.grey[600];

  @override
  void initState() {
    switch (widget.fieldType) {
      case FormFieldTypeEnum.email:
        _obscureText = false;
        _validationFieldTypeString = "Email";
        break;
      case FormFieldTypeEnum.password:
        _obscureText = true;
        _validationFieldTypeString = "Password";
        break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$_validationFieldTypeString is missing!";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary.withAlpha(50),
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.fieldType == FormFieldTypeEnum.email ? Icons.email : Icons.lock,
          color: _iconsColor,
        ),
        suffixIcon:
            widget.fieldType == FormFieldTypeEnum.password
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: _iconsColor,
                  ),
                )
                : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(vertical: 18),
      ),
    );
  }
}

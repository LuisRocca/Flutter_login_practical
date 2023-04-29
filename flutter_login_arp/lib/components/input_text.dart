import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  String label;
  TextInputType keyboardType;
  bool obscureText, borderEnabled;
  final void Function(String text) onChanged;
  final String? Function(String? text) validator;

  InputText({
    super.key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          enabledBorder: borderEnabled
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12))
              : InputBorder.none,
          labelText: label,
          labelStyle:
              TextStyle(color: Colors.black26, fontWeight: FontWeight.w500)),
    );
  }
}

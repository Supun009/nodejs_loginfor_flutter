import 'package:flutter/material.dart';

class FormTextfild extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  const FormTextfild({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10))),
    );
  }
}

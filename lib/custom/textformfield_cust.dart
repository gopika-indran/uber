import 'package:flutter/material.dart';

class cust_textformfield extends StatelessWidget {
  cust_textformfield({
    super.key,
    required this.controller,
    required this.label,
    this.suffics,
    this.preicon,
    this.obscuretext = false,
    required this.command,
    required this.command2,
    required this.keyboad,
  });

  final TextEditingController controller;
  final label;
  final preicon;
  IconButton? suffics;
  bool obscuretext;
  final String command;
  final String command2;
  TextInputType keyboad;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return command;
          } else if (value.length < 5) {
            return command2;
          }
          return null;
        },
        keyboardType: keyboad,
        controller: controller,
        obscureText: obscuretext,
        decoration: InputDecoration(
          suffix: suffics,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 6),
          ),
          labelText: label,
        ),
      ),
    );
  }
}

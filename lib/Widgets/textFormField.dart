
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class textFormField extends StatelessWidget {
  TextEditingController Controller;
  String hintText;
  IconData prefixIcon;
  textFormField({
    super.key,
    required this.Controller,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    if (hintText == "Password") {
      return TextFormField(
        controller: Controller,
        obscureText: true,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.blue))),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your $hintText!";
          }
          return null;
        },
      );
    }

    return TextFormField(
      controller: Controller,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.blue))),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your $hintText!";
        }
        return null;
      },
    );
  }
}

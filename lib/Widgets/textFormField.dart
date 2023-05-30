import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.blue))),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your $hintText!";
          } else if (value.length < 6) {
            return "Password must be at least 6 characters long";
          }
          return null;
        },
      );
    } else if (hintText == "Email") {
      return TextFormField(
        controller: Controller,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            hintText: hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.blue))),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your $hintText!";
          } else if (!value.contains('@')) {
            final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value);
            if (!emailValid) {
              return "Please enter a valid email address";
            }
          }
          return null;
        },
      );
    } else if (hintText == "Age" || hintText == "Phone Number") {
      return TextFormField(
        controller: Controller,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            hintText: hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.blue))),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          if (hintText == "Phone Number") {
            if (value!.isEmpty) {
              return "Please enter your $hintText!";
            }
            else if (value.length < 11) {
              return "Please enter a valid phone number, must be 11 digits long";
            }
          }
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
          border: const OutlineInputBorder(
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

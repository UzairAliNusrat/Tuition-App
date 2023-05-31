import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuition_app_project/Screens/login/bloc/login_bloc.dart';
import 'package:tuition_app_project/Screens/signUp/bloc/sign_up_bloc.dart';

class textFormField extends StatelessWidget {
  TextEditingController Controller;
  String hintText;
  IconData prefixIcon;
  LoginBloc? loginBloc;
  SignUpBloc? signUpBloc;
  final bool hide;
  String? selectedVal;
  String? image;
  textFormField(
      {super.key,
      required this.Controller,
      required this.hintText,
      required this.prefixIcon,
      required this.loginBloc,
      required this.signUpBloc,
      required this.hide,
      this.image,
      this.selectedVal});

  @override
  Widget build(BuildContext context) {
    if (hintText == "Password") {
      return TextFormField(
        controller: Controller,
        obscureText: hide,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  if (loginBloc != null) {
                    loginBloc!.add(PasswordHideButtonClickedEvent(hide: hide!));
                  } else {
                    signUpBloc!.add(SignUpHideButtonClickedEvent(hide: hide!, image: image!, selectedValue: selectedVal!));
                  }
                },
                icon: Icon(Icons.remove_red_eye)),
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
            } else if (value.length < 11) {
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Auth.dart';
import 'package:tuition_app_project/Repositories/userRepository.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Widgets/signUpbutton.dart';
import 'package:tuition_app_project/Widgets/textFormField.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Sign Up',
            style: GoogleFonts.arvo(
              textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 30,),
            ),
          )),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, false),
          ),
          actions: const [Padding(
            padding: EdgeInsets.only(left: 25),
            child: Opacity(opacity: 0 ,child: Icon(Icons.transform_sharp),),
          )],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.cyan[100],
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Create Account',
                      style: GoogleFonts.arvo(
                        textStyle: const TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 50),
                    child: textFormField(
                        Controller: firstNameController,
                        hintText: "First Name",
                        prefixIcon: Icons.person),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: textFormField(
                        Controller: lastNameController,
                        hintText: "Last Name",
                        prefixIcon: Icons.person),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: textFormField(
                        Controller: emailController,
                        hintText: "Email",
                        prefixIcon: Icons.email_outlined),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: textFormField(
                        Controller: passwordController,
                        hintText: "Password",
                        prefixIcon: Icons.lock_outline),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 50, top: 40),
                      child: signUp_button(
                          formkey: _formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                          firstNameController: firstNameController,
                          lastNameController: lastNameController)),
                ],
              ),
            ),
          ),
        )));
  }
}

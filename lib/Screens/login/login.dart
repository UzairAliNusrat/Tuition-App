import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Auth.dart';
import 'package:tuition_app_project/Widgets/loginbutton.dart';
import 'package:tuition_app_project/Screens/signUp/signUp.dart';


import '../../Widgets/textFormField.dart';
import '../HomeScreen/HomeScreen.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: Colors.cyan[100],
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Text(
                      'Login',
                      style: GoogleFonts.arvo(
                        textStyle:
                            const TextStyle(color: Colors.blue, fontSize: 30),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 80),
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
                      child: login_button(
                          type: "Login",
                          formkey: formKey,
                          emailController: emailController,
                          passwordController: passwordController)),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 50, right: 50),
                      child: login_button(
                          type: "Google",
                          formkey: formKey,
                          emailController: emailController,
                          passwordController: passwordController)),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 70),
                    child: Row(
                      children: [
                        Text(
                          "Dont have an account? ",
                          style: GoogleFonts.arvo(
                            textStyle: const TextStyle(
                                color: Colors.blue, fontSize: 15),
                          ),
                        ),
                        GestureDetector(
                          child: RichText(
                              text: TextSpan(
                                  text: "Join Now",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color:
                                            Color.fromARGB(255, 89, 166, 230),
                                        fontSize: 15),
                                  ))),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )));
  }
}

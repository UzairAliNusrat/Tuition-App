import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Auth.dart';
import 'package:tuition_app_project/Screens/login/bloc/login_bloc.dart';
import 'package:tuition_app_project/Widgets/loginbutton.dart';
import 'package:tuition_app_project/Screens/signUp/signUp.dart';

import '../../Widgets/textFormField.dart';
import '../HomeScreen/HomeScreen.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = Auth();
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    loginBloc.add(LoginInitialEvent());
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        body: BlocConsumer<LoginBloc, LoginState>(
          bloc: loginBloc,
          listenWhen: (previous, current) => current is LoginActionState,
          buildWhen: (previous, current) => current is! LoginActionState,
          listener: (context, state) {
            // TODO: implement listener
            if (state is NavigatetoSignUpState) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            }
          },
          builder: (context, state) {
            if (state is LoginLoadedSuccessfulState) {
              return SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            'Teach n Learn',
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Colors.blue, fontSize: 40),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            'Login',
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Colors.blue, fontSize: 30),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 80),
                          child: textFormField(
                            Controller: emailController,
                            hintText: "Email",
                            prefixIcon: Icons.email_outlined,
                            hide: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 20),
                          child: textFormField(
                            Controller: passwordController,
                            hintText: "Password",
                            prefixIcon: Icons.lock_outline,
                            loginBloc: loginBloc,
                            hide: state.hide,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 40),
                            child: login_button(
                              formkey: formKey,
                              emailController: emailController,
                              passwordController: passwordController,
                              loginBloc: loginBloc,
                            )),
                        
                        Padding(
                          padding: const EdgeInsets.only(top: 80, left: 70),
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
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color.fromARGB(
                                                  255, 89, 166, 230),
                                              fontSize: 15),
                                        ))),
                                onTap: () {
                                  loginBloc.add(JoinNowButtonClickedEvent());
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
            } else {
              return Scaffold(
                  backgroundColor: Colors.cyan[100],
                );
            }
          },
        ));
  }
}

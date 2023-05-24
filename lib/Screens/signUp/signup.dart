import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Auth.dart';
import 'package:tuition_app_project/Screens/signUp/bloc/sign_up_bloc.dart';
import 'package:tuition_app_project/Widgets/signUpbutton.dart';
import 'package:tuition_app_project/Widgets/textFormField.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final auth = Auth();

  List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(value: "Student", child: Text("Student")),
    const DropdownMenuItem(value: "Teacher", child: Text("Teacher"))
  ];
  final SignUpBloc signUpBloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    signUpBloc.add(SignUpInitialEvent(selectedValue: "Student"));
    return Scaffold(
        appBar: AppBar(
          title: Center(
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, false),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Opacity(
                opacity: 0,
                child: Icon(Icons.transform_sharp),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.cyan[100],
        body: BlocConsumer<SignUpBloc, SignUpState>(
          bloc: signUpBloc,
          listenWhen: (previous, current) => current is SignUpActionState,
          buildWhen: (previous, current) => current is! SignUpActionState,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is SignUpLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SignUpLoadedSuccessfulState) {
              return SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 50,
                            foregroundImage: state.image == "" 
                            ? const AssetImage("assets/images/profile.png")
                            : FileImage(File(state.image)) as ImageProvider,
                          ),
                          onTap: () {
                            signUpBloc.add(ImagePickerEvent(selectedValue: state.selectedValue));
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 50, right: 50, left: 50, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 7, right: 7),
                                child: DropdownButton(
                                    dropdownColor: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(30),
                                    items: items,
                                    value: state.selectedValue,
                                    onChanged: (value) {
                                      signUpBloc.add(DropDownValueChangedEvent(
                                          selectedValue: value!, image: state.image));
                                    }),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: textFormField(
                              Controller: firstNameController,
                              hintText: "First Name",
                              prefixIcon: Icons.person),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 20),
                          child: textFormField(
                              Controller: lastNameController,
                              hintText: "Last Name",
                              prefixIcon: Icons.person),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 20),
                          child: textFormField(
                              Controller: emailController,
                              hintText: "Email",
                              prefixIcon: Icons.email_outlined),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 20),
                          child: textFormField(
                              Controller: passwordController,
                              hintText: "Password",
                              prefixIcon: Icons.lock_outline),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 40),
                            child: signUp_button(
                                formkey: _formKey,
                                emailController: emailController,
                                passwordController: passwordController,
                                firstNameController: firstNameController,
                                lastNameController: lastNameController,
                                imagePath: state.image,)),
                      ],
                    ),
                  ),
                ),
              ));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ));
  }
}





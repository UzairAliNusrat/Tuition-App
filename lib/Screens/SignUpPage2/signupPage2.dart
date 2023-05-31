import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Models/studentInfoModel.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import 'package:tuition_app_project/Widgets/textFormField.dart';

import 'bloc/page2_bloc.dart';

class signupPage2 extends StatelessWidget {
  final String id;
  final String userType;
  signupPage2({super.key, required this.id, required this.userType});

  final QualificationController = TextEditingController();
  final AboutController = TextEditingController();
  final AgeController = TextEditingController();
  final SubjectsController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final Page2Bloc page2Bloc = Page2Bloc();

  @override
  Widget build(BuildContext context) {
    page2Bloc.add(Page2InitialEvent());
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
            onPressed: () {}
            //signUpBloc.add(BackArrowIconClickedEvent(context: context)),
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
      body: BlocConsumer<Page2Bloc, Page2State>(
        bloc: page2Bloc,
        listenWhen: (previous, current) => current is Page2ActionState,
        buildWhen: (previous, current) => current is! Page2ActionState,
        listener: (context, state) {
          if (state is NavigateToLoginPageState) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is Page2LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Page2LoadedState) {
            if (userType == "Teacher") {
              return SingleChildScrollView(
                child: Form(
                    child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 70, bottom: 20),
                      child: Text(
                        "Personal Information",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: textFormField(
                        Controller: phoneNumberController,
                        hintText: "Phone Number",
                        prefixIcon: Icons.app_registration,
                        loginBloc: null,
                        signUpBloc: null,
                        hide: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: textFormField(
                        Controller: AgeController,
                        hintText: "Age",
                        prefixIcon: Icons.app_registration,
                        loginBloc: null,
                        signUpBloc: null,
                        hide: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: textFormField(
                        Controller: QualificationController,
                        hintText: "Qualification",
                        prefixIcon: Icons.app_registration,
                        loginBloc: null,
                        signUpBloc: null,
                        hide: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: textFormField(
                        Controller: SubjectsController,
                        hintText: "Subjects",
                        prefixIcon: Icons.app_registration,
                        loginBloc: null,
                        signUpBloc: null,
                        hide: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: AboutController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            hintText: "Description",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(color: Colors.blue))),
                        maxLines: null,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              Teacherinfo teacher = Teacherinfo(
                                  id: id,
                                  age: AgeController.text,
                                  phoneNumber: phoneNumberController.text,
                                  qualification: QualificationController.text,
                                  subjects: SubjectsController.text.split(","),
                                  description: AboutController.text);
                              page2Bloc.add(SignUpbuttonTeacherClickedEvent(
                                  teacher: teacher));
                            },
                            child: Text("Sign Up",
                                style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Colors.blue, fontSize: 30))),
                          ),
                        ))
                  ],
                )),
              );
            } else {
              return SingleChildScrollView(
                child: Form(
                    child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 70, bottom: 20),
                      child: Text(
                        "Personal Information",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: textFormField(
                        Controller: phoneNumberController,
                        hintText: "Phone Number",
                        prefixIcon: Icons.app_registration,
                        loginBloc: null,
                        signUpBloc: null,
                        hide: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: textFormField(
                        Controller: AgeController,
                        hintText: "Age",
                        prefixIcon: Icons.app_registration,
                        loginBloc: null,
                        signUpBloc: null,
                        hide: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: textFormField(
                        Controller: QualificationController,
                        hintText: "Qualification",
                        prefixIcon: Icons.app_registration,
                        loginBloc: null,
                        signUpBloc: null,
                        hide: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: AboutController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            hintText: "Description",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(color: Colors.blue))),
                        maxLines: null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              Studentinfo studentinfo = Studentinfo(
                                  id: id,
                                  age: AgeController.text,
                                  phoneNumber: phoneNumberController.text,
                                  qualification: QualificationController.text,
                                  description: AboutController.text);
                              page2Bloc.add(SignUpbuttonStudentClickedEvent(
                                  studentinfo: studentinfo));
                            },
                            child: Text("SignUp")),
                      ),
                    )
                  ],
                )),
              );
            }
          } else {
            return const Text("Error");
          }
        },
      ),
    );
  }
}

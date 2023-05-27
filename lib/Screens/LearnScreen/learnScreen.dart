import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Screens/LearnScreen/bloc/learn_bloc.dart';
import 'package:tuition_app_project/Widgets/textFormField.dart';

import '../FindTeachersScreen/findTeachersScreen.dart';

class learnScreen extends StatelessWidget {
  final String studentId;
  learnScreen({super.key, required this.studentId});

  final subjectNameController = TextEditingController();
  final topicController = TextEditingController();
  final noteController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final LearnBloc learnBloc = LearnBloc();

  @override
  Widget build(BuildContext context) {
    learnBloc.add(LearnInitialEvent());
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          title: Center(
              child: Text("Subject",
                  style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102),
                          fontSize: 30)))),
          backgroundColor: const Color.fromARGB(255, 139, 193, 238),
          actions: const [
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Opacity(
                opacity: 0,
                child: Icon(Icons.transform_sharp),
              ),
            )
          ],
        ),
        body: BlocConsumer<LearnBloc, LearnState>(
          bloc: learnBloc,
          listenWhen: (previous, current) => current is LearnActionState,
          buildWhen: (previous, current) => current is! LearnActionState,
          listener: (context, state) {
            // TODO: implement listener
            if (state is NavigatetoFindTeacherScreenState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          findTeachers(studentId: state.studentId, subject: state.subject.trim().toLowerCase(), topic: state.topic.trim(), note: state.note.trim(),)));
            }
          },
          builder: (context, state) {
            if (state is LearnLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LearnLoadedSuccessState) {
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
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 80),
                          child: textFormField(
                              Controller: subjectNameController,
                              hintText: "Subject Name",
                              prefixIcon: Icons.subject_sharp),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 20),
                          child: textFormField(
                              Controller: topicController,
                              hintText: "Topic",
                              prefixIcon: Icons.topic_sharp),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 50, right: 50, top: 20),
                          child: TextField(
                            controller: noteController,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.description),
                                hintText: "Description",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                            maxLines: null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: SizedBox(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    learnBloc.add(FindTeacherButtonClickedEvent(studentId: studentId,
                                        subject:
                                            subjectNameController.text.trim().toLowerCase(), topic: topicController.text.trim(), note: noteController.text.trim()));
                                    print("Validated");
                                  } else {
                                    print("Not Validated");
                                  }
                                },
                                child: const Text("Find Teachers")),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          },
        ));
  }
}

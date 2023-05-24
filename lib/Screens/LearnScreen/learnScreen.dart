import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Widgets/textFormField.dart';

class learnScreen extends StatelessWidget {
  learnScreen({super.key});

  final subjectNameController = TextEditingController();
  final topicController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text("Subject",
                  style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102),
                          fontSize: 30)))),
          backgroundColor: const Color.fromARGB(255, 139, 193, 238),
          // actions: const [
          //   Padding(
          //     padding: EdgeInsets.only(left: 25),
          //     child: Opacity(
          //       opacity: 0,
          //       child: Icon(Icons.transform_sharp),
          //     ),
          //   )
          // ],
        ),
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
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 80),
                    child: textFormField(
                        Controller: subjectNameController,
                        hintText: "Subject Name",
                        prefixIcon: Icons.subject_sharp),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: textFormField(
                        Controller: topicController,
                        hintText: "Topic",
                        prefixIcon: Icons.topic_sharp),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.description),
                          hintText: "Description",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(color: Colors.blue))),
                      maxLines: null,
                    ),
                    )
                  
                ],
              ),
            ),
          ),
        )));
  }
}

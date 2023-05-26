import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Screens/FindTeachersScreen/bloc/findteachers_bloc.dart';

class findTeachers extends StatelessWidget {
  final String subject;
  findTeachers({super.key, required this.subject});

  final FindteachersBloc findteachersBloc = FindteachersBloc();

  @override
  Widget build(BuildContext context) {
    findteachersBloc.add(FindTeachersInitialEvent(subject: subject));
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          title: Center(
              child: Text("Teachers Available",
                  style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102),
                          fontSize: 25)))),
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
        body: BlocConsumer<FindteachersBloc, FindteachersState>(
          bloc: findteachersBloc,
          listenWhen: (previous, current) => current is FindteachersActionState,
          buildWhen: (previous, current) => current is !FindteachersActionState,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is FindTeachersLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is FindTeachersLoadedSuccessState){
              return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ListView.builder(
                    itemCount: state.teachers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.cyan[400],
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            foregroundImage:
                                FileImage(File(state.teachers[index].ProfileImagePath)),
                          ),
                          title: Text(state.teachers[index].first_name + " " + state.teachers[index].last_name),
                          trailing: const Text('Teacher Rating'),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
            }
            else{
              return const Center(
                child: Text("No Teachers Available"),
              );
            }
            
          },
        ));
  }
}

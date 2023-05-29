import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';

class teacherList extends StatelessWidget {
  final List<user> teachers;
  final HomeBloc homebloc;
  const teacherList(
      {super.key, required this.teachers, required this.homebloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: ListView.builder(
        itemCount: teachers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            width: 200,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent[100],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(teachers[index].ProfileImagePath),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                        teachers[index].first_name +
                            " " +
                            teachers[index].last_name,
                        style: const TextStyle(color: Colors.black)),
                  ),
                  const Text("Teacher Expertise:",
                      style: TextStyle(color: Colors.black)),
                  OutlinedButton(
                    onPressed: () {
                      homebloc.add(TeacherListItemClickedEvent(id: teachers[index].id, imagepath: teachers[index].ProfileImagePath, fullname: teachers[index].first_name + " " + teachers[index].last_name));
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(width: 2.0, color: Colors.blue),
                    ),
                    child: const Text("View profile",
                        style: TextStyle(color: Colors.black)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

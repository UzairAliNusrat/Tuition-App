import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class teacherList extends StatelessWidget {
  const teacherList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: ListView.builder(
        itemCount: 10,
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
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/teacher.png"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("Teacher Name:", style: TextStyle(color: Colors.black)),
                  ),
                  const Text("Teacher Expertise:", style: TextStyle(color: Colors.black)),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(width: 2.0, color: Colors.blue),
                    ),
                    child: const Text("View profile", style: TextStyle(color: Colors.black)),
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

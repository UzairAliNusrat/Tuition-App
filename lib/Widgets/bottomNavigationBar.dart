import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Screens/HomeScreen/bloc/home_bloc.dart';

class bottomNavigationBar extends StatelessWidget {
  final int index;
  final HomeBloc homeBloc;
  final String userType;
  const bottomNavigationBar(
      {super.key,
      required this.index,
      required this.homeBloc,
      required this.userType});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.cyan[100],
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue[200]),
        BottomNavigationBarItem(
            icon: const Icon(Icons.class_outlined),
            label: 'Meeting Requests',
            backgroundColor: Colors.blue[200]),
        BottomNavigationBarItem(
            icon: const Icon(Icons.account_box),
            label: "Users",
            backgroundColor: Colors.blue[200])
      ],
      selectedItemColor: const Color.fromARGB(255, 9, 137, 160),
      currentIndex: index,
      onTap: (value) {
        switch (value) {
          case 0:
            homeBloc.add(BottomNavigationBarItemHomeClickedEvent());
            break;
          case 1:
            homeBloc.add(BottomNavigationBarItemMeetingsClickedEvent());
            break;
          case 2:
            if (userType == "Student") {
              homeBloc.add(BottomNavigationBarItemTeachersClickedEvent());
            }
            else{
              homeBloc.add(BottomNavigationBarItemStudentsClickedEvent());
            }
        }
      },
    );
  }
}

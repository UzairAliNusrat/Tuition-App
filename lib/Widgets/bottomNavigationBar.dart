import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Screens/HomeScreen/bloc/home_bloc.dart';

class bottomNavigationBar extends StatelessWidget {
  final int index;
  final HomeBloc homeBloc;
  const bottomNavigationBar({super.key, required this.index, required this.homeBloc});

  

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //backgroundColor: Colors.cyan[100],
      type: BottomNavigationBarType.shifting,
      items:  [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.blue[200]
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.class_outlined),
          label: 'Meetings',
          backgroundColor: Colors.blue[200]
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat_outlined),
          label: "Chat",
          backgroundColor: Colors.blue[200]
        ),
      ],
      selectedItemColor: const Color.fromARGB(255, 9, 137, 160),
      currentIndex: index,
      onTap: (value) {
        switch (value) {
          case 0:
            homeBloc.add(bottomNavigationBarItemHomeClickedEvent());
            break;
          case 1:
            homeBloc.add(bottomNavigationBarItemMeetingsClickedEvent());
            break;
          case 2:
            homeBloc.add(bottomNavigationBarItemChatClickedEvent());
            break;
        }
      },
    );
  }
}

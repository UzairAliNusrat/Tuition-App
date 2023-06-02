import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/userModel.dart';
import '../Screens/HomeScreen/bloc/home_bloc.dart';

class side_drawer extends StatelessWidget {
  user User;
  final HomeBloc homeBloc;
  side_drawer({super.key, required this.User, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: Colors.cyan[100],
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 139, 193, 238),
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 139, 193, 238)),
              accountName: Text(
                  "${User.first_name} ${User.last_name}",
                  style: GoogleFonts.arvo(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 3, 66, 102), fontSize: 25),
                  )),
              accountEmail: null,
              currentAccountPictureSize: const Size.square(56),
              currentAccountPicture: CircleAvatar(
                  radius: 50,
                  foregroundImage: NetworkImage(User.ProfileImagePath)),
            ), //UserAccountDrawerHeader
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              homeBloc.add(ProfileButtonClickedEvent(User: User));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              homeBloc.add(SignOutButtonClickedEvent());
            },
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Models/userModel.dart';

class side_drawer extends StatelessWidget {
  user? User;
  side_drawer({super.key, required this.User});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              accountName: Text(User?.first_name ?? FirebaseAuth.instance.currentUser?.displayName ?? "",
                  style: GoogleFonts.arvo(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 3, 66, 102), fontSize: 25),
                  )),
              accountEmail: null,
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ),
            ), //UserAccountDrawerHeader
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(' My Course '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
            },
          ),
        ],
      ),
    );
  }
}

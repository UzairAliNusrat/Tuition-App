import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'bloc/profile_bloc.dart';

class teacherProfileScreen extends StatelessWidget {
  final String id;
  final String imagepath;
  final String fullname;
  teacherProfileScreen(
      {super.key,
      required this.id,
      required this.imagepath,
      required this.fullname});

  final ProfileBloc profileBloc = ProfileBloc();

  @override
  Widget build(BuildContext context) {
    profileBloc.add(
        ProfileInitialEvent(id: id, imagepath: imagepath, fullname: fullname));
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Center(
            child: Text(
          'Profile',
          style: GoogleFonts.arvo(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 3, 66, 102), fontSize: 30),
          ),
        )),
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Opacity(
              opacity: 0,
              child: Icon(Icons.transform_sharp),
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 139, 193, 238),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listenWhen: (previous, current) => current is ProfileActionState,
        buildWhen: (previous, current) => current is! ProfileActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoadedState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                    radius: 60,
                    foregroundImage: NetworkImage(state.imagepath),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  state.fullname,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  state.qualification,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Rating: ${state.rating}",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                RatingBar.builder(
                  initialRating: state.rating.toDouble(),
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(height: 20),
                ListTile(
                    leading: const Icon(Icons.subject),
                    title: Text(
                      "Subjects: ${state.subjects.toString().substring(
                              1, state.subjects.toString().length - 1)}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text("Age: ${state.age}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: Text("About: ${state.description}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Rate Teacher: ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                RatingBar.builder(
                  initialRating: state.initialRating.toDouble(),
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    profileBloc.add(NewRatingEvent(
                        fullname: fullname,
                        subjects: state.subjects,
                        age: state.age,
                        qualification: state.qualification,
                        description: state.description,
                        rating: rating.toInt(),
                        userId: id,
                        imagepath: imagepath));
                    rating = state.initialRating.toDouble();
                  },
                ),
              ],
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}

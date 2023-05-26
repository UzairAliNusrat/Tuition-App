import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/userModel.dart';

abstract class UserRepository {
  setuser(user User);
  getUser(String userId);
  Future<List<user>> fetchTeacherList();
}

class FirebaseUserRepository implements UserRepository {
  static var i = 0;
  final db = FirebaseFirestore.instance;

  late user User;

  @override
  setuser(user User) async {
    await db.collection("Users").doc(User.id).set(User.toJson());

    if (User.UserType == "Student") {
      await db.collection("Students").doc(User.id).set(User.toJson());
    } else {
      await db.collection("Teachers").doc(User.id).set(User.toJson());
    }

    i++;
  }

  @override
  getUser(String userId) async {
    // Get the user document from Firestore based on the provided user ID
    final userDoc =
        await FirebaseFirestore.instance.collection("Users").doc(userId).get();
    User = user.fromJson(userDoc);
  }

  @override
  Future<List<user>> fetchTeacherList() async {
    List<user> teachers = [];
    final QuerySnapshot result = await db.collection("Teachers").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
    for (var element in documents) {
      teachers.add(user.fromJson(element));
    }
    return teachers;
  }
}

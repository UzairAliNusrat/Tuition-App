import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuition_app_project/Models/Ratings.dart';
import '../Models/userModel.dart';

abstract class UserRepository {
  setuser(user User);
  getUser(String userId);
  Future<List<user>> fetchTeacherList();
  Future<List<user>> fetchStudentList();
  setRating(Ratings rating);
  Future<double> getAvgUserRating(String userId);
}

class FirebaseUserRepository implements UserRepository {
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
  }

  @override
  getUser(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await db.collection("Users").doc(userId).get();

      User = user.fromJson(userDoc.data()!);
  }

  @override
  Future<List<user>> fetchTeacherList() async {
    List<user> teachers = [];
    final QuerySnapshot result = await db.collection("Teachers").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
    for (var element in documents) {
      teachers.add(user.fromJson(element.data()!));
    }
    return teachers;
  }

  @override
  setRating(Ratings rating) async {
    await db
        .collection("Ratings ${rating.userId}")
        .doc(rating.ratingID)
        .set(rating.toJson());
  }

  @override
  Future<double> getAvgUserRating(String userID) async {
    double avgRating = 0;
    double count = 0;
    final QuerySnapshot result = await db.collection("Ratings $userID").get();
    if (result.size == 0) {
      return 0;
    } else {
      final List<DocumentSnapshot<Map<String, dynamic>>> documents =
          result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
      for (var element in documents) {
        avgRating += Ratings.fromJson(element.data()!).rating;
        count++;
      }

      double avg = avgRating / count;
      return double.parse(avg.toStringAsFixed(1));
    }
  }

  @override
  Future<List<user>> fetchStudentList() async {
    List<user> students = [];
    final QuerySnapshot result = await db.collection("Students").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
    for (var element in documents) {
      students.add(user.fromJson(element.data()!));
    }
    return students;
  }
}

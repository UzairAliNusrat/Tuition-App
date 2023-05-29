import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuition_app_project/Models/Ratings.dart';
import '../Models/userModel.dart';

abstract class UserRepository {
  setuser(user User);
  getUser(String userId);
  Future<List<user>> fetchTeacherList();
  setRating(Ratings rating);
  Future<int> getAvgUserRating(String userId);
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

  @override
  setRating(Ratings rating) async {
    await db
        .collection("Ratings ${rating.userId}")
        .doc(rating.ratingID)
        .set(rating.toJson());
  }

  @override
  Future<int> getAvgUserRating(String userID) async {
    int avgRating = 0;
    int count = 0;
    final QuerySnapshot result = await db.collection("Ratings $userID").get();
    if (result.size == 0) {
      return 0;
    } else {
      final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
    for (var element in documents) {
      avgRating += Ratings.fromJson(element).rating;
      count++;
    }
    return avgRating ~/ count;
    }
    
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/userModel.dart';

abstract class UserRepository {
  setuser(user User);
  Future<user?> getUser(String userId);
}

class FirebaseUserRepository implements UserRepository {
  static var i = 0;
  final db = FirebaseFirestore.instance;
  List<user> teachers = [];
  @override
  setuser(user User) async {
    if (User.UserType == "Student") {
      await db.collection("Students").doc(User.id).set(User.toJson());
    }
    else{
      await db.collection("Teachers").doc(User.id).set(User.toJson());
    }
    
    i++;
  }

  Future<user?> getUser(String userId) async {
    try {
      // Get the user document from Firestore based on the provided user ID
      final userDoc = await FirebaseFirestore.instance
          .collection("Students")
          .doc(userId)
          .get();
      return user.fromJson(userDoc);
    } catch (e) {
      // Handle any errors that occur while fetching the user document
      print('Error getting user: $e');
      return null;
    }
  }

  fetchTeacherList() async {
    try {
      final QuerySnapshot result =
          await FirebaseFirestore.instance.collection("Teachers").get();
      final List<DocumentSnapshot<Map<String, dynamic>>> documents =
          result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
      for (var element in documents) {
        teachers.add(user.fromJson(element));
      }
    } catch (e) {
      print(e);
    }
  }

  
  void dispose(){
    teachers = [];
  }
}

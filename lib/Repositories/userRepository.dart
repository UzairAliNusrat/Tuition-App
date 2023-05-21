import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/userModel.dart';

abstract class UserRepository {
  setuser(user User);
  Future<user?> getUser(String userId);
}

class FirebaseUserRepository implements UserRepository {
  static var i = 0;
  final db = FirebaseFirestore.instance;
  @override
  setuser(user User) async {
    await db.collection("Users").doc(User.id).set(User.toJson());
    i++;
  }

  Future<user?> getUser(String userId) async {
    try {
      // Get the user document from Firestore based on the provided user ID
      final userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .get();
      return user.fromJson(userDoc);
    } catch (e) {
      // Handle any errors that occur while fetching the user document
      print('Error getting user: $e');
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  String first_name;
  String last_name;
  String email;
  String id;

  user({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.id
  });

  static user fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    return user(
      first_name: json['Firstname'] as String? ?? 'field empty',
      last_name: json['LastName'] as String? ?? 'field empty',
      email: json['email'] as String? ?? 'field empty',
      id: json['id'] as String? ?? 'field empty',
    );
  }

  Map<String, dynamic> toJson() {
    return {'Firstname': first_name, 'LastName': last_name, 'email': email, 'id': id};
  }
}
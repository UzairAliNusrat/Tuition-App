import 'package:cloud_firestore/cloud_firestore.dart';

class Ratings {
  double rating;
  String userId;
  String ratingID;

  Ratings({required this.rating, required this.userId, required this.ratingID});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      rating: json['rating'],
      userId: json['user_id'],
      ratingID: json['ratingID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'user_id': userId,
      'ratingID': ratingID,
    };
  }
}

part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {
  final String id;
  final String imagepath;
  final String fullname;
  ProfileInitialEvent({required this.id, required this.imagepath, required this.fullname});
}

class NewRatingEvent extends ProfileEvent {
  final int rating;
  final String userId;
  final String imagepath;
  final String fullname;
  final String age;
  final String qualification;
  final List<String> subjects;
  final String description;
  NewRatingEvent({required this.rating, required this.userId, required this.imagepath, required this.fullname, required this.age, required this.qualification, required this.subjects, required this.description});
}

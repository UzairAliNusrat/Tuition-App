part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {
  final String id;
  final String imagepath;
  final String fullname;
  ProfileInitialEvent({required this.id, required this.imagepath, required this.fullname});
}

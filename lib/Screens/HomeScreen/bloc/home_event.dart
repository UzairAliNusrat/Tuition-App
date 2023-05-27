part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  final String id;

  HomeInitialEvent(this.id);
}

class BottomNavigationBarItemHomeClickedEvent extends HomeEvent {}

class BottomNavigationBarItemMeetingsClickedEvent extends HomeEvent {}

class BottomNavigationBarItemChatClickedEvent extends HomeEvent {}

class LearnButtonClickedEvent extends HomeEvent {
  final String studentId;

  LearnButtonClickedEvent(this.studentId);
}

class TeachButtonClickedEvent extends HomeEvent {}

class TeacherListItemClickedEvent extends HomeEvent {
  final String id;
  final String imagepath;
  final String fullname;

  TeacherListItemClickedEvent(
      {required this.id, required this.imagepath, required this.fullname});
}

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
  final String studentName;
  final String imagepath;

  LearnButtonClickedEvent({
    required this.studentId,
    required this.studentName,
    required this.imagepath,
  });
}

class TeachButtonClickedEvent extends HomeEvent {}

class TeacherListItemClickedEvent extends HomeEvent {
  final String id;
  final String imagepath;
  final String fullname;

  TeacherListItemClickedEvent(
      {required this.id, required this.imagepath, required this.fullname});
}

class MeetingRequestTickButtonClickedEvent extends HomeEvent {
  final String meetingId;
  final String teacherId;
  final String studentName;
  final String imagepath;
  final String studentId;
  final String subject;
  final String topic;
  final String note;
  final String date;
  final String time;
  final String teacherName;

  MeetingRequestTickButtonClickedEvent(
      {required this.meetingId,
      required this.teacherId,
      required this.studentName,
      required this.imagepath,
      required this.studentId,
      required this.subject,
      required this.topic,
      required this.note,
      required this.date,
      required this.time,
      required this.teacherName});
}

class MeetingRequestCrossButtonClickedEvent extends HomeEvent {
  final String meetingId;

  MeetingRequestCrossButtonClickedEvent({
    required this.meetingId,
  });
}

class SignOutButtonClickedEvent extends HomeEvent {}

class ProfileButtonClickedEvent extends HomeEvent {
  final user User;

  ProfileButtonClickedEvent({
    required this.User,
  });
}

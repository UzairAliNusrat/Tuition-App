part of 'findteachers_bloc.dart';

@immutable
abstract class FindteachersEvent {}

class FindTeachersInitialEvent extends FindteachersEvent {
  final String subject;

  FindTeachersInitialEvent({required this.subject});
}

class MeetingRequestButtonClickedEvent extends FindteachersEvent {
  final String teacherId;
  final String studentId;
  final String subject;
  final String topic;
  final String note;
  final int teacherIndex;
  final List<bool> teacherRequestSent;
  final List<user> teachers;

  MeetingRequestButtonClickedEvent(
      {required this.teacherId,
      required this.studentId,
      required this.subject,
      required this.topic,
      required this.note,
      required this.teacherIndex,
      required this.teacherRequestSent,
      required this.teachers});
}

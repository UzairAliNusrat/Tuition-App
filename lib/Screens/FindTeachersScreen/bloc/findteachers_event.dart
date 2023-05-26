part of 'findteachers_bloc.dart';

@immutable
abstract class FindteachersEvent {}

class FindTeachersInitialEvent extends FindteachersEvent {
  final String subject;

  FindTeachersInitialEvent({required this.subject});
}

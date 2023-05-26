part of 'learn_bloc.dart';

@immutable
abstract class LearnEvent {}

class LearnInitialEvent extends LearnEvent {}

class FindTeacherButtonClickedEvent extends LearnEvent {
  final String subject;

  FindTeacherButtonClickedEvent({required this.subject});
}

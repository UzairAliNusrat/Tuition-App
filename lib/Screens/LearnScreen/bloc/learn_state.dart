part of 'learn_bloc.dart';

@immutable
abstract class LearnState {}

abstract class LearnActionState extends LearnState {}

class LearnInitial extends LearnState {}

class LearnLoadingState extends LearnState {}

class LearnLoadedSuccessState extends LearnState {}

class NavigatetoFindTeacherScreenState extends LearnActionState {
  final String subject;

  NavigatetoFindTeacherScreenState({required this.subject});
}

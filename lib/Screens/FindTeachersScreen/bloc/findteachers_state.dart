part of 'findteachers_bloc.dart';

@immutable
abstract class FindteachersState {}

abstract class FindteachersActionState extends FindteachersState {}

class FindteachersInitial extends FindteachersState {}

class FindTeachersLoadingState extends FindteachersState {}

class FindTeachersLoadedSuccessState extends FindteachersState {
  final List<user> teachers;

  FindTeachersLoadedSuccessState({required this.teachers});
}

part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final user User;
  final List<user> Teachers;
  final int selectedIndex;
  HomeLoadedState(this.selectedIndex, this.Teachers, this.User);
}

class HomeErrorState extends HomeState {}

class HomeNavigateToLearnScreenState extends HomeActionState {}

class HomeNavigateToTeachScreenState extends HomeActionState {}

class HomeNavigateToTeacherProfileScreenState extends HomeActionState {
}

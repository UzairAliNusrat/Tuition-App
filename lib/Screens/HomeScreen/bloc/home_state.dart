part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {
  final int selectedIndex;
  HomeLoadingState(this.selectedIndex);
}

class HomeLoadedState extends HomeState {
  final user User;
  final List<user> Teachers;
  final int selectedIndex;
  final List<meetingRequestModel> meetingRequests;
  final List<meetingAcceptedModel> acceptedMeetings;
  final List<meetingRequestModel> meetingHistory;
  HomeLoadedState(this.selectedIndex, this.Teachers, this.User,
      this.meetingRequests, this.acceptedMeetings, this.meetingHistory);
}

class HomeErrorState extends HomeState {}

class HomeNavigateToLearnScreenState extends HomeActionState {
  final String id;
  final String studentName;
  final String imagepath;
  HomeNavigateToLearnScreenState(
      {required this.id, required this.studentName, required this.imagepath});
}

class HomeNavigateToTeachScreenState extends HomeActionState {}

class HomeNavigateToTeacherProfileScreenState extends HomeActionState {
  final String id;
  final String imagepath;
  final String fullname;
  HomeNavigateToTeacherProfileScreenState(
      {required this.id, required this.imagepath, required this.fullname});
}

class HomeNavigateToProfileScreenState extends HomeActionState {
  final user User;
  HomeNavigateToProfileScreenState({required this.User});
}

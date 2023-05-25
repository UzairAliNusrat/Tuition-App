part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}


class BottomNavigationBarItemHomeClickedEvent extends HomeEvent {

}

class BottomNavigationBarItemMeetingsClickedEvent extends HomeEvent {
  
}


class BottomNavigationBarItemChatClickedEvent extends HomeEvent {
  
}

class LearnButtonClickedEvent extends HomeEvent {

}

class TeachButtonClickedEvent extends HomeEvent {

}

class TeacherListItemClickedEvent extends HomeEvent {
}
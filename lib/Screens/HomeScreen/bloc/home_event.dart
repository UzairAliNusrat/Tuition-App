part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}


class bottomNavigationBarItemHomeClickedEvent extends HomeEvent {

}

class bottomNavigationBarItemCoursesClickedEvent extends HomeEvent {
  
}

class bottomNavigationBarItemMeetingsClickedEvent extends HomeEvent {
  
}

class bottomNavigationBarItemAccountClickedEvent extends HomeEvent {
  
}
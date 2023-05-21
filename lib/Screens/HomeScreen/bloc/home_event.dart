part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}


class bottomNavigationBarItemHomeClickedEvent extends HomeEvent {

}

class bottomNavigationBarItemMeetingsClickedEvent extends HomeEvent {
  
}


class bottomNavigationBarItemChatClickedEvent extends HomeEvent {
  
}
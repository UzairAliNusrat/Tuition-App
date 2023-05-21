import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(
        homeInitialEvent);

    on<bottomNavigationBarItemHomeClickedEvent>(
        BottomNavigationBarItemHomeClickedEvent);


    on<bottomNavigationBarItemMeetingsClickedEvent>(
        BottomNavigationBarItemMeetingsClickedEvent);

    on<bottomNavigationBarItemChatClickedEvent>(
        BottomNavigationBarItemChatClickedEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(HomeLoadedState(0));
  }

  FutureOr<void> BottomNavigationBarItemHomeClickedEvent(
      bottomNavigationBarItemHomeClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadedState(0));
    print("Home Clicked");
  }

  FutureOr<void> BottomNavigationBarItemMeetingsClickedEvent(
      bottomNavigationBarItemMeetingsClickedEvent event,
      Emitter<HomeState> emit) {
    emit(HomeLoadedState(1));
    print("Meetings Clicked");
  }

  FutureOr<void> BottomNavigationBarItemChatClickedEvent(
      bottomNavigationBarItemChatClickedEvent event,
      Emitter<HomeState> emit) {
    emit(HomeLoadedState(2));
    print("Chat Clicked");
  }

  
}

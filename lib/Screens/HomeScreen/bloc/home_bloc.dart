import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<BottomNavigationBarItemHomeClickedEvent>(
        bottomNavigationBarItemHomeClickedEvent);

    on<BottomNavigationBarItemMeetingsClickedEvent>(
        bottomNavigationBarItemMeetingsClickedEvent);

    on<BottomNavigationBarItemChatClickedEvent>(
        bottomNavigationBarItemChatClickedEvent);

    on<LearnButtonClickedEvent>(learnButtonClickedEvent);

    on<TeachButtonClickedEvent>(teachButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 1));
    emit(HomeLoadedState(0));
  }

  FutureOr<void> bottomNavigationBarItemHomeClickedEvent(
      BottomNavigationBarItemHomeClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadedState(0));
    print("Home Clicked");
  }

  FutureOr<void> bottomNavigationBarItemMeetingsClickedEvent(
      BottomNavigationBarItemMeetingsClickedEvent event,
      Emitter<HomeState> emit) {
    emit(HomeLoadedState(1));
    print("Meetings Clicked");
  }

  FutureOr<void> bottomNavigationBarItemChatClickedEvent(
      BottomNavigationBarItemChatClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadedState(2));
    print("Chat Clicked");
  }

  FutureOr<void> learnButtonClickedEvent(
      LearnButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToLearnScreenState());
  }

  FutureOr<void> teachButtonClickedEvent(
      TeachButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToTeachScreenState());
  }
}

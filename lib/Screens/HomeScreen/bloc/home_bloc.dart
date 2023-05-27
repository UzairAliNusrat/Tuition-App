import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Repositories/userRepository.dart';
import 'package:tuition_app_project/Utils/constants.dart';

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

    on<TeacherListItemClickedEvent>(teacherListItemClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Userrepo.userRepo.getUser(event.id);
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    emit(HomeLoadedState(0, teachers, Userrepo.userRepo.User));
  }

  Future<FutureOr<void>> bottomNavigationBarItemHomeClickedEvent(
      BottomNavigationBarItemHomeClickedEvent event,
      Emitter<HomeState> emit) async {
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    emit(HomeLoadedState(0, teachers, Userrepo.userRepo.User));
    print("Home Clicked");
  }

  FutureOr<void> bottomNavigationBarItemMeetingsClickedEvent(
      BottomNavigationBarItemMeetingsClickedEvent event,
      Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(HomeLoadedState(1, [], Userrepo.userRepo.User));
    print("Meetings Clicked");
  }

  FutureOr<void> bottomNavigationBarItemChatClickedEvent(
      BottomNavigationBarItemChatClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(HomeLoadedState(2, [], Userrepo.userRepo.User));
    print("Chat Clicked");
  }

  FutureOr<void> learnButtonClickedEvent(
      LearnButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToLearnScreenState(event.studentId));
  }

  FutureOr<void> teachButtonClickedEvent(
      TeachButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToTeachScreenState());
  }

  FutureOr<void> teacherListItemClickedEvent(
      TeacherListItemClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToTeacherProfileScreenState(id: event.id, imagepath: event.imagepath, fullname: event.fullname));
  }
}

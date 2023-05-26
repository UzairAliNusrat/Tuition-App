import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Repositories/teacherRepository.dart';
import 'package:tuition_app_project/Utils/constants.dart';

part 'findteachers_event.dart';
part 'findteachers_state.dart';

class FindteachersBloc extends Bloc<FindteachersEvent, FindteachersState> {
  FindteachersBloc() : super(FindteachersInitial()) {
    on<FindTeachersInitialEvent>(findTeachersInitialEvent);
  }

  FutureOr<void> findTeachersInitialEvent(
      FindTeachersInitialEvent event, Emitter<FindteachersState> emit) async {
    emit(FindTeachersLoadingState());
    List<user> teacherslist = [];
    FirebaseTeacherRepository teacherInfoRepository =
        FirebaseTeacherRepository();
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    List<Teacherinfo> teachersinfo = await teacherInfoRepository
        .fetchTeacherinfoListbySubject(event.subject);
    for (int i = 0; i < teachers.length; i++) {
      for (int j = 0; j < teachersinfo.length; j++) {
        if (teachers[i].id == teachersinfo[j].id) {
          teacherslist.add(teachers[i]);
          break;
        }
      }
    }
    emit(FindTeachersLoadedSuccessState(
        teachers: teacherslist));
  }
}

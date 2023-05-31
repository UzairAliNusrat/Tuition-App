import 'package:tuition_app_project/Repositories/meetingRequestRepository.dart';
import 'package:tuition_app_project/Repositories/studentRepository.dart';
import 'package:tuition_app_project/Repositories/teacherRepository.dart';
import 'package:tuition_app_project/Repositories/userRepository.dart';
import 'package:uuid/uuid.dart';

class Userrepo{
  static final FirebaseUserRepository userRepo = FirebaseUserRepository();
}

class MeetingRequestRepo{
  static final FirebaseMeetingRequestRepository meetingRequestRepo = FirebaseMeetingRequestRepository();
}

class StudentInfoRepo{
  static final FirebaseStudentRepository studentInfoRepo = FirebaseStudentRepository();
}

class TeacherInfoRepo{
  static final FirebaseTeacherRepository teacherInfoRepo = FirebaseTeacherRepository();
}

class IDgenerator{
  static const uuid = Uuid();
}
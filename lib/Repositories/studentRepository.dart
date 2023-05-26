import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuition_app_project/Models/studentInfoModel.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import '../Models/userModel.dart';

abstract class StudentRepository {
  setStudentInfo(Studentinfo studentinfo);
  Future<Studentinfo?> getStudentinfo(String teacherId);
}

class FirebaseStudentRepository implements StudentRepository {
  static var i = 0;
  final db = FirebaseFirestore.instance;
  List<user> teachers = [];
  late Studentinfo teacherinfo;
  
  @override
  getStudentinfo(String studentId) async {
    // Get the user document from Firestore based on the provided user ID
    final StudentDoc =
        await FirebaseFirestore.instance.collection("Student Information").doc(studentId).get();
    teacherinfo = Studentinfo.fromJson(StudentDoc);
  }
  
  @override
  setStudentInfo(Studentinfo studentinfo) async {
    await db.collection("Student Information").doc(studentinfo.id).set(studentinfo.toJson());
  }
  
  

  
}

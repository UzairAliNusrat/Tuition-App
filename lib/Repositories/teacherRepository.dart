import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import '../Models/userModel.dart';

abstract class TeacherRepository {
  setTeacherInfo(Teacherinfo teacher);
  Future<Teacherinfo?> getTeacher(String teacherId);
}

class FirebaseTeacherRepository implements TeacherRepository {
  static var i = 0;
  final db = FirebaseFirestore.instance;
  List<user> teachers = [];
  late Teacherinfo teacherinfo;
  
  @override
  Future<Teacherinfo> getTeacher(String teacherId) async {
    // Get the user document from Firestore based on the provided user ID
    final TeacherDoc =
        await FirebaseFirestore.instance.collection("Teacher Information").doc(teacherId).get();
    return Teacherinfo.fromJson(TeacherDoc);
  }
  
  @override
  setTeacherInfo(Teacherinfo teacher) async {
    await db.collection("Teacher Information").doc(teacher.id).set(teacher.toJson());
  }
  
  

  
}

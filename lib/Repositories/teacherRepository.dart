import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import '../Models/userModel.dart';

abstract class TeacherRepository {
  setTeacherInfo(Teacherinfo teacher);
  Future<Teacherinfo?> getTeacher(String teacherId);
  Future<List<Teacherinfo>> fetchTeacherinfoListbySubject(String subject);
}

class FirebaseTeacherRepository implements TeacherRepository {
  final db = FirebaseFirestore.instance;

  @override
  Future<Teacherinfo> getTeacher(String teacherId) async {
    // Get the user document from Firestore based on the provided user ID
    final TeacherDoc = await FirebaseFirestore.instance
        .collection("Teacher Information")
        .doc(teacherId)
        .get();
    return Teacherinfo.fromJson(TeacherDoc);
  }

  @override
  Future<List<Teacherinfo>> fetchTeacherinfoListbySubject(
      String subject) async {
    List<Teacherinfo> teachersinfo = [];
    final QuerySnapshot result =
        await db.collection("Teacher Information").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
    for (var element in documents) {
      for (int i = 0; i < Teacherinfo.fromJson(element).subjects.length; i++) {
        if (Teacherinfo.fromJson(element).subjects[i].trim().toLowerCase() ==
            subject) {
          teachersinfo.add(Teacherinfo.fromJson(element));
        }
      }
    }
    return teachersinfo;
  }

  @override
  setTeacherInfo(Teacherinfo teacher) async {
    await db
        .collection("Teacher Information")
        .doc(teacher.id)
        .set(teacher.toJson());
  }
}

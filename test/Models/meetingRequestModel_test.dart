import 'package:flutter_test/flutter_test.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';

void main() {
  group('meetingRequestModel Tests', () {
    late meetingRequestModel model;

    setUp(() {
      model = meetingRequestModel(
        meetingId: '1',
        teacherId: 'teacher123',
        studentId: 'student456',
        studentName: 'John Doe',
        Studentimagepath: 'path/to/image',
        subject: 'Math',
        topic: 'Algebra',
        note: 'Please bring your textbook.',
        teacherName: 'Jane Smith',
        teacherimagepath: 'path/to/image',
      );
    });

    test('fromJson() should create a meetingRequestModel instance from JSON', () {
      final json = {
        'meetingId': '1',
        'teacherId': 'teacher123',
        'studentId': 'student456',
        'studentName': 'John Doe',
        'Studentimagepath': 'path/to/image',
        'subject': 'Math',
        'topic': 'Algebra',
        'note': 'Please bring your textbook.',
        'teacherName': 'Jane Smith',
        'teacherimagepath': 'path/to/image',
      };

      final result = meetingRequestModel.fromJson(json);

      expect(result, isA<meetingRequestModel>());
      expect(result.meetingId, '1');
      expect(result.teacherId, 'teacher123');
      expect(result.studentId, 'student456');
      expect(result.studentName, 'John Doe');
      expect(result.Studentimagepath, 'path/to/image');
      expect(result.subject, 'Math');
      expect(result.topic, 'Algebra');
      expect(result.note, 'Please bring your textbook.');
      expect(result.teacherName, 'Jane Smith');
      expect(result.teacherimagepath, 'path/to/image');
    });

    test('toJson() should convert a meetingRequestModel instance to JSON', () {
      final result = model.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['meetingId'], '1');
      expect(result['teacherId'], 'teacher123');
      expect(result['studentId'], 'student456');
      expect(result['studentName'], 'John Doe');
      expect(result['Studentimagepath'], 'path/to/image');
      expect(result['subject'], 'Math');
      expect(result['topic'], 'Algebra');
      expect(result['note'], 'Please bring your textbook.');
      expect(result['teacherName'], 'Jane Smith');
      expect(result['teacherimagepath'], 'path/to/image');
    });
  });
}

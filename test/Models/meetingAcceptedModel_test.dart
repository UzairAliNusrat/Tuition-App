import 'package:flutter_test/flutter_test.dart';
import 'package:tuition_app_project/Models/meetingAcceptedModel.dart';
void main() {
  group('meetingAcceptedModel Tests', () {
    late meetingAcceptedModel model;

    setUp(() {
      model = meetingAcceptedModel(
        meetingId: '1',
        teacherId: 'teacher123',
        studentId: 'student456',
        studentName: 'John Doe',
        studentimagepath: 'path/to/image',
        subject: 'Math',
        topic: 'Algebra',
        note: 'Please bring your textbook.',
        date: '2023-06-01',
        time: '10:00 AM',
        teacherName: 'Jane Smith',
        teacherimagepath: 'path/to/image',
      );
    });

    test('fromJson() should create a meetingAcceptedModel instance from JSON', () {
      final json = {
        'meetingId': '1',
        'teacherId': 'teacher123',
        'studentId': 'student456',
        'studentName': 'John Doe',
        'studentimagepath': 'path/to/image',
        'subject': 'Math',
        'topic': 'Algebra',
        'note': 'Please bring your textbook.',
        'date': '2023-06-01',
        'time': '10:00 AM',
        'teacherName': 'Jane Smith',
        'teacherimagepath': 'path/to/image',
      };

      final result = meetingAcceptedModel.fromJson(json);

      expect(result, isA<meetingAcceptedModel>());
      expect(result.meetingId, '1');
      expect(result.teacherId, 'teacher123');
      expect(result.studentId, 'student456');
      expect(result.studentName, 'John Doe');
      expect(result.studentimagepath, 'path/to/image');
      expect(result.subject, 'Math');
      expect(result.topic, 'Algebra');
      expect(result.note, 'Please bring your textbook.');
      expect(result.date, '2023-06-01');
      expect(result.time, '10:00 AM');
      expect(result.teacherName, 'Jane Smith');
      expect(result.teacherimagepath, 'path/to/image');
    });

    test('toJson() should convert a meetingAcceptedModel instance to JSON', () {
      final result = model.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['meetingId'], '1');
      expect(result['teacherId'], 'teacher123');
      expect(result['studentId'], 'student456');
      expect(result['studentName'], 'John Doe');
      expect(result['studentimagepath'], 'path/to/image');
      expect(result['subject'], 'Math');
      expect(result['topic'], 'Algebra');
      expect(result['note'], 'Please bring your textbook.');
      expect(result['date'], '2023-06-01');
      expect(result['time'], '10:00 AM');
      expect(result['teacherName'], 'Jane Smith');
      expect(result['teacherimagepath'], 'path/to/image');
    });
  });
}

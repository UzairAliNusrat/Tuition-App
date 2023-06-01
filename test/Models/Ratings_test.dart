import 'package:flutter_test/flutter_test.dart';
import 'package:tuition_app_project/Models/Ratings.dart';

void main() {
  group('Ratings Tests', () {
    late Ratings model;

    setUp(() {
      model = Ratings(
        rating: 4.5,
        userId: 'user123',
        ratingID: 'rating456',
      );
    });

    test('fromJson() should create a Ratings instance from JSON', () {
      final json = {
        'rating': 4.5,
        'user_id': 'user123',
        'ratingID': 'rating456',
      };

      final result = Ratings.fromJson(json);

      expect(result, isA<Ratings>());
      expect(result.rating, 4.5);
      expect(result.userId, 'user123');
      expect(result.ratingID, 'rating456');
    });

    test('toJson() should convert a Ratings instance to JSON', () {
      final result = model.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['rating'], 4.5);
      expect(result['user_id'], 'user123');
      expect(result['ratingID'], 'rating456');
    });
  });
}

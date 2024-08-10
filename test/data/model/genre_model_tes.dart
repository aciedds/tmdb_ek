import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_ek/data/model/genre_model/genre_model.dart';

void main() {
  group('GenreModel', () {
    test(
        'GenreModel.fromJson creates a GenreModel instance from a valid JSON map',
        () {
      final json = {
        'id': 1,
        'name': 'Action',
      };
      final genre = GenreModel.fromJson(json);

      expect(genre.id, 1);
      expect(genre.name, 'Action');
    });

    test('GenreModel.toJson converts a GenreModel instance to a JSON map', () {
      final genre = GenreModel(
        id: 1,
        name: 'Action',
      );

      final json = genre.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Action');
    });
  });
}

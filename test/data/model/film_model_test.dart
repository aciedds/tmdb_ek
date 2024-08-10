import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb_ek/data/model/film_model/film_model.dart';

void main() {
  group('FilmModel', () {
    test(
        'FilmModel.fromJson creates a FilmModel instance from a valid JSON map',
        () {
      final json = {
        'id': 1,
        'title': 'Movie Title',
        'overview': 'Movie overview',
        'backdrop_path': '/backdrop.jpg',
        'poster_path': '/poster.jpg',
        'release_date': '2023-12-08',
        'vote_average': 8.5,
        'genre_ids': [1, 2, 3],
      };

      final film = FilmModel.fromJson(json);

      expect(film.id, 1);
      expect(film.title, 'Movie Title');
      expect(film.overview, 'Movie overview');
      expect(film.backdropPath, '/backdrop.jpg');
      expect(film.posterPath, '/poster.jpg');
      expect(film.releaseDate, '2023-12-08');
      expect(film.voteAverage, 8.5);
      expect(film.genreIds, [1, 2, 3]);
    });

    test('FilmModel.toJson converts a FilmModel instance to a JSON map', () {
      final film = FilmModel(
        id: 1,
        title: 'Movie Title',
        overview: 'Movie overview',
        backdropPath: '/backdrop.jpg',
        posterPath: '/poster.jpg',
        releaseDate: '2023-12-08',
        voteAverage: 8.5,
        genreIds: [1, 2, 3],
      );

      final json = film.toJson();

      expect(json['id'], 1);
      expect(json['title'], 'Movie Title');
      expect(json['overview'], 'Movie overview');
      expect(json['backdrop_path'], '/backdrop.jpg');
      expect(json['poster_path'], '/poster.jpg');
      expect(json['release_date'], '2023-12-08');
      expect(json['vote_average'], 8.5);
      expect(json['genre_ids'], [1, 2, 3]);
    });
  });
}

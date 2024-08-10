import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb_ek/data/model/film_model/film_model.dart';
import 'package:tmdb_ek/data/model/genre_model/genre_model.dart';
import 'package:tmdb_ek/data/repository/source/film_remote.dart';
import 'package:tmdb_ek/utils/dio_utils.dart';

import 'film_remote_test.mocks.dart';

// Generate mocks using: flutter pub run build_runner build
@GenerateMocks([Dio])
void main() {
  late FilmRemote filmRemoteMock;
  late FilmRemote filmRemote;
  late MockDio mockDio;
  late Dio dio;
  setUp(() async {
    mockDio = MockDio();
    dio = await DioUtils.client();
    filmRemoteMock = FilmRemote(mockDio);
    filmRemote = FilmRemote(dio);
  });

  group('FilmRemote - Positive Cases', () {
    test(
        'getNowPlayingFilms returns DataState.success with a list of FilmModel',
        () async {
      // Mock the Dio response
      when(mockDio.get(
        '/movie/now_playing',
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: {
              'results': [
                {
                  'id': 1,
                  'title': 'Movie 1',
                  // ... other film data
                },
                {
                  'id': 2,
                  'title': 'Movie 2',
                  // ... other film data
                },
              ],
            },
            requestOptions: RequestOptions(path: ''),
          ));

      final result = await filmRemoteMock.getNowPlayingFilms();
      result.when(
        success: (data) {
          expect(data, isA<List<FilmModel>>());
          expect(data[0].id, 1);
          expect(data[1].id, 2);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('getPopularFilms returns DataState.success with a list of FilmModel',
        () async {
      when(mockDio.get(
        '/movie/popular',
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: {
              'results': [
                {
                  'id': 3,
                  'title': 'Movie 3',
                  // ... other film data
                },
                {
                  'id': 4,
                  'title': 'Movie 4',
                  // ... other film data
                },
              ],
            },
            requestOptions: RequestOptions(path: ''),
          ));

      final result = await filmRemoteMock.getPopularFilms();
      result.when(
        success: (data) {
          expect(data, isA<List<FilmModel>>());
          expect(data, isNotEmpty);
          expect(data[0].id, 3);
          expect(data[1].id, 4);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('getSimilarFilms returns DataState.success with a list of FilmModel',
        () async {
      const int filmId = 1;
      when(mockDio.get(
        '/movie/$filmId/similar',
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: {
              'results': [
                {
                  'id': 5,
                  'title': 'Movie 5',
                  // ... other film data
                },
                {
                  'id': 6,
                  'title': 'Movie 6',
                  // ... other film data
                },
              ],
            },
            requestOptions: RequestOptions(path: ''),
          ));

      final result = await filmRemoteMock.getSimilarFilms(id: filmId);
      result.when(
        success: (data) {
          expect(data, isA<List<FilmModel>>());
          expect(data, isNotEmpty);
          expect(data[0].id, 5);
          expect(data[1].id, 6);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test(
        'getSimilarFilmsBySameGenreIds returns DataState.success with a list of FilmModel',
        () async {
      final List<int> genreIds = [1, 2, 3];
      when(mockDio.get(
        '/discover/movie',
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: {
              'results': [
                {
                  'id': 7,
                  'title': 'Movie 7',
                  // ... other film data
                },
                {
                  'id': 8,
                  'title': 'Movie 8',
                  // ... other film data
                },
              ],
            },
            requestOptions: RequestOptions(path: ''),
          ));

      final result =
          await filmRemoteMock.getSimilarFilmsBySameGenreIds(ids: genreIds);
      result.when(
        success: (data) {
          expect(data, isA<List<FilmModel>>());
          expect(data, isNotEmpty);
          expect(data[0].id, 7);
          expect(data[1].id, 8);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('searchFilms returns DataState.success with a list of FilmModel',
        () async {
      const String query = 'test';
      when(mockDio.get(
        '/search/movie',
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            data: {
              'results': [
                {
                  'id': 9,
                  'title': 'Movie 9',
                  // ... other film data
                },
                {
                  'id': 10,
                  'title': 'Movie 10',
                  // ... other film data
                },
              ],
            },
            requestOptions: RequestOptions(path: ''),
          ));

      final result = await filmRemoteMock.searchFilms(query: query);
      result.when(
        success: (data) {
          expect(data, isA<List<FilmModel>>());
          expect(data, isNotEmpty);
          expect(data[0].id, 9);
          expect(data[1].id, 10);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('getMovieGenres returns DataState.success with a list of Genres',
        () async {
      when(mockDio.get('/genre/movie/list')).thenAnswer((_) async => Response(
            data: {
              'genres': [
                {
                  'id': 1,
                  'name': 'Genre 1',
                  // ... other film data
                },
                {
                  'id': 2,
                  'title': 'Genre 2',
                  // ... other film data
                },
              ],
            },
            requestOptions: RequestOptions(path: ''),
          ));

      final result = await filmRemoteMock.getMovieGenres();
      result.when(
        success: (data) {
          expect(data, isA<List<GenreModel>>());
          expect(data, isNotEmpty);
          expect(data[0].id, 1);
          expect(data[1].id, 2);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });
  });

  group('FilmRemote - Negative Cases', () {
    test('getNowPlayingFilms returns DataState.error on DioException',
        () async {
      // Mock a DioError
      when(
        mockDio.get(
          '/movie/now_playing',
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(DioException(
        message: 'Test error',
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await filmRemoteMock.getNowPlayingFilms();
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Test error');
        },
      );
    });

    test('getPopularFilms returns DataState.error on DioException', () async {
      when(mockDio.get(
        '/movie/popular',
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(DioException(
        message: 'Test error',
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await filmRemoteMock.getPopularFilms();
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Test error');
        },
      );
    });

    test('getSimilarFilms returns DataState.error on DioException', () async {
      const int filmId = 1;
      when(mockDio.get(
        '/movie/$filmId/similar',
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(DioException(
        message: 'Test error',
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await filmRemoteMock.getSimilarFilms(id: filmId);
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Test error');
        },
      );
    });

    test(
        'getSimilarFilmsBySameGenreIds returns DataState.error on DioException',
        () async {
      final List<int> genreIds = [1, 2, 3];
      when(mockDio.get(
        '/discover/movie',
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(DioException(
        message: 'Test error',
        requestOptions: RequestOptions(path: ''),
      ));

      final result =
          await filmRemoteMock.getSimilarFilmsBySameGenreIds(ids: genreIds);
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Test error');
        },
      );
    });

    test('searchFilms returns DataState.error on DioException', () async {
      const String query = 'test';
      when(mockDio.get(
        '/search/movie',
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(DioException(
        message: 'Test error',
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await filmRemoteMock.searchFilms(query: query);
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Test error');
        },
      );
    });

    test('genres movie returns DataState.error on DioException', () async {
      when(mockDio.get('/genre/movie/list')).thenThrow(DioException(
        message: 'Test error',
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await filmRemoteMock.getMovieGenres();
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Test error');
        },
      );
    });
  });

  group('FilmRemote - Integration Case', () {
    test('getNowPlayingFilms', () async {
      final result = await filmRemote.getNowPlayingFilms();
      result.when(
        success: (data) {
          data.map((e) => log("$e"));
          expect(data, isA<List<FilmModel>>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('getPopularFilms ', () async {
      final result = await filmRemote.getPopularFilms();
      result.when(
        success: (data) {
          data.map((e) => log("$e"));
          expect(data, isA<List<FilmModel>>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('getSimilarFilms', () async {
      const int filmId = 533535;
      final result = await filmRemote.getSimilarFilms(id: filmId);
      result.when(
        success: (data) {
          data.map((e) => log("$e"));
          expect(data, isA<List<FilmModel>>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('getSimilarFilmsBySameGenreIds ', () async {
      final List<int> genreIds = [28, 12, 16];
      final result = await filmRemote.getSimilarFilmsBySameGenreIds(
        ids: genreIds,
      );
      result.when(
        success: (data) {
          data.map((e) => log("$e"));
          expect(data, isA<List<FilmModel>>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('searchFilms', () async {
      const String query = 'dead';
      final result = await filmRemote.searchFilms(query: query);
      result.when(
        success: (data) {
          data.map((e) => log("$e"));
          expect(data, isA<List<FilmModel>>());
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });
  });

  test('GetMovieGenres', () async {
    final result = await filmRemote.getMovieGenres();
    result.when(
      success: (data) {
        data.map((e) => log("$e"));
        expect(data, isA<List<GenreModel>>());
      },
      error: (message, data, exception, stackTrace, statusCode) {},
    );
  });
}

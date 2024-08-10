import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/data/model/film_model/film_model.dart';
import 'package:tmdb_ek/data/model/genre_model/genre_model.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

@lazySingleton
class FilmRemote {
  final Dio _dio;

  const FilmRemote(this._dio);

  Future<DataState<List<FilmModel>>> getNowPlayingFilms({int page = 1}) async {
    try {
      String path = '/movie/now_playing';
      final response = await _dio.get(path, queryParameters: {'page': page});

      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<FilmModel>>> getPopularFilms({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );

      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();
      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<FilmModel>>> getSimilarFilms({
    required int id,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        '/movie/$id/similar',
        queryParameters: {'page': page},
      );
      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<FilmModel>>> getSimilarFilmsBySameGenreIds({
    required List<int> ids,
    int page = 1,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'include_adult': false,
        'include_video': false,
        'language': 'en-US',
        'page': page,
        'sort_by': 'popularity.desc',
        'with_genres': ids.join(','),
      };
      final response = await _dio.get(
        '/discover/movie',
        queryParameters: queryParams,
      );
      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<FilmModel>>> searchFilms({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get('/search/movie', queryParameters: {
        'query': query,
        'page': page,
      });

      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<GenreModel>>> getMovieGenres() async {
    try {
      final response = await _dio.get('/genre/movie/list');

      final result = (response.data['genres'] as List)
          .map((e) => GenreModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }
}

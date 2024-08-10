import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/entity/genre_entity/genre_entity.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

abstract class FilmRepository {
  Future<DataState<List<FilmEntity>>> getNowPlayingFilms({int page = 1});

  Future<DataState<List<FilmEntity>>> getPopularFilms({int page = 1});

  Future<DataState<List<FilmEntity>>> getSimilarFilms({
    required int id,
    int page = 1,
  });

  Future<DataState<List<FilmEntity>>> getSimilarFilmsBySameGenreIds({
    required List<String> genres,
    int page = 1,
  });

  Future<DataState<List<FilmEntity>>> searchFilms({
    required String query,
    int page = 1,
  });

  Future<DataState<List<GenreEntity>>> getMovieGenres();

  Future<DataState<bool>> addWatchlist({required FilmEntity data});

  Future<DataState<List<FilmEntity>>> getListWatchlist();

  Future<DataState<bool>> addFavorite({required FilmEntity data});

  Future<DataState<List<FilmEntity>>> getListFavorite();

  DataState<bool> isOnWatchlist(int id);

  DataState<bool> isOnFavorite(int id);

  DataState<bool> removeFromWatchlist(int id);

  DataState<bool> removeFromFavorite(int id);
}

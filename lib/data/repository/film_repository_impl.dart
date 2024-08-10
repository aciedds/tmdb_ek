import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/data/repository/source/film_local.dart';
import 'package:tmdb_ek/data/repository/source/film_remote.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/entity/genre_entity/genre_entity.dart';
import 'package:tmdb_ek/domain/mapper/film_mapper.dart';
import 'package:tmdb_ek/domain/mapper/genre_mapper.dart';
import 'package:tmdb_ek/domain/repository/film_repository.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

@LazySingleton(as: FilmRepository)
class FilmRepositoryImpl implements FilmRepository {
  final FilmRemote _remote;
  final FilmLocal _local;
  final FilmMapper _filmMapper;
  final GenreMapper _genreMapepr;

  FilmRepositoryImpl(
    this._remote,
    this._local,
    this._filmMapper,
    this._genreMapepr,
  );

  @override
  Future<DataState<List<GenreEntity>>> getMovieGenres() async {
    final localResult = _local.getGenreList();
    return localResult.when(
      success: (data) => DataState.success(
        data: _genreMapepr.mapModelToEntity(data),
      ),
      error: (message, data, exception, stackTrace, statusCode) async {
        final remoteResult = await _remote.getMovieGenres();
        return remoteResult.when(
          success: (data) {
            _local.addListGenre(data: data);
            return DataState.success(data: _genreMapepr.mapModelToEntity(data));
          },
          error: (message, data, exception, stackTrace, statusCode) {
            return DataState.error(
              message: message,
              stackTrace: stackTrace,
              exception: exception,
              statusCode: statusCode,
            );
          },
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getNowPlayingFilms({int page = 1}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.getNowPlayingFilms(page: page);
    return result.when(
      success: (remoteData) async {
        if (page == 1) {
          _local.clearListNowPlaying();
          _local.addListNowPlaying(nowPlayingList: remoteData);
        } else {
          _local.addListNowPlaying(nowPlayingList: remoteData);
        }
        final localResult = _local.getListNowPlaying();
        return localResult.when(
          success: (data) async {
            final filmList = await Future.wait(data.map((e) {
              return _filmMapper.mapModelToEntity(
                filmModel: e,
                genreEntitys: genres,
              );
            }).toList());
            return DataState.success(data: filmList);
          },
          error: (message, data, exception, stackTrace, statusCode) {
            return DataState.error(
              message: message,
              stackTrace: stackTrace,
              exception: exception,
              statusCode: statusCode,
            );
          },
        );
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getPopularFilms({int page = 1}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.getPopularFilms(page: page);
    return result.when(
      success: (remoteData) async {
        if (page == 1) {
          _local.clearListPopular();
          _local.addListPopular(popularList: remoteData);
        } else {
          _local.addListPopular(popularList: remoteData);
        }
        final localResult = _local.getListPopular();
        return localResult.when(
          success: (data) async {
            final filmList = await Future.wait(data.map((e) {
              return _filmMapper.mapModelToEntity(
                filmModel: e,
                genreEntitys: genres,
              );
            }).toList());
            return DataState.success(data: filmList);
          },
          error: (message, data, exception, stackTrace, statusCode) {
            return DataState.error(
              message: message,
              stackTrace: stackTrace,
              exception: exception,
              statusCode: statusCode,
            );
          },
        );
      },
      error: (message, data, exception, stackTrace, statusCode) {
        final localResult = _local.getListNowPlaying();
        return localResult.when(
          success: (data) async {
            final filmList = await Future.wait(data.map((e) {
              return _filmMapper.mapModelToEntity(
                filmModel: e,
                genreEntitys: genres,
              );
            }).toList());
            return DataState.success(data: filmList);
          },
          error: (message, data, exception, stackTrace, statusCode) {
            return DataState.error(
              message: message,
              stackTrace: stackTrace,
              exception: exception,
              statusCode: statusCode,
            );
          },
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getSimilarFilms({
    required int id,
    int page = 1,
  }) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.getSimilarFilms(id: id, page: page);
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(data.map((e) {
          return _filmMapper.mapModelToEntity(
            filmModel: e,
            genreEntitys: genres,
          );
        }).toList());
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getSimilarFilmsBySameGenreIds({
    required List<String> genres,
    int page = 1,
  }) async {
    List<GenreEntity> genreEntities = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genreEntities = genresResult.data!;
    }

    List<int> genreIds = genres
        .map((e) => genreEntities.firstWhere((genre) => genre.name == e).id)
        .toList();

    final result = await _remote.getSimilarFilmsBySameGenreIds(
      ids: genreIds,
      page: page,
    );
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(data.map((e) {
          return _filmMapper.mapModelToEntity(
            filmModel: e,
            genreEntitys: genreEntities,
          );
        }).toList());
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> searchFilms(
      {required String query, int page = 1}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.searchFilms(query: query, page: page);
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(data.map((e) {
          return _filmMapper.mapModelToEntity(
            filmModel: e,
            genreEntitys: genres,
          );
        }).toList());
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<bool>> addFavorite({required FilmEntity data}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    return _local.addFavorite(
      favoriteData: _filmMapper.mapEntityToModel(
        filmEntity: data,
        genreEntitys: genres,
      ),
    );
  }

  @override
  Future<DataState<bool>> addWatchlist({required FilmEntity data}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    return _local.addWatchlist(
      watchlistData: _filmMapper.mapEntityToModel(
        filmEntity: data,
        genreEntitys: genres,
      ),
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getListFavorite() async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = _local.getListFavorite();
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(data.map((e) {
          return _filmMapper.mapModelToEntity(
            filmModel: e,
            genreEntitys: genres,
          );
        }).toList());
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getListWatchlist() async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = _local.getListWatchlist();
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(data.map((e) {
          return _filmMapper.mapModelToEntity(
            filmModel: e,
            genreEntitys: genres,
          );
        }).toList());
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  DataState<bool> isOnFavorite(int id) => _local.isOnFavorited(id);

  @override
  DataState<bool> isOnWatchlist(int id) => _local.isOnWatchlist(id);

  @override
  DataState<bool> removeFromFavorite(int id) => _local.removeFromFavorite(id);

  @override
  DataState<bool> removeFromWatchlist(int id) => _local.removeFromWatchlist(id);
}

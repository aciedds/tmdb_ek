import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/data/model/film_model/film_model.dart';
import 'package:tmdb_ek/data/model/genre_model/genre_model.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';
import 'package:tmdb_ek/utils/hive_utils.dart';

@lazySingleton
class FilmLocal {
  final HiveUtils _hiveUtils;

  FilmLocal(this._hiveUtils);

  DataState<bool> addWatchlist({required FilmModel watchlistData}) {
    try {
      final result = getListFavorite();
      return result.when(
        success: (result) {
          List<FilmModel> temp = result;
          if (temp.any((e) => e.id == watchlistData.id)) {
            temp.removeWhere((element) => element.id == watchlistData.id);
          }
          temp.add(watchlistData);
          _hiveUtils.set<List<FilmModel>>(
            key: 'watchList',
            data: jsonEncode(temp.map((e) => e.toJson()).toList()),
          );
          return const DataState.success(data: true);
        },
        error: (message, data, exception, stackTrace, statusCode) {
          List<FilmModel> temp = [];
          temp.add(watchlistData);
          _hiveUtils.set<List<FilmModel>>(
            key: 'watchList',
            data: jsonEncode(temp.map((e) => e.toJson()).toList()),
          );
          return const DataState.success(data: true);
        },
      );
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<List<FilmModel>> getListWatchlist() {
    try {
      final raw = _hiveUtils.get(key: "watchList");
      if (raw != null) {
        final List result = jsonDecode(raw);
        return DataState.success(
          data: result.map((e) => FilmModel.fromJson(e)).toList(),
        );
      }
      return const DataState.error(message: "Data not found");
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> isOnWatchlist(int id) {
    try {
      final raw = _hiveUtils.get(key: "watchList");
      if (raw != null) {
        final List result = jsonDecode(raw);
        final contains = result.any((element) => element['id'] == id);
        return DataState.success(data: contains);
      }
      return const DataState.error(message: "Data not found");
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> removeFromWatchlist(int id) {
    try {
      final raw = _hiveUtils.get(key: "watchList");
      if (raw != null) {
        final List result = jsonDecode(raw);
        result.removeWhere((element) => element['id'] == id);
        _hiveUtils.set<List<FilmModel>>(
          key: 'watchList',
          data: jsonEncode(result.map((e) => e).toList()),
        );
        return const DataState.success(data: true);
      }
      return const DataState.error(message: "Data not found");
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> addFavorite({required FilmModel favoriteData}) {
    try {
      final result = getListFavorite();
      return result.when(
        success: (result) {
          List<FilmModel> temp = result;
          if (temp.any((e) => e.id == favoriteData.id)) {
            temp.removeWhere((element) => element.id == favoriteData.id);
          }
          temp.add(favoriteData);
          _hiveUtils.set<List<FilmModel>>(
            key: 'favoriteList',
            data: jsonEncode(temp.map((e) => e.toJson()).toList()),
          );
          return const DataState.success(data: true);
        },
        error: (message, data, exception, stackTrace, statusCode) {
          List<FilmModel> temp = [];
          temp.add(favoriteData);
          _hiveUtils.set<List<FilmModel>>(
            key: 'favoriteList',
            data: jsonEncode(temp.map((e) => e.toJson()).toList()),
          );
          return const DataState.success(data: true);
        },
      );
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<List<FilmModel>> getListFavorite() {
    try {
      final raw = _hiveUtils.get(key: "favoriteList");
      if (raw != null) {
        final List result = jsonDecode(raw);
        return DataState.success(
          data: result.map((e) => FilmModel.fromJson(e)).toList(),
        );
      }
      return const DataState.error(message: "Data not found");
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> isOnFavorited(int id) {
    try {
      final raw = _hiveUtils.get(key: "favoriteList");
      if (raw != null) {
        final List result = jsonDecode(raw);
        final contains = result.any((element) => element['id'] == id);
        return DataState.success(data: contains);
      }
      return const DataState.error(message: "Data not found");
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> removeFromFavorite(int id) {
    try {
      final raw = _hiveUtils.get(key: "favoriteList");
      if (raw != null) {
        final List result = jsonDecode(raw);
        result.removeWhere((element) => element['id'] == id);
        _hiveUtils.set<List<FilmModel>>(
          key: 'favoriteList',
          data: jsonEncode(result.map((e) => e).toList()),
        );
        return const DataState.success(data: true);
      }
      return const DataState.error(message: "Data not found");
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> addListGenre({required List<GenreModel> data}) {
    try {
      _hiveUtils.set<List<GenreModel>>(
        key: 'genreList',
        data: jsonEncode(data.map((e) => e.toJson()).toList()),
      );
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<List<GenreModel>> getGenreList() {
    try {
      final raw = _hiveUtils.get(key: "genreList");
      if (raw != null) {
        final List result = jsonDecode(raw);
        return DataState.success(
          data: result.map((e) => GenreModel.fromJson(e)).toList(),
        );
      }
      return const DataState.error(message: "Data not found");
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> addListPopular({required List<FilmModel> popularList}) {
    try {
      final result = getListPopular();
      return result.when(
        success: (result) {
          List<FilmModel> temp = result;
          for (var element in popularList) {
            if (temp.any((e) => e.id == element.id)) {
              temp.removeWhere((element) => element.id == element.id);
            } else {
              temp.add(element);
            }
          }
          _hiveUtils.set<List<FilmModel>>(
            key: 'popularList',
            data: jsonEncode(temp.map((e) => e.toJson()).toList()),
          );
          return const DataState.success(data: true);
        },
        error: (message, data, exception, stackTrace, statusCode) {
          List<FilmModel> temp = [];
          temp.addAll(popularList);
          _hiveUtils.set<List<FilmModel>>(
            key: 'popularList',
            data: jsonEncode(temp.map((e) => e.toJson()).toList()),
          );
          return const DataState.success(data: true);
        },
      );
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<List<FilmModel>> getListPopular() {
    try {
      final raw = _hiveUtils.get(key: "popularList");
      if (raw != null) {
        final List result = jsonDecode(raw);
        return DataState.success(
          data: result.map((e) => FilmModel.fromJson(e)).toList(),
        );
      }
      return const DataState.error(message: "Data not found");
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> clearListPopular() {
    try {
      _hiveUtils.delete("popularList");
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> addListNowPlaying({required List<FilmModel> nowPlayingList}) {
    try {
      final result = getListNowPlaying();
      return result.when(
        success: (result) {
          List<FilmModel> temp = result;
          for (var element in nowPlayingList) {
            if (temp.any((e) => e.id == element.id)) {
              temp.removeWhere((element) => element.id == element.id);
            } else {
              temp.add(element);
            }
          }
          _hiveUtils.set<List<FilmModel>>(
            key: 'nowPlayingList',
            data: jsonEncode(temp.map((e) => e.toJson()).toList()),
          );
          return const DataState.success(data: true);
        },
        error: (message, data, exception, stackTrace, statusCode) {
          List<FilmModel> temp = [];
          temp.addAll(nowPlayingList);
          _hiveUtils.set<List<FilmModel>>(
            key: 'nowPlayingList',
            data: jsonEncode(temp.map((e) => e.toJson()).toList()),
          );
          return const DataState.success(data: true);
        },
      );
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<List<FilmModel>> getListNowPlaying() {
    try {
      final raw = _hiveUtils.get(key: "nowPlayingList");
      if (raw != null) {
        final List result = jsonDecode(raw);
        return DataState.success(
          data: result.map((e) => FilmModel.fromJson(e)).toList(),
        );
      }
      return const DataState.error(message: "Data not found");
    } catch (e) {
      return DataState.error(exception: e);
    }
  }

  DataState<bool> clearListNowPlaying() {
    try {
      _hiveUtils.delete("nowPlayingList");
      return const DataState.success(data: true);
    } catch (e) {
      return DataState.error(exception: e);
    }
  }
}

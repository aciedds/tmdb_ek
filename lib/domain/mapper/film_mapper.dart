import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/data/model/film_model/film_model.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/entity/genre_entity/genre_entity.dart';
import 'package:tmdb_ek/utils/image_utils.dart';

@injectable
class FilmMapper {
  Future<FilmEntity> mapModelToEntity({
    required FilmModel filmModel,
    required List<GenreEntity> genreEntitys,
  }) async {
    List<String> genres = [];
    if (filmModel.genreIds != null) {
      genres = filmModel.genreIds!
          .map((e) => genreEntitys.firstWhere((genre) => genre.id == e).name)
          .toList();
    }

    String? posterBase64Image;
    if (filmModel.posterPath != null) {
      if (!_isBase64Encoded(filmModel.posterPath!)) {
        posterBase64Image =
            await ImageUtils.imageToBase64(filmModel.posterPath!);
      } else {
        posterBase64Image = filmModel.posterPath;
      }
    }

    String? backdropBase64Image;
    if (filmModel.backdropPath != null) {
      if (!_isBase64Encoded(filmModel.backdropPath!)) {
        backdropBase64Image =
            await ImageUtils.imageToBase64(filmModel.backdropPath!);
      } else {
        backdropBase64Image = filmModel.backdropPath;
      }
    }

    return FilmEntity(
      id: filmModel.id ?? 0,
      title: filmModel.title ?? '',
      overview: filmModel.overview ?? '',
      backdropPath: backdropBase64Image ?? '',
      posterPath: posterBase64Image ?? '',
      releaseDate: filmModel.releaseDate ?? '',
      voteAverage: filmModel.voteAverage ?? 0.0,
      genres: genres,
    );
  }

  bool _isBase64Encoded(String data) {
    final base64Pattern = RegExp(r'^[A-Za-z0-9+/]+={0,2}$');
    if (!base64Pattern.hasMatch(data) || data.length % 4 != 0) {
      return false;
    }
    try {
      base64Decode(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  FilmModel mapEntityToModel({
    required FilmEntity filmEntity,
    required List<GenreEntity> genreEntitys,
  }) {
    List<int> genreIds = filmEntity.genres
        .map((e) => genreEntitys.firstWhere((genre) => genre.name == e).id)
        .toList();

    return FilmModel(
      id: filmEntity.id,
      title: filmEntity.title,
      overview: filmEntity.overview,
      backdropPath: filmEntity.backdropPath,
      posterPath: filmEntity.posterPath,
      releaseDate: filmEntity.releaseDate,
      voteAverage: filmEntity.voteAverage,
      genreIds: genreIds,
    );
  }
}

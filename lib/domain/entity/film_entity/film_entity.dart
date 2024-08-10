import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb_ek/domain/entity/genre_entity/genre_entity.dart';

part 'film_entity.freezed.dart';

@freezed
class FilmEntity with _$FilmEntity {
  factory FilmEntity({
    required int id,
    required String title,
    required String overview,
    required String backdropPath,
    required String posterPath,
    required String releaseDate,
    required double voteAverage,
    required List<String> genres,
  }) = _FilmEntity;
}

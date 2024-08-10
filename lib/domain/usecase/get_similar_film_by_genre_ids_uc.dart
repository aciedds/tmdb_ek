import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/repository/film_repository.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

@injectable
class GetSimilarFilmByGenresUc {
  final FilmRepository _filmRepository;

  GetSimilarFilmByGenresUc(this._filmRepository);

  Future<DataState<List<FilmEntity>>> call({
    required List<String> genres,
    int page = 1,
  }) async {
    return await _filmRepository.getSimilarFilmsBySameGenreIds(genres: genres, page: page);
  }
}

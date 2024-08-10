import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/repository/film_repository.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

@injectable
class GetSimilarFilmUc {
  final FilmRepository _filmRepository;

  GetSimilarFilmUc(this._filmRepository);

  Future<DataState<List<FilmEntity>>> call({required int id, int page = 1}) async {
    return await _filmRepository.getSimilarFilms(id: id, page: page);
  }
}

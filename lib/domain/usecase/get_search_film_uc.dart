import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/repository/film_repository.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

@injectable
class GetSearchFilmUc {
  final FilmRepository _filmRepository;

  GetSearchFilmUc(this._filmRepository);

  Future<DataState<List<FilmEntity>>> call(String query) {
    return _filmRepository.searchFilms(query: query);
  }
}

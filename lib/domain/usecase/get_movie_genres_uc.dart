import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/domain/entity/genre_entity/genre_entity.dart';
import 'package:tmdb_ek/domain/repository/film_repository.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

@injectable
class GetMovieGenresUc {
  final FilmRepository _filmRepository;

  GetMovieGenresUc(this._filmRepository);

  Future<DataState<List<GenreEntity>>> call() async {
    return await _filmRepository.getMovieGenres();
  }
}

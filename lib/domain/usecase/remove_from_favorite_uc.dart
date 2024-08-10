import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/domain/repository/film_repository.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

@injectable
class RemoveFromFavoriteUc {
  final FilmRepository _filmRepository;

  RemoveFromFavoriteUc(this._filmRepository);

  DataState<bool> call(int id) => _filmRepository.removeFromFavorite(id);
}

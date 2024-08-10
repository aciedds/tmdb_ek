import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/domain/repository/film_repository.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

@injectable
class RemoveFromWatchlistUc {
  final FilmRepository _filmRepository;

  RemoveFromWatchlistUc(this._filmRepository);

  DataState<bool> call(int id) => _filmRepository.removeFromWatchlist(id);
}

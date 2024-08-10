import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/domain/repository/film_repository.dart';

@injectable
class GetHasExistInWatchlistUc {
  final FilmRepository _filmRepository;

  GetHasExistInWatchlistUc(this._filmRepository);

  bool call(int id) {
    final result = _filmRepository.isOnWatchlist(id);
    return result.when(
      success: (data) => data,
      error: (message, data, exception, stackTrace, statusCode) => false,
    );
  }
}

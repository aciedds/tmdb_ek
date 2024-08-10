import 'package:injectable/injectable.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/repository/film_repository.dart';
import 'package:tmdb_ek/state/data_state/data_state.dart';

@injectable
class GetFavoriteUc {
  final FilmRepository _filmRepository;

  GetFavoriteUc(this._filmRepository);

  Future<DataState<List<FilmEntity>>> call() async {
    return await _filmRepository.getListFavorite();
  }
}

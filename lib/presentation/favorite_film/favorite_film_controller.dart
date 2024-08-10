import 'package:get/get.dart';
import 'package:tmdb_ek/di/injection.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/usecase/get_favorite_uc.dart';
import 'package:tmdb_ek/state/view_state/view_state.dart';

class FavoriteFilmController extends GetxController {
  final GetFavoriteUc _favoriteUc = inject<GetFavoriteUc>();

  Rx<ViewState<List<FilmEntity>>> favoriteList =
      const ViewState<List<FilmEntity>>.initial().obs;

  @override
  void onInit() async {
    super.onInit();
    getFavorite();
  }

  void getFavorite() async {
    favoriteList.value = const ViewState.loading();
    final result = await _favoriteUc.call();
    result.when(
      success: (data) {
        favoriteList.value = ViewState.success(data: data);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        favoriteList.value = ViewState.error(message: message);
      },
    );
  }
}

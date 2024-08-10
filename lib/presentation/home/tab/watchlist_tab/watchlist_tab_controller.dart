import 'package:get/get.dart';
import 'package:tmdb_ek/di/injection.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/usecase/get_watchlist_uc.dart';
import 'package:tmdb_ek/state/view_state/view_state.dart';

class WatchlistTabController extends GetxController {
  final GetWatchlistUc _watchlistUc = inject<GetWatchlistUc>();

  Rx<ViewState<List<FilmEntity>>> watchlistList =
      const ViewState<List<FilmEntity>>.initial().obs;

  @override
  void onInit() async {
    super.onInit();
    getWatchlist();
  }

  void getWatchlist() async {
    watchlistList.value = const ViewState.loading();
    final result = await _watchlistUc.call();
    result.when(
      success: (data) {
        watchlistList.value = ViewState.success(data: data);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        watchlistList.value = ViewState.error(message: message);
      },
    );
  }
}

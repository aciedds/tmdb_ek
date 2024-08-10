import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/watchlist_film/watchlist_film_controller.dart';

class WatchlistFilmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchlistFilmController>(() => WatchlistFilmController());
  }
}

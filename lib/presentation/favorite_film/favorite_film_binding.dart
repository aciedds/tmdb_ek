import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/favorite_film/favorite_film_controller.dart';

class FavoriteFilmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteFilmController>(() => FavoriteFilmController());
  }
}

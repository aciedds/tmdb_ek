import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/search_film/search_film_controller.dart';

class SearchFilmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchFilmController>(() => SearchFilmController());
  }
}
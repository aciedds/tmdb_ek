import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/film_detail/film_detail_controller.dart';

class FilmDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilmDetailController());
  }
}

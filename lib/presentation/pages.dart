import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/film_detail/film_detail_binding.dart';
import 'package:tmdb_ek/presentation/film_detail/film_detail_view.dart';
import 'package:tmdb_ek/presentation/home/home_binding.dart';
import 'package:tmdb_ek/presentation/home/home_view.dart';
import 'package:tmdb_ek/presentation/routes.dart';
import 'package:tmdb_ek/presentation/search_film/search_film_binding.dart';
import 'package:tmdb_ek/presentation/search_film/search_film_view.dart';

class Pages {
  Pages._();

  static const initial = Routes.HOME;
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      transition: Transition.rightToLeftWithFade,
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.FILM_DETAIL,
      page: () => const FilmDetailView(),
      transition: Transition.rightToLeftWithFade,
      binding: FilmDetailBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_FILM,
      page: () => const SearchFilmView(),
      transition: Transition.rightToLeftWithFade,
      binding: SearchFilmBinding(),
    ),
  ];
}

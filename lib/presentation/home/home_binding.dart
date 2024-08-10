import 'package:tmdb_ek/presentation/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/home/tab/favorite_tab/favorite_tab_controller.dart';
import 'package:tmdb_ek/presentation/home/tab/home_tab/home_tab_controller.dart';
import 'package:tmdb_ek/presentation/home/tab/watchlist_tab/watchlist_tab_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => HomeTabController());
    Get.lazyPut(() => FavoriteTabController());
    Get.lazyPut(() => WatchlistTabController());
  }
}

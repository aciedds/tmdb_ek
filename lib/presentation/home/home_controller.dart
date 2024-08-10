import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_ek/di/injection.dart';
import 'package:tmdb_ek/domain/usecase/get_movie_genres_uc.dart';
import 'package:tmdb_ek/presentation/home/tab/favorite_tab/favorite_tab_controller.dart';
import 'package:tmdb_ek/presentation/home/tab/home_tab/home_tab_controller.dart';
import 'package:tmdb_ek/presentation/home/tab/watchlist_tab/watchlist_tab_controller.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GetMovieGenresUc _genresUc = inject<GetMovieGenresUc>();
  // final homeController = Get.find<HomeTabController>();
  // final favoriteController = Get.find<FavoriteTabController>();
  // final watchlistController = Get.find<WatchlistTabController>();
  late TabController tabController;

  RxBool isFiltered = false.obs;
  RxInt tabIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    await _genresUc.call();
    tabController.addListener(
      () {
        // tabIndex.value = tabController.index;
        // if (tabController.index == 0) {
        //   log("Home");
        //   homeController.getNowPlaying();
        //   homeController.getPopular();
        // } else if (tabController.index == 1) {
        //   log("Favorite");
        //   favoriteController.getFavorite();
        // } else if (tabController.index == 2) {
        //   log("Watchlist");
        //   watchlistController.getWatchlist();
        // }
      },
    );
  }
}

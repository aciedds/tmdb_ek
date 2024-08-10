import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tmdb_ek/di/injection.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/usecase/get_now_playing_uc.dart';
import 'package:tmdb_ek/domain/usecase/get_popular_film_uc.dart';
import 'package:tmdb_ek/state/view_state/view_state.dart';

class HomeTabController extends GetxController {
  final GetPopularFilmUc _getPopularFilmUc = inject<GetPopularFilmUc>();
  final GetNowPlayingUc _getNowPlayingUc = inject<GetNowPlayingUc>();

  late RefreshController refreshController;
  late TextEditingController filterTEC;
  late FocusNode filterFN;

  RxBool isFiltered = false.obs;

  Rx<ViewState<List<FilmEntity>>> nowPlayingList =
      const ViewState<List<FilmEntity>>.initial().obs;

  Rx<ViewState<List<FilmEntity>>> popularList =
      const ViewState<List<FilmEntity>>.initial().obs;

  int page = 1;

  @override
  void onInit() async {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    initializeFilterTextField();
    getNowPlaying();
    getPopular();
  }

  void initializeFilterTextField() {
    filterTEC = TextEditingController();
    filterFN = FocusNode();
  }

  void getNowPlaying() async {
    nowPlayingList.value = const ViewState.loading();
    final result = await _getNowPlayingUc.call(page: page);
    result.when(
      success: (data) {
        nowPlayingList.value = ViewState.success(data: data);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        nowPlayingList.value = ViewState.error(message: message);
      },
    );
  }

  void getPopular() async {
    popularList.value = const ViewState.loading();
    final result = await _getPopularFilmUc.call(page: page);
    result.when(
      success: (data) {
        popularList.value = ViewState.success(data: data);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        popularList.value = ViewState.error(message: message);
      },
    );
  }

  void onRefresh() {
    page = 1;
    getNowPlaying();
    getPopular();
    refreshController.refreshCompleted();
  }

  void onLoading() {
    page++;
    getPopular();
    refreshController.loadComplete();
  }
}

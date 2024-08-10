import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tmdb_ek/di/injection.dart';
import 'package:tmdb_ek/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_ek/domain/usecase/add_favorite_uc.dart';
import 'package:tmdb_ek/domain/usecase/add_watchlist_uc.dart';
import 'package:tmdb_ek/domain/usecase/get_has_exist_in_favorite_uc.dart';
import 'package:tmdb_ek/domain/usecase/get_has_exist_in_watchlist_uc.dart';
import 'package:tmdb_ek/domain/usecase/get_similar_film_by_genre_ids_uc.dart';
import 'package:tmdb_ek/domain/usecase/remove_from_favorite_uc.dart';
import 'package:tmdb_ek/domain/usecase/remove_from_watchlist_uc.dart';
import 'package:tmdb_ek/state/view_state/view_state.dart';

class FilmDetailController extends GetxController {
  final GetSimilarFilmByGenresUc _similarUc =
      inject<GetSimilarFilmByGenresUc>();
  final GetHasExistInFavoriteUc _isOnFavorite =
      inject<GetHasExistInFavoriteUc>();
  final GetHasExistInWatchlistUc _isOnWatchlist =
      inject<GetHasExistInWatchlistUc>();
  final AddFavoriteUc _addFavoriteUc = inject<AddFavoriteUc>();
  final AddWatchlistUc _addWatchlistUc = inject<AddWatchlistUc>();
  final RemoveFromWatchlistUc _removeFromWatchlistUc =
      inject<RemoveFromWatchlistUc>();
  final RemoveFromFavoriteUc _removeFromFavoriteUc =
      inject<RemoveFromFavoriteUc>();

  late RefreshController refreshController;
  late TextEditingController filterTEC;
  late FocusNode filterFN;

  RxBool isFiltered = false.obs;

  Rx<ViewState<List<FilmEntity>>> similarList =
      const ViewState<List<FilmEntity>>.initial().obs;

  RxBool isLoading = false.obs;

  late FilmEntity film;

  RxBool isOnFavorite = false.obs;

  RxBool isOnWatchlist = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    final args = Get.arguments as FilmEntity?;
    if (args != null) {
      film = args;
    }
    isLoading.value = false;
    refreshController = RefreshController(initialRefresh: false);
    isOnFavorite.value = _isOnFavorite.call(film.id);
    isOnWatchlist.value = _isOnWatchlist.call(film.id);
    initializeFilterTextField();
    getSimilarWithGenres();
  }

  void initializeFilterTextField() {
    filterTEC = TextEditingController();
    filterFN = FocusNode();
  }

  void getSimilarWithGenres() async {
    similarList.value = const ViewState.loading();
    final result = await _similarUc.call(genres: film.genres);
    result.when(
      success: (data) {
        similarList.value = ViewState.success(data: data);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        similarList.value = ViewState.error(message: message);
      },
    );
  }

  void addRemoveFromFavorite() async {
    if (!isOnFavorite.value) {
      await _addFavoriteUc.call(data: film);
    } else {
      _removeFromFavoriteUc.call(film.id);
    }
    isOnFavorite.value = _isOnFavorite.call(film.id);
  }

  void addToWatchlist() async {
    if (!isOnWatchlist.value) {
      await _addWatchlistUc.call(data: film);
    } else {
      _removeFromWatchlistUc.call(film.id);
    }
    isOnWatchlist.value = _isOnWatchlist.call(film.id);
  }
}

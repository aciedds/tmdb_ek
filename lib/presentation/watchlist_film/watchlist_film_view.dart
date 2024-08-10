import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/routes.dart';
import 'package:tmdb_ek/presentation/watchlist_film/watchlist_film_controller.dart';
import 'package:tmdb_ek/presentation/widget/film_card_vertical.dart';
import 'package:tmdb_ek/presentation/widget/film_card_vertical_loadiing.dart';

class WatchlistFilmView extends GetView<WatchlistFilmController> {
  const WatchlistFilmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Watchlist",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.offNamed(Routes.HOME),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Obx(() {
        return controller.watchlistList.value.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          error: (message) => const Text("Something went wrong"),
          loading: () => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) {
              return const FilmCardVerticalLoadiing();
            },
          ),
          success: (data) => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Get.offNamed(
                  Routes.FILM_DETAIL,
                  arguments: data[index],
                ),
                child: FilmCardVertical(film: data[index]),
              );
            },
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/favorite_film/favorite_film_controller.dart';
import 'package:tmdb_ek/presentation/routes.dart';
import 'package:tmdb_ek/presentation/widget/film_card_vertical.dart';
import 'package:tmdb_ek/presentation/widget/film_card_vertical_loadiing.dart';

class FavoriteFilmView extends GetView<FavoriteFilmController> {
  const FavoriteFilmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite",
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
        return controller.favoriteList.value.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          error: (message) => Center(child: Text(message)),
          loading: () => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) {
              return const FilmCardVerticalLoadiing();
            },
          ),
          success: (data) => data.isEmpty
              ? const Center(child: Text("No data"))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.toNamed(
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

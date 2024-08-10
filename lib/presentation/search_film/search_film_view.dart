import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/routes.dart';
import 'package:tmdb_ek/presentation/search_film/search_film_controller.dart';
import 'package:tmdb_ek/presentation/widget/film_card_vertical.dart';
import 'package:tmdb_ek/presentation/widget/film_card_vertical_loadiing.dart';

class SearchFilmView extends GetView<SearchFilmController> {
  const SearchFilmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Result",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Obx(() {
        return controller.searchList.value.maybeWhen(
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

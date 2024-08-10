import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb_ek/presentation/film_detail/film_detail_controller.dart';
import 'package:tmdb_ek/presentation/routes.dart';
import 'package:tmdb_ek/presentation/widget/film_card_horizontal.dart';
import 'package:tmdb_ek/presentation/widget/film_card_horizontal_loading.dart';

class FilmDetailView extends GetView<FilmDetailController> {
  const FilmDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offNamed(Routes.HOME),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const CircularProgressIndicator();
            }
            return Image.memory(
              base64Decode(controller.film.posterPath),
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            );
          }),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: DraggableScrollableSheet(
              minChildSize: 0.5,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 5,
                              width: 80,
                              margin:
                                  const EdgeInsetsDirectional.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Obx(() {
                            if (controller.isLoading.value) {
                              return shimmerLoading();
                            }
                            return Text(
                              controller.film.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            );
                          }),
                          const SizedBox(height: 8),
                          // Rating(voteAverage: film.voteAverage),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: controller.addRemoveFromFavorite,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                              icon: Obx(() {
                                return Icon(
                                  controller.isOnFavorite.value
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.white,
                                );
                              }),
                              label: Obx(() {
                                return Text(
                                  '${controller.isOnFavorite.value ? 'Remove From' : 'Add To'}  Favorite',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: controller.addToWatchlist,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                              icon: Obx(() {
                                return Icon(
                                  controller.isOnWatchlist.value
                                      ? Icons.check
                                      : Icons.add,
                                  color: Colors.white,
                                );
                              }),
                              label: Obx(() {
                                return Text(
                                  '${controller.isOnWatchlist.value ? 'Remove From' : 'Add To'} Watchlist',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Overview',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            if (controller.isLoading.value) {
                              return shimmerLoading();
                            }
                            return Text(controller.film.overview);
                          }),
                          const SizedBox(height: 8),
                          Obx(() {
                            return controller.similarList.value.maybeWhen(
                              orElse: () => const SizedBox.shrink(),
                              error: (message) =>
                                  const Text("Something went wrong"),
                              loading: () => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 6,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return const FilmCardHorizontalLoading();
                                  },
                                ),
                              ),
                              success: (data) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 6,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return FilmCardHorizontal(
                                        film: data[index]);
                                  },
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white12,
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

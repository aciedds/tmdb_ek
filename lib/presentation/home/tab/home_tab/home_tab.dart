import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tmdb_ek/presentation/home/tab/home_tab/home_tab_controller.dart';
import 'package:tmdb_ek/presentation/routes.dart';
import 'package:tmdb_ek/presentation/widget/film_card_horizontal.dart';
import 'package:tmdb_ek/presentation/widget/film_card_horizontal_loading.dart';

class HomeTab extends GetView<HomeTabController> {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => search(context),
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        enablePullUp: true,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Now Playing",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Obx(() {
              return controller.nowPlayingList.value.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                error: (message) => const Text("Something went wrong"),
                loading: () => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
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
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: FilmCardHorizontal(film: data[index]),
                        onTap: () => Get.offNamed(
                          Routes.FILM_DETAIL,
                          arguments: data[index],
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Popular",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Obx(() {
              return controller.popularList.value.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                error: (message) => const Text("Something went wrong"),
                loading: () => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: .65,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemCount: 6,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const FilmCardHorizontalLoading();
                  },
                ),
                success: (data) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: .65,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemCount: data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.offNamed(
                        Routes.FILM_DETAIL,
                        arguments: data[index],
                      ),
                      child: FilmCardHorizontal(film: data[index]),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void search(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 40,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.filterTEC,
                    focusNode: controller.filterFN,
                    decoration: const InputDecoration(hintText: "Search"),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (controller.filterTEC.text.isEmpty) {
                      Get.back();
                    } else {
                      Get.offNamed(
                        Routes.SEARCH_FILM,
                        arguments: controller.filterTEC.text,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

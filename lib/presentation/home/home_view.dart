import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/home/home_controller.dart';
import 'package:tmdb_ek/presentation/home/tab/home_tab/home_tab.dart';
import 'package:tmdb_ek/presentation/home/tab/profile_tab/profile_tab.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          HomeTab(),
          ProfileTab(),
          // FavoriteTab(),
          // WatchlistTab(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: controller.tabController,
        tabs: const [
          Tab(
            icon: Icon(Icons.home_outlined),
          ),
          Tab(
            icon: Icon(Icons.person_outline),
          )
          // Tab(
          //   icon: Icon(Icons.favorite_border),
          // ),
          // Tab(
          //   icon: Icon(Icons.bookmark_border_outlined),
          // ),
        ],
      ),
    );
  }
}

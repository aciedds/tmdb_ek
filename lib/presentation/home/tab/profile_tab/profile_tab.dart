import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_ek/presentation/routes.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: ListView(
        children: [
          CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.person_outline,
              size: 50,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Guest",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          ListTile(
            leading: Icon(
              Icons.favorite_border,
              color: Theme.of(context).primaryColor,
            ),

            title: Text(
              "Favorite",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () => Get.offNamed(Routes.FAVORITE_FILM),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.bookmark_border_outlined,
                color: Theme.of(context).primaryColor),
            title: Text(
              "Watchlist",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () => Get.offNamed(Routes.WATCHLIST_FILM),
          ),
        ],
      ),
    );
  }
}

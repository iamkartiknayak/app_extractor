import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_tile.dart';
import '../../application/applist_provider.dart';

class FavoriteAppsPage extends StatelessWidget {
  const FavoriteAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteAppsList = context.watch<ApplistProvider>().favoriteAppsList;

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Apps (${favoriteAppsList.length})')),
      body: ListView.builder(
        itemCount: favoriteAppsList.length,
        itemBuilder: (context, index) {
          final app = favoriteAppsList[index];
          return AppTile(app: app);
        },
      ),
    );
  }
}

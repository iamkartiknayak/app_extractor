import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_tile.dart';
import '../../application/applist_provider.dart';

class InstalledAppsPage extends StatelessWidget {
  const InstalledAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final installedAppsList =
        context.watch<ApplistProvider>().installedAppsList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Installed Apps (${installedAppsList.length})'),
      ),
      body: ListView.builder(
        itemCount: installedAppsList.length,
        itemBuilder: (context, index) {
          final app = installedAppsList[index];
          return AppTile(app: app);
        },
      ),
    );
  }
}

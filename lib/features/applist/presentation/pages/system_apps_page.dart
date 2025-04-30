import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/list_app_tile.dart';
import '../../application/applist_provider.dart';

class SystemAppsPage extends StatelessWidget {
  const SystemAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final systemAppsList = context.watch<ApplistProvider>().systemAppsList;

    return Scaffold(
      appBar: AppBar(title: Text('System Apps (${systemAppsList.length})')),
      body: ListView.builder(
        itemCount: systemAppsList.length,
        itemBuilder: (context, index) {
          final app = systemAppsList[index];
          return ListAppTile(app: app);
        },
      ),
    );
  }
}

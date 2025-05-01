import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../home/application/home_provider.dart';
import '../widgets/build_shimmer_list.dart';
import '../widgets/list_app_tile.dart';
import '../../application/applist_provider.dart';

class AppListPage extends StatelessWidget {
  const AppListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavbarIndexProvider>().currentIndex;
    final result = context.watch<ApplistProvider>().getData(
      context,
      currentIndex,
    );
    final appList = result.appList;

    return Scaffold(
      appBar: AppBar(title: Text('${result.title} (${appList.length})')),
      body:
          result.fetchingData
              ? BuildShimmerList()
              : ListView.builder(
                itemCount: appList.length,
                itemBuilder: (context, index) {
                  final app = appList[index];
                  return ListAppTile(app: app);
                },
              ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../widgets/search_field.dart';
import '../../../home/application/home_provider.dart';
import '../widgets/build_shimmer_list.dart';
import '../widgets/list_app_tile.dart';
import '../../application/applist_provider.dart';

class AppListPage extends StatelessWidget {
  const AppListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavbarIndexProvider>().currentIndex;
    final appListProvider = context.watch<ApplistProvider>();
    final result = appListProvider.getData(context, currentIndex);

    Widget getTitle() {
      return result.searchEnabled
          ? SearchField(
            appListProvider: appListProvider,
            appList: result.appList,
          )
          : Text('${result.title} (${result.appList.length})');
    }

    return Scaffold(
      appBar: AppBar(
        title: getTitle(),
        actionsPadding: EdgeInsets.only(right: 24.0),
        actions: [
          IconButton(
            onPressed: () => appListProvider.toggleSearch(),
            icon: Icon(result.searchEnabled ? Symbols.close : Symbols.search),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (result.fetchingData) return const BuildShimmerList();

          if (result.searchEnabled &&
              result.searchResultList.isEmpty &&
              result.searchTerm.isNotEmpty) {
            return const Center(child: Text('No Results'));
          }

          final appList =
              result.searchResultList.isNotEmpty
                  ? result.searchResultList
                  : result.appList;

          return ListView.builder(
            itemCount: appList.length,
            itemBuilder: (context, index) {
              final app = appList[index];
              return ListAppTile(app: app);
            },
          );
        },
      ),
    );
  }
}

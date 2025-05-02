import 'package:device_apps/device_apps.dart';
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
    context.read<ApplistProvider>().setData(context, currentIndex);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 56.0),
        child: Selector<
          ApplistProvider,
          ({String title, bool searchEnabled, List<Application> appList})
        >(
          selector:
              (_, provider) => (
                title: provider.currentTitle,
                searchEnabled: provider.searchEnabled,
                appList: provider.currentAppList,
              ),
          builder: (_, data, __) {
            return AppBar(
              title:
                  data.searchEnabled
                      ? SearchField(appList: data.appList)
                      : Text('${data.title} (${data.appList.length})'),
              actionsPadding: const EdgeInsets.only(right: 24.0),
              actions: [
                IconButton(
                  onPressed:
                      () => context.read<ApplistProvider>().toggleSearch(),
                  icon: Icon(
                    data.searchEnabled ? Symbols.close : Symbols.search,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: Selector<
        ApplistProvider,
        ({
          bool noSearchData,
          bool fetchingData,
          List<Application> currentAppList,
        })
      >(
        selector:
            (_, provider) => (
              noSearchData: provider.noSearchData,
              fetchingData: provider.fetchingData,
              currentAppList: provider.currentAppList,
            ),
        builder: (_, data, __) {
          if (data.fetchingData) return BuildShimmerList();

          if (data.currentAppList.isEmpty && currentIndex == 2) {
            return Center(child: Text('No Favorites has been added'));
          }

          if (data.noSearchData) return Center(child: Text('No Results'));

          return ListView.builder(
            itemCount: data.currentAppList.length,
            itemBuilder: (context, index) {
              final app = data.currentAppList[index];
              return ListAppTile(app: app);
            },
          );
        },
      ),
    );
  }
}

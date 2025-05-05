import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../../../common/empty_data_widget.dart';
import '../../../home/application/home_provider.dart';
import '../../../settings/application/settings_provider.dart';
import '../../application/applist_provider.dart';
import '../widgets/app_list_page_header.dart';
import '../widgets/build_shimmer_card.dart';
import '../widgets/build_shimmer_list.dart';
import '../widgets/grid_app_card.dart';
import '../widgets/list_app_tile.dart';

class AppListPage extends StatelessWidget {
  const AppListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavbarIndexProvider>().currentIndex;
    final appListProvider = context.read<ApplistProvider>();
    appListProvider.setData(context, currentIndex);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 56.0),
        child: AppListPageHeader(),
      ),
      body: Selector<
        ApplistProvider,
        ({bool noSearchData, bool fetchingData, int currentAppListLength})
      >(
        selector:
            (_, provider) => (
              noSearchData: provider.noSearchData,
              fetchingData: provider.fetchingData,
              currentAppListLength: provider.currentAppList.length,
            ),
        builder: (_, data, __) {
          final gridView = context.read<SettingsProvider>().gridView;

          if (data.fetchingData) {
            return gridView
                ? const BuildShimmerCard()
                : const BuildShimmerList();
          }

          if (data.currentAppListLength == 0 && currentIndex == 2) {
            return const EmptyDataWidget(
              icon: Symbols.heart_broken,
              title: 'No Favorites has been added',
              subTitle: 'Start adding items you love to see them here',
            );
          }

          if (data.noSearchData) {
            return const EmptyDataWidget(
              icon: Symbols.search_off,
              title: 'No results found',
              subTitle: 'Try adjusting your search keywords',
            );
          }

          final currentAppList = appListProvider.currentAppList;

          return RefreshIndicator(
            onRefresh: () => appListProvider.refreshList(),
            child:
                gridView
                    ? LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = constraints.maxWidth;
                        final itemWidth = (screenWidth - ((2 - 1) * 16.0)) / 2;
                        final itemHeight = itemWidth * 1;

                        return GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          itemCount: data.currentAppListLength,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16.0,
                                crossAxisSpacing: 16.0,
                                childAspectRatio: itemWidth / itemHeight,
                              ),
                          itemBuilder: (context, index) {
                            final app = currentAppList[index];
                            return GridAppCard(app: app, index: index);
                          },
                        );
                      },
                    )
                    : ListView.builder(
                      itemCount: data.currentAppListLength,
                      itemBuilder: (context, index) {
                        final app = currentAppList[index];
                        return ListAppTile(app: app, index: index);
                      },
                    ),
          );
        },
      ),
    );
  }
}

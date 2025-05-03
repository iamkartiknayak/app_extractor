import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../widgets/grid_app_card.dart';
import '../../../home/application/home_provider.dart';
import '../widgets/build_shimmer_list.dart';
import '../widgets/list_app_tile.dart';
import '../widgets/app_list_page_header.dart';
import '../../application/applist_provider.dart';
import '../../../../common/empty_data_widget.dart';

class AppListPage extends StatelessWidget {
  const AppListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavbarIndexProvider>().currentIndex;
    context.read<ApplistProvider>().setData(context, currentIndex);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 56.0),
        child: AppListPageHeader(),
      ),
      body: Selector<
        ApplistProvider,
        ({
          bool noSearchData,
          bool fetchingData,
          bool gridView,
          List<Application> currentAppList,
        })
      >(
        selector:
            (_, provider) => (
              noSearchData: provider.noSearchData,
              fetchingData: provider.fetchingData,
              gridView: provider.gridView,
              currentAppList: provider.currentAppList,
            ),
        builder: (_, data, __) {
          if (data.fetchingData) return BuildShimmerList();

          if (data.currentAppList.isEmpty && currentIndex == 2) {
            return EmptyDataWidget(
              icon: Symbols.heart_broken,
              title: 'No Favorites has been added',
              subTitle: 'Start adding items you love to see them here',
            );
          }

          if (data.noSearchData) {
            return EmptyDataWidget(
              icon: Symbols.search_off,
              title: 'No results found',
              subTitle: 'Try adjusting your search keywords',
            );
          }

          return data.gridView
              ? LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final itemWidth = (screenWidth - ((2 - 1) * 16.0)) / 2;
                  final itemHeight = itemWidth * 1;

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    itemCount: data.currentAppList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: itemWidth / itemHeight,
                    ),
                    itemBuilder: (context, index) {
                      final app = data.currentAppList[index];
                      return GridAppCard(app: app, index: index);
                    },
                  );
                },
              )
              : ListView.builder(
                itemCount: data.currentAppList.length,
                itemBuilder: (context, index) {
                  final app = data.currentAppList[index];
                  return ListAppTile(app: app, index: index);
                },
              );
        },
      ),
    );
  }
}

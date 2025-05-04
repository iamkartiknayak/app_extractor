import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './default_header.dart';
import './selection_header.dart';
import '../../application/applist_provider.dart';

class AppListPageHeader extends StatelessWidget {
  const AppListPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<
      ApplistProvider,
      ({
        String title,
        bool searchEnabled,
        List<Application> currentAppList,
        int currentAppListLength,
        int selectedIndexListLength,
      })
    >(
      selector:
          (_, provider) => (
            title: provider.currentTitle,
            searchEnabled: provider.searchEnabled,
            currentAppList: provider.currentAppList,
            currentAppListLength: provider.currentAppList.length,
            selectedIndexListLength: provider.selectedItemIndexList.length,
          ),
      builder: (_, data, __) {
        return data.selectedIndexListLength != 0
            ? SelectionHeader(
              title: data.title,
              searchEnabled: data.searchEnabled,
              selectedIndexListLength: data.selectedIndexListLength,
            )
            : DefaultHeader(
              title: data.title,
              searchEnabled: data.searchEnabled,
              currentAppList: data.currentAppList,
              currentAppListLength: data.currentAppListLength,
            );
      },
    );
  }
}

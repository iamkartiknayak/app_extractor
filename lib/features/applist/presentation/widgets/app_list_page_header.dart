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
        List<Application> appList,
        int selectedIndexListLength,
      })
    >(
      selector:
          (_, provider) => (
            title: provider.currentTitle,
            searchEnabled: provider.searchEnabled,
            appList: provider.currentAppList,
            selectedIndexListLength: provider.selectedItemIndexList.length,
          ),
      builder: (_, data, __) {
        return data.selectedIndexListLength != 0
            ? SelectionHeader(data: data)
            : DefaultHeader(data: data);
      },
    );
  }
}

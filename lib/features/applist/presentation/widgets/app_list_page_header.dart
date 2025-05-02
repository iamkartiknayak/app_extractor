import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import './search_field.dart';
import '../../application/applist_provider.dart';

class AppListPageHeader extends StatelessWidget {
  const AppListPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<
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
              onPressed: () => context.read<ApplistProvider>().toggleSearch(),
              icon: Icon(data.searchEnabled ? Symbols.close : Symbols.search),
            ),
          ],
        );
      },
    );
  }
}

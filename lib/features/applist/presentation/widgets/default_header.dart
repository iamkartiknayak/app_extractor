import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../pages/extracted_apps_page.dart';
import '../../application/applist_provider.dart';
import 'search_field.dart';

class DefaultHeader extends StatelessWidget {
  const DefaultHeader({
    super.key,
    required this.title,
    required this.searchEnabled,
    required this.currentAppList,
    required this.currentAppListLength,
  });

  final String title;
  final bool searchEnabled;
  final List<Application> currentAppList;
  final int currentAppListLength;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          searchEnabled
              ? SearchField(appList: currentAppList)
              : Text('$title (${currentAppList.length})'),
      actionsPadding: const EdgeInsets.only(right: 24.0),
      actions: [
        IconButton(
          onPressed: () => context.read<ApplistProvider>().toggleSearch(),
          icon: Icon(searchEnabled ? Symbols.close : Symbols.search),
        ),
        if (!searchEnabled)
          IconButton(
            onPressed:
                () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => ExtractedAppsPage())),
            icon: Icon(searchEnabled ? Symbols.close : Symbols.inventory_2),
          ),
      ],
    );
  }
}

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../application/applist_provider.dart';
import 'search_field.dart';

class DefaultHeader extends StatelessWidget {
  const DefaultHeader({super.key, required this.data});

  final ({
    List<Application> appList,
    bool searchEnabled,
    int selectedIndexListLength,
    String title,
  })
  data;
  @override
  Widget build(BuildContext context) {
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
  }
}

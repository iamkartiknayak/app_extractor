import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../application/applist_provider.dart';

class SelectionHeader extends StatelessWidget {
  const SelectionHeader({super.key, required this.data});

  final ({
    List<Application> appList,
    bool searchEnabled,
    int selectedIndexListLength,
    String title,
  })
  data;

  @override
  Widget build(BuildContext context) {
    final appListProvider = context.read<ApplistProvider>();

    return Builder(
      builder: (_) {
        return AppBar(
          title: Text('${data.selectedIndexListLength} selected'),
          actions: [
            IconButton(
              onPressed: () => appListProvider.batchAppExtract(context),
              icon: Icon(
                data.searchEnabled ? Symbols.close : Symbols.unarchive,
              ),
            ),
            IconButton(
              onPressed: appListProvider.resetSelection,
              icon: Icon(data.searchEnabled ? Symbols.close : Symbols.cancel),
            ),
          ],
        );
      },
    );
  }
}

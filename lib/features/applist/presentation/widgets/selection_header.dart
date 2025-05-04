import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../application/applist_provider.dart';

class SelectionHeader extends StatelessWidget {
  const SelectionHeader({
    super.key,
    required this.title,
    required this.searchEnabled,
    required this.selectedIndexListLength,
  });

  final String title;
  final bool searchEnabled;
  final int selectedIndexListLength;

  @override
  Widget build(BuildContext context) {
    final appListProvider = context.read<ApplistProvider>();

    return Builder(
      builder: (_) {
        return AppBar(
          title: Text('$selectedIndexListLength selected'),
          actions: [
            IconButton(
              onPressed: () => appListProvider.batchAppExtract(context),
              icon: Icon(searchEnabled ? Symbols.close : Symbols.unarchive),
            ),
            IconButton(
              onPressed: appListProvider.resetSelection,
              icon: Icon(searchEnabled ? Symbols.close : Symbols.cancel),
            ),
          ],
        );
      },
    );
  }
}

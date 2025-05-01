import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../application/applist_provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.appListProvider,
    required this.appList,
  });

  final ApplistProvider appListProvider;
  final List<Application> appList;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      onChanged: (p0) => appListProvider.updateSearchResult(p0, appList),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search apps...',
        prefixIcon: Icon(Symbols.search),
        contentPadding: EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}

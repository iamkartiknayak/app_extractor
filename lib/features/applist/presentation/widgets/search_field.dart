import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../application/applist_provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.appList});

  final List<Application> appList;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      onChanged: context.read<ApplistProvider>().updateSearchResult,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search apps...',
        prefixIcon: Icon(Symbols.search),
        contentPadding: EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}

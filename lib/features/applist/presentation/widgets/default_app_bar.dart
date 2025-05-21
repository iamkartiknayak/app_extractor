import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../application/search_provider.dart';
import '../pages/extracted_app_list_page.dart';
import './search_field.dart';

class DefaultAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    required this.apps,
    this.showActions = true,
  });

  final String title;
  final List<Application> apps;
  final bool showActions;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final notifier = ref.read(searchProvider.notifier);
    final searchEnabled = ref.watch(
      searchProvider.select((final s) => s.isSearchEnabled),
    );

    return AppBar(
      title:
          searchEnabled
              ? SearchField(apps: apps, hintText: title)
              : Text('$title (${apps.length})'),
      actionsPadding: const EdgeInsets.only(right: 24.0),
      actions: [
        IconButton(
          onPressed: () => notifier.handleSearchToggle(searchEnabled),
          icon: Icon(searchEnabled ? Symbols.close : Symbols.search),
        ),
        if (!searchEnabled)
          IconButton(
            onPressed:
                () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const ExtractedAppListPage(),
                  ),
                ),
            icon: const Icon(Symbols.inventory_2),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}

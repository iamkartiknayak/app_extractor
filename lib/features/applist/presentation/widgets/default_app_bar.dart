import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../pages/extracted_app_list_page.dart';

class DefaultAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    required this.count,
    this.showActions = true,
  });

  final String title;
  final int count;
  final bool showActions;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) => AppBar(
    title: Text('$title ($count)'),
    actionsPadding: const EdgeInsets.only(right: 24.0),
    actions:
        showActions
            ? [
              IconButton(
                onPressed:
                    () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const ExtractedAppListPage(),
                      ),
                    ),
                icon: const Icon(Symbols.inventory_2),
              ),
            ]
            : null,
  );

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}

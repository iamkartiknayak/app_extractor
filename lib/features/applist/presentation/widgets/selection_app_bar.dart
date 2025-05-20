import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../application/long_press_provider.dart';

class SelectionAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SelectionAppBar({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final selectedIndexList = ref.watch(selectedItemsProvider);

    return AppBar(
      title: Text('${selectedIndexList.length} selected'),
      actionsPadding: const EdgeInsets.only(right: 24.0),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(onPressed: onPressed, icon: Icon(icon)),
        IconButton(
          onPressed: () => resetSelection(ref),
          icon: const Icon(Symbols.cancel),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);
}

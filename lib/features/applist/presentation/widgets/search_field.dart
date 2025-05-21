import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../application/search_provider.dart';

class SearchField extends ConsumerWidget {
  const SearchField({super.key, required this.apps, this.hintText});

  final String? hintText;
  final List<Application> apps;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final notifier = ref.read(searchProvider.notifier);

    return TextField(
      autofocus: true,
      onChanged: (final query) => notifier.updateSearch(query, apps),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText:
            hintText != null
                ? 'Search ${hintText!.toLowerCase()}...'
                : 'Search apps...',
        prefixIcon: const Icon(Symbols.search),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../features/applist/application/long_press_provider.dart';
import './selection_indicator.dart';

class LeadingWidget extends ConsumerWidget {
  const LeadingWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isSelected = ref.watch(selectedItemsProvider).contains(index);

    return isSelected
        ? const SelectionIndicator()
        : SizedBox(
          height: 40.0,
          width: 40.0,
          child: Icon(
            Symbols.android,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
  }
}

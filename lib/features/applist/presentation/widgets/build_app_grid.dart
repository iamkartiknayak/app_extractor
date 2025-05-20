import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/long_press_provider.dart';
import './app_grid_item.dart';

class BuildAppGrid extends ConsumerWidget {
  const BuildAppGrid({super.key, required this.apps});

  final List<Application> apps;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final longPress = ref.watch(longPressProvider);
    final selectedIndexes = ref.watch(selectedItemsProvider);

    return LayoutBuilder(
      builder: (final context, final constraints) {
        final screenWidth = constraints.maxWidth;
        final itemWidth = (screenWidth - ((2 - 1) * 16.0)) / 2;
        final itemHeight = itemWidth * 1;

        return GridView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: apps.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemBuilder: (final context, final index) {
            final app = apps[index];
            final isSelected = selectedIndexes.contains(index);

            return AppGridItem(
              app: app,
              index: index,
              isSelected: isSelected,
              longPress: longPress,
            );
          },
        );
      },
    );
  }
}

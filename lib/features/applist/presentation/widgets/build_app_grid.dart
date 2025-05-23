import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/helpers/app_interaction_helper.dart';
import '../../../home/application/home_provider.dart';
import './app_grid_item.dart';
import './shimmer_widget.dart';

class BuildAppGrid extends ConsumerWidget {
  const BuildAppGrid({super.key, required this.apps});

  final List<Application> apps;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isLoading = apps.isEmpty;

    return LayoutBuilder(
      builder: (final context, final constraints) {
        final screenWidth = constraints.maxWidth;
        final itemWidth = (screenWidth - ((2 - 1) * 16.0)) / 2;
        final itemHeight = itemWidth * 1;

        return GridView.builder(
          controller: ref.read(scrollControllerProvider),
          padding: const EdgeInsets.all(12.0),
          itemCount: isLoading ? 10 : apps.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemBuilder: (_, final index) {
            if (isLoading) {
              return ShimmerCard(itemWidth: itemWidth);
            }

            final app = apps[index];
            final tap = AppInteractionHelper.getTapHandlers(
              context: context,
              ref: ref,
              index: index,
              app: app,
            );

            return AppGridItem(app: app, index: index, tap: tap);
          },
        );
      },
    );
  }
}

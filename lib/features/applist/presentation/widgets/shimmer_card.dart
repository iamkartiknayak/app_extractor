import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/shimmer_container.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key, required this.itemWidth});

  final double itemWidth;

  @override
  Widget build(BuildContext context) => Card(
    elevation: 1,
    surfaceTintColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12.0),
            const ShimmerContainer(height: 56.0, width: 56.0),
            const SizedBox(height: 20.0),
            ShimmerContainer(height: 16.0, width: itemWidth / 2.5),
            const SizedBox(height: 4.0),
            ShimmerContainer(height: 10.0, width: itemWidth / 1.4),
            const SizedBox(height: 20.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerContainer(height: 20.0, width: 20.0),
                SizedBox(width: 28.0),
                ShimmerContainer(height: 20.0, width: 20.0),
                SizedBox(width: 28.0),
                ShimmerContainer(height: 20.0, width: 20.0),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

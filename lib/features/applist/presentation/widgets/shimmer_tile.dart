import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/shimmer_container.dart';

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Shimmer.fromColors(
      baseColor:
          isLight
              ? Colors.grey.shade200
              : Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.primary,
      child: const ListTile(
        leading: ShimmerContainer(height: 40.0, width: 40.0),
        title: ShimmerContainer(height: 16.0, width: 160.0),
        subtitle: ShimmerContainer(height: 12.0, width: 200.0),
        trailing: Padding(
          padding: EdgeInsets.only(right: 14.0),
          child: ShimmerContainer(height: 20.0, width: 20.0),
        ),
      ),
    );
  }
}

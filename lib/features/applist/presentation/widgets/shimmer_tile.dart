import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import './shimmer_container.dart';

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: Theme.of(context).colorScheme.primary,
      child: Row(
        children: [
          ShimmerContainer(height: 40.0, width: 40.0),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(height: 16.0, width: 160.0),
                SizedBox(height: 8.0),
                ShimmerContainer(height: 12.0, width: 200.0),
              ],
            ),
          ),
          ShimmerContainer(height: 24.0, width: 24.0),
          SizedBox(width: 20.0),
        ],
      ),
    );
  }
}

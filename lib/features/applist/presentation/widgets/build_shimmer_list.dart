import 'package:flutter/material.dart';

import './shimmer_tile.dart';

class BuildShimmerList extends StatelessWidget {
  const BuildShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, _) => ShimmerTile(),
      itemCount: 12,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      separatorBuilder:
          (BuildContext context, int index) => SizedBox(height: 28.0),
    );
  }
}

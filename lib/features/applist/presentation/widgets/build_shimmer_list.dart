import 'package:flutter/material.dart';

import './shimmer_tile.dart';

class BuildShimmerList extends StatelessWidget {
  const BuildShimmerList({super.key});

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: 12,
    itemBuilder: (_, _) => const ShimmerTile(),
  );
}

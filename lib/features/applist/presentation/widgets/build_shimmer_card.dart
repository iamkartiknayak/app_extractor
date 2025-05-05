import 'package:flutter/material.dart';

import './shimmer_card.dart';

class BuildShimmerCard extends StatelessWidget {
  const BuildShimmerCard({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final itemWidth = (screenWidth - ((2 - 1) * 16.0)) / 2;
      final itemHeight = itemWidth * 1;

      return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: itemWidth / itemHeight,
        ),
        itemBuilder: (context, index) => ShimmerCard(itemWidth: itemWidth),
      );
    },
  );
}

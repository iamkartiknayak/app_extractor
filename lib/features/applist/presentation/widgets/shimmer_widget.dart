import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({super.key});

  @override
  Widget build(final BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surfaceTint.withValues(alpha: 0.04),
      child: Shimmer.fromColors(
        baseColor:
            isLight
                ? Colors.grey.shade200
                : Theme.of(context).colorScheme.surface,
        highlightColor: Theme.of(context).colorScheme.primary,
        child: const ListTile(
          contentPadding: EdgeInsets.only(left: 16.0, right: 12.0),
          leading: _ShimmerContainer(height: 40.0, width: 40.0),
          title: _ShimmerContainer(height: 16.0, width: 160.0),
          subtitle: _ShimmerContainer(height: 12.0, width: 200.0),
          trailing: Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: _ShimmerContainer(height: 20.0, width: 20.0),
          ),
        ),
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key, required this.itemWidth});

  final double itemWidth;

  @override
  Widget build(final BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surfaceTint.withValues(alpha: 0.04),
      child: Shimmer.fromColors(
        baseColor:
            isLight
                ? Colors.grey.shade200
                : Theme.of(context).colorScheme.surface,
        highlightColor: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _ShimmerContainer(height: 50.0, width: 50.0),
              const SizedBox(height: 20.0),
              _ShimmerContainer(height: 16.0, width: itemWidth / 2.5),
              const SizedBox(height: 8.0),
              _ShimmerContainer(height: 10.0, width: itemWidth / 1.4),
              const SizedBox(height: 20.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ShimmerContainer(height: 20.0, width: 20.0),
                  _ShimmerContainer(height: 20.0, width: 20.0),
                  _ShimmerContainer(height: 20.0, width: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerContainer extends StatelessWidget {
  const _ShimmerContainer({required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(final BuildContext context) => Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(height / 5),
    ),
  );
}

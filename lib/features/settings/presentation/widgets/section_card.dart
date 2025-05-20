import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    color: Theme.of(context).colorScheme.surfaceTint.withValues(alpha: 0.04),
    child: Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: child,
    ),
  );
}

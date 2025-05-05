import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
    elevation: 1,
    surfaceTintColor: Theme.of(context).colorScheme.onSurface,
    child: Padding(padding: const EdgeInsets.all(16.0), child: child),
  );
}

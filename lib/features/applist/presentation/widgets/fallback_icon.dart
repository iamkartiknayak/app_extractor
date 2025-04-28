import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class FallbackIcon extends StatelessWidget {
  const FallbackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).colorScheme.onInverseSurface,
      ),
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Symbols.android,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

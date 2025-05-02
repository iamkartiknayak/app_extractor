import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../constants.dart';

class SelectionIndicator extends StatelessWidget {
  const SelectionIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        color: colorScheme.primary,
      ),
      child: Icon(Symbols.check, color: colorScheme.surface),
    );
  }
}

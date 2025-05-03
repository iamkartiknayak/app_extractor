import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../constants.dart';

class SelectionIndicator extends StatelessWidget {
  const SelectionIndicator({super.key, this.height = 40.0, this.width = 40.0});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        color: colorScheme.primary,
      ),
      child: Icon(Symbols.check, color: colorScheme.surface),
    );
  }
}

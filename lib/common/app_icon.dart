import 'package:app_extractor/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../features/applist/application/applist_provider.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.packageName,
    this.height,
    this.width,
  });

  final String packageName;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Selector<ApplistProvider, bool>(
      selector: (_, provider) => provider.imageCache.containsKey(packageName),
      builder: (_, iconExists, _) {
        if (iconExists) {
          final icon = context.read<ApplistProvider>().imageCache[packageName]!;
          return Image.memory(
            icon,
            height: height ?? 40.0,
            width: width ?? 40.0,
          );
        }

        return Container(
          height: height ?? 40.0,
          width: width ?? 40.0,
          decoration: BoxDecoration(
            borderRadius: kBorderRadius,
            color: colorScheme.primary,
          ),
          child: Icon(Symbols.android, color: colorScheme.surface),
        );
      },
    );
  }
}

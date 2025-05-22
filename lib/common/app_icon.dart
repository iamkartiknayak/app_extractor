import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../core/constants/theme_constants.dart';
import '../features/applist/application/icon_provider.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key, this.packageName, this.rawIcon, this.size = 40.0})
    : assert(
        packageName != null || rawIcon != null,
        'Either packageName or rawIcon must be provided.',
      );

  final String? packageName;
  final Uint8List? rawIcon;
  final double? size;

  @override
  Widget build(final BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    height: size,
    width: size,
    decoration: BoxDecoration(borderRadius: kBorderRadius),
    child:
        rawIcon != null
            ? Image.memory(rawIcon!, fit: BoxFit.cover)
            : Consumer(
              builder: (_, final ref, _) {
                final icon = ref.watch(iconProvider(packageName!));
                return icon != null
                    ? Image.memory(
                      icon,
                      height: size,
                      width: size,
                      fit: BoxFit.cover,
                    )
                    : const _AppIconPlaceholder();
              },
            ),
  );
}

class _AppIconPlaceholder extends StatelessWidget {
  const _AppIconPlaceholder();

  @override
  Widget build(final BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: colorScheme.primary,
      ),
      child: Icon(Symbols.android, color: colorScheme.surface),
    );
  }
}

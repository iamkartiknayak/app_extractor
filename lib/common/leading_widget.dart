import 'dart:typed_data';

import 'package:flutter/material.dart';

import './app_icon.dart';
import './selection_indicator.dart';

class LeadingWidget extends StatelessWidget {
  const LeadingWidget({
    super.key,
    required this.index,
    required this.selected,
    this.packageName,
    this.rawIcon,
    this.size = 40.0,
  }) : assert(
         packageName != null || rawIcon != null,
         'Either packageName or rawIcon must be provided.',
       );

  final int index;
  final bool selected;
  final String? packageName;
  final Uint8List? rawIcon;
  final double size;

  @override
  Widget build(final BuildContext context) =>
      selected
          ? const SelectionIndicator()
          : AppIcon(packageName: packageName, rawIcon: rawIcon, size: size);
}

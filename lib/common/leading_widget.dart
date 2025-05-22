import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/applist/application/long_press_provider.dart';
import './app_icon.dart';
import './selection_indicator.dart';

class LeadingWidget extends ConsumerWidget {
  const LeadingWidget({
    super.key,
    required this.index,
    this.packageName,
    this.rawIcon,
  }) : assert(
         packageName != null || rawIcon != null,
         'Either packageName or rawIcon must be provided.',
       );

  final int index;
  final String? packageName;
  final Uint8List? rawIcon;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isSelected = ref.watch(selectedItemsProvider).contains(index);

    return isSelected
        ? const SelectionIndicator()
        : AppIcon(packageName: packageName, rawIcon: rawIcon);
  }
}

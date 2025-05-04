import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './app_icon.dart';
import './selection_indicator.dart';
import '../features/applist/application/applist_provider.dart';

class AppTile extends StatelessWidget {
  const AppTile({
    super.key,
    this.onTap,
    required this.title,
    required this.subTitle,
    required this.trailing,
    required this.packageName,
    required this.index,
  });

  final VoidCallback? onTap;
  final String title;
  final String subTitle;
  final Widget trailing;
  final String packageName;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appListProvider = context.read<ApplistProvider>();
    final longPress = context.select<ApplistProvider, bool>((p) => p.longPress);

    debugPrint('build called...');

    return Selector<ApplistProvider, bool>(
      selector: (_, p1) => p1.selectedItemIndexList.contains(index),
      builder: (_, isSelected, _) {
        return ListTile(
          onTap:
              longPress
                  ? () => appListProvider.updateSelectedItemIndexList(index)
                  : onTap,
          onLongPress: () => appListProvider.updateSelectedItemIndexList(index),
          leading:
              isSelected
                  ? SelectionIndicator()
                  : AppIcon(packageName: packageName),
          title: Text(title),
          subtitle: Text(subTitle),
          trailing: longPress ? null : trailing,
        );
      },
    );
  }
}

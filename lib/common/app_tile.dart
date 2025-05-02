import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './selection_indicator.dart';
import '../features/applist/application/applist_provider.dart';

class AppTile extends StatelessWidget {
  const AppTile({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.trailingIcon,
    required this.trailingAction,
    required this.index,
  });

  final VoidCallback? onTap;
  final dynamic icon;
  final String title;
  final String subTitle;
  final IconData trailingIcon;
  final VoidCallback trailingAction;
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
                  : Image.memory(icon, width: 40, height: 40),
          title: Text(title),
          subtitle: Text(subTitle),
          trailing:
              longPress
                  ? null
                  : IconButton(
                    onPressed: trailingAction,
                    icon: Icon(trailingIcon),
                    color: Theme.of(context).colorScheme.primary,
                  ),
        );
      },
    );
  }
}

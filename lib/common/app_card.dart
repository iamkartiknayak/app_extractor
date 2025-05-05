import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../features/applist/application/applist_provider.dart';
import './app_icon.dart';
import './selection_indicator.dart';
import 'extract_share_toggle_button.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.app,
    required this.index,
    this.onTap,
    required this.title,
    required this.subTitle,
  });

  final Application app;

  final VoidCallback? onTap;
  final String title;
  final String subTitle;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appListProvider = context.read<ApplistProvider>();
    final longPress = context.select<ApplistProvider, bool>((p) => p.longPress);

    return Selector<ApplistProvider, bool>(
      builder:
          (_, isSelected, _) => InkWell(
            customBorder: RoundedRectangleBorder(borderRadius: kBorderRadius),
            onTap:
                longPress
                    ? () => appListProvider.updateSelectedItemIndexList(index)
                    : onTap,
            onLongPress:
                () => appListProvider.updateSelectedItemIndexList(index),
            child: Card(
              elevation: 1,
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8.0),
                    isSelected
                        ? const SelectionIndicator(height: 56.0, width: 56.0)
                        : AppIcon(
                          packageName: app.packageName,
                          height: 56.0,
                          width: 56.0,
                        ),
                    const SizedBox(height: 20.0),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                      maxLines: longPress ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subTitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: longPress ? 2 : 1,
                    ),
                    const SizedBox(height: 4.0),
                    AnimatedContainer(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 140),
                      height: longPress ? 0.0 : 30.0,
                      width: longPress ? 0.0 : double.maxFinite,
                      child: AnimatedOpacity(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 50),
                        opacity: longPress ? 0.0 : 1.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed:
                                  () => DeviceApps.openApp(app.packageName),
                              icon: Icon(
                                Symbols.launch,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  () => DeviceApps.openAppSettings(
                                    app.packageName,
                                  ),
                              icon: Icon(
                                Symbols.info,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            ExtractShareToggleButton(app: app),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

      selector: (_, p1) => p1.selectedItemIndexList.contains(index),
    );
  }
}

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../../../common/app_icon.dart';
import '../../../../constants.dart';
import '../../../applist/application/applist_provider.dart';

class InfoPageHeader extends StatelessWidget {
  const InfoPageHeader({super.key, required this.app});

  final Application app;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(borderRadius: kBorderRadius),
            child: AppIcon(packageName: app.packageName),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.appName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(app.packageName, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          SizedBox(width: 12.0),
          Selector<ApplistProvider, bool>(
            selector: (_, p1) => p1.isFavorite(app.packageName),
            shouldRebuild: (previous, next) => previous != next,
            builder: (_, isFavorite, child) {
              return IconButton(
                onPressed:
                    () => context.read<ApplistProvider>().toggleFavorite(app),
                icon: Icon(Symbols.favorite, fill: isFavorite ? 1 : 0),
                color: Theme.of(context).colorScheme.primary,
              );
            },
          ),
        ],
      ),
    );
  }
}

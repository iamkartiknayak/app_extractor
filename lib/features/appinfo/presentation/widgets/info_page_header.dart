import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/app_icon.dart';
import '../../application/favorite_apps_provider.dart';
import './favorite_button.dart';

class InfoPageHeader extends ConsumerWidget {
  const InfoPageHeader({
    super.key,
    required this.appName,
    required this.packageName,
  });

  final String appName;
  final String packageName;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFav = favorites.contains(packageName);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      child: Row(
        children: [
          AppIcon(packageName: packageName, size: 50.0),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(packageName, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          FavoriteButton(isFav: isFav, packageName: packageName),
        ],
      ),
    );
  }
}

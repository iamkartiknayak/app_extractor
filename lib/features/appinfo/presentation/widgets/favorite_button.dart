import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/favorite_apps_provider.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.isFav,
    required this.packageName,
  });

  final bool isFav;
  final String packageName;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) => IconButton(
    icon: Icon(
      isFav ? Icons.favorite : Icons.favorite_border,
      color: isFav ? Theme.of(context).colorScheme.primary : null,
    ),
    onPressed: () {
      ref.read(favoritesProvider.notifier).toggleFavorite(packageName);
    },
  );
}

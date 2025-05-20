import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class InfoPageHeader extends ConsumerWidget {
  const InfoPageHeader({
    super.key,
    required this.appName,
    required this.packageName,
  });

  final String appName;
  final String packageName;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
    child: Row(
      children: [
        Icon(
          Symbols.android,
          size: 40.0,
          color: Theme.of(context).colorScheme.primary,
        ),
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
        const Icon(Symbols.favorite),
      ],
    ),
  );
}

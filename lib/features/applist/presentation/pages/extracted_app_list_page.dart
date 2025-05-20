import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';

import '../../../appinfo/application/extracted_apps_provider.dart';

class ExtractedAppListPage extends ConsumerWidget {
  const ExtractedAppListPage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final extractedApps =
        ref.watch(extractedAppsProvider).extractedApps.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text('Extracted Apps (${extractedApps.length})')),
      body: ListView.separated(
        itemCount: extractedApps.length,
        itemBuilder: (_, final index) {
          final app = extractedApps[index];

          return Card(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            color: Theme.of(
              context,
            ).colorScheme.surfaceTint.withValues(alpha: 0.04),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 16.0, right: 12.0),
              leading: Icon(
                Symbols.android,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(app.appName),
              subtitle: Text(app.appSize),
              trailing: IconButton(
                onPressed: () {
                  SharePlus.instance.share(
                    ShareParams(files: [XFile(app.appPath)]),
                  );
                },
                icon: Icon(
                  Symbols.share,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
        },
        padding: const EdgeInsets.all(12.0),
        separatorBuilder: (_, _) => const SizedBox(height: 12.0),
      ),
    );
  }
}

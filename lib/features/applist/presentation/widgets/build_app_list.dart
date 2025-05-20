import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../common/extract_share_button.dart';
import '../../../appinfo/presentation/pages/app_info_page.dart';

class BuildAppList extends ConsumerWidget {
  const BuildAppList({super.key, required this.apps});

  final List<Application> apps;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) =>
      ListView.separated(
        itemCount: apps.length,
        itemBuilder: (_, final index) {
          final app = apps[index];

          return Card(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            color: Theme.of(
              context,
            ).colorScheme.surfaceTint.withValues(alpha: 0.04),
            child: ListTile(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => AppInfoPage(app: app),
                    ),
                  ),
              contentPadding: const EdgeInsets.only(left: 16.0, right: 12.0),
              leading: Icon(
                Symbols.android,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: _TileText(text: app.appName),
              subtitle: _TileText(text: app.packageName),
              trailing: ExtractShareButton(app: app),
            ),
          );
        },
        padding: const EdgeInsets.all(12.0),
        separatorBuilder: (_, _) => const SizedBox(height: 12.0),
      );
}

class _TileText extends StatelessWidget {
  const _TileText({required this.text});

  final String text;

  @override
  Widget build(final BuildContext context) =>
      Text(text, maxLines: 1, overflow: TextOverflow.ellipsis);
}

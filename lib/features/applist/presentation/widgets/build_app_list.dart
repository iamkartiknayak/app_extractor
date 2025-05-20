import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/custom_list_tile.dart';
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

          return CustomListTile(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => AppInfoPage(app: app),
                  ),
                ),
            title: app.appName,
            subTitle: app.packageName,
            trailing: ExtractShareButton(app: app),
          );
        },
        padding: const EdgeInsets.all(12.0),
        separatorBuilder: (_, _) => const SizedBox(height: 12.0),
      );
}

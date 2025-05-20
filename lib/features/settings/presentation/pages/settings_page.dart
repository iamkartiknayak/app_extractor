import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../application/settings_provider.dart';
import '../widgets/default_file_name_dialog.dart';
import '../widgets/delete_extacted_apk_tile.dart';
import '../widgets/settings_tile.dart';
import '../widgets/side_header.dart';
import './app_about_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final notifier = ref.read(settingsProvider.notifier);
    final defaultApkName = ref.watch(
      settingsProvider.select((final s) => s.defaultApkName),
    );
    final showNonLaunchable = ref.watch(
      settingsProvider.select((final s) => s.showNonLaunchable),
    );
    final gridView = ref.watch(
      settingsProvider.select((final s) => s.gridView),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SideHeader(header: 'Settings'),
          const DeleteExtractedApksTile(),
          SettingsTile(
            onTap: () {
              showDialog<void>(
                context: context,
                builder:
                    (final BuildContext context) =>
                        const DefaultFileNameDialog(),
              );
            },
            icon: Symbols.save_as,
            title: const Text('Default filename for extracted APKs'),
            subTitle: Text(defaultApkName),
          ),
          SettingsTile(
            icon: Symbols.settings_applications,
            title: const Text('Show non-launchable apps'),
            subTitle: const Text('Includes system background apps'),
            trailing: Switch(
              value: showNonLaunchable,
              onChanged: (final val) => notifier.toggleNonLaunchable(val, ref),
            ),
          ),
          const SideHeader(header: 'Customization'),
          SettingsTile(
            icon: Symbols.grid_view,
            title: const Text('Grid layout'),
            trailing: Switch(
              value: gridView,
              onChanged: (_) => notifier.toggleGridView(),
            ),
          ),
          const SideHeader(header: 'About'),
          const SettingsTile(
            icon: Symbols.info,
            title: Text('App Info'),
            navigateTo: AppAboutPage(),
          ),
        ],
      ),
    );
  }
}

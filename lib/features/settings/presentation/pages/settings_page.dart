import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

import '../../../appinfo/application/app_info_provider.dart';
import '../../../applist/presentation/widgets/settings_tile.dart';
import '../../application/settings_provider.dart';
import '../widgets/default_file_name_dialog.dart';
import '../widgets/side_header.dart';
import 'app_about_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.read<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SideHeader(header: 'Settings'),
          SettingsTile(
            onTap: () {
              showDialog<void>(
                context: context,
                builder:
                    (BuildContext context) => CustomAlertDialog(
                      title: 'Delete All?',
                      content: const Text(
                        'Permanently delete all extracted APKs?',
                      ),
                      actionButton: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context
                              .read<AppInfoProvider>()
                              .deleteAllExtractedApps();
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
              );
            },
            icon: Symbols.delete_forever,
            title: const Text('Delete extracted APKs'),
            subTitle: const Text('Remove all extracted APKs from storage'),
          ),
          SettingsTile(
            onTap: () {
              showDialog<void>(
                context: context,
                builder:
                    (BuildContext context) => const DefaultFileNameDialog(),
              );
            },
            icon: Symbols.save_as,
            title: const Text('Default filename for extracted APKs'),
            subTitle: Selector<SettingsProvider, String>(
              selector: (_, provider) => provider.defaultApkName,
              builder: (_, value, _) => Text(value),
            ),
          ),
          SettingsTile(
            icon: Symbols.settings_applications,
            title: const Text('Show non-launchable apps'),
            subTitle: const Text('Includes system background apps'),
            trailing: Selector<SettingsProvider, bool>(
              selector: (_, provider) => provider.showNonLaunchable,
              builder:
                  (_, value, _) => Switch(
                    value: value,
                    onChanged:
                        (value) => settingsProvider.toggleNonLaunchable(
                          value,
                          context,
                        ),
                  ),
            ),
          ),
          const SideHeader(header: 'Customization'),
          SettingsTile(
            icon: Symbols.grid_view,
            title: const Text('Grid layout'),
            trailing: Selector<SettingsProvider, bool>(
              selector: (_, provider) => provider.gridView,
              builder:
                  (_, value, _) => Switch(
                    value: value,
                    onChanged: (value) => settingsProvider.toggleGridView(),
                  ),
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

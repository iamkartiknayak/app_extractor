import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'app_about_page.dart';
import '../widgets/side_header.dart';
import '../widgets/default_file_name_dialog.dart';
import '../../../features/applist/presentation/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideHeader(header: 'Settings'),
          SettingsTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    title: 'Delete All?',
                    content: Text('Permanently delete all extracted APKs?'),
                    actionButton: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: Symbols.delete_forever,
            title: 'Delete extracted APKs',
            subTitle: 'Remove all extracted APKs from storage',
          ),

          SideHeader(header: 'About'),
          SettingsTile(
            icon: Symbols.info,
            title: 'App Info',
            navigateTo: AppAboutPage(),
          ),
        ],
      ),
    );
  }
}

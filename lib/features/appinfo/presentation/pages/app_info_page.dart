import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/helpers/date_time_helper.dart';
import '../../application/app_info_provider.dart';
import '../widgets/app_action_bar.dart';
import '../widgets/app_info_tile.dart';
import '../widgets/info_page_header.dart';

class AppInfoPage extends ConsumerWidget {
  const AppInfoPage({super.key, required this.app});

  final Application app;

  String getAppCategory(final ApplicationCategory appCategory) =>
      appCategory.toString().split('.').last.capitalize();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final analysisAsync = ref.watch(appAnalysisProvider(app));

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Info'),
        actionsPadding: const EdgeInsets.only(right: 8.0),
        actions: const [Icon(Symbols.unarchive)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InfoPageHeader(
                appName: app.appName,
                packageName: app.packageName,
              ),
              const SizedBox(height: 8.0),
              AppActionBar(app: app),
              const SizedBox(height: 24.0),
              AppInfoTile(
                value: app.appName,
                icon: Symbols.title,
                label: 'App name',
              ),
              const Divider(),
              analysisAsync.when(
                data: (final data) => _buildApkSizeTile(data.size),
                loading: () => _buildApkSizeTile('Parsing...'),
                error: (_, _) => _buildApkSizeTile('Error loading'),
              ),
              const Divider(),
              AppInfoTile(
                value: app.packageName,
                icon: Symbols.package_2,
                label: 'Package name',
              ),
              const Divider(),
              AppInfoTile(
                value: app.versionName ?? 'N/A',
                icon: Symbols.new_releases,
                label: 'App version',
              ),
              const Divider(),
              AppInfoTile(
                value: getAppCategory(app.category),
                icon: Symbols.category,
                label: 'App category',
              ),
              const Divider(),
              AppInfoTile(
                value: app.enabled.toString().capitalize(),
                icon: Symbols.toggle_off,
                label: 'Enabled',
              ),
              const Divider(),
              AppInfoTile(
                value: DatetimeHelper.formatEpochTime(app.installTimeMillis),
                icon: Symbols.calendar_clock,
                label: 'Installed on',
              ),
              const Divider(),
              AppInfoTile(
                value: app.systemApp.toString().capitalize(),
                icon: Symbols.phone_android,
                label: 'System App',
              ),
              const Divider(),
              analysisAsync.when(
                data: (final data) => _buildTechStackTile(data.techStack),
                loading: () => _buildTechStackTile('Parsing...'),
                error: (_, _) => _buildTechStackTile('Error loading'),
              ),
              const Divider(),
              AppInfoTile(
                value: app.dataDir ?? 'Not available',
                icon: Symbols.folder,
                label: 'Data directory',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTechStackTile(final String value) =>
    AppInfoTile(value: value, icon: Symbols.construction, label: 'Tech stack');

Widget _buildApkSizeTile(final String value) =>
    AppInfoTile(value: value, icon: Symbols.android, label: 'APK size');

extension StringExtension on String {
  String capitalize() => isEmpty ? this : this[0].toUpperCase() + substring(1);
}

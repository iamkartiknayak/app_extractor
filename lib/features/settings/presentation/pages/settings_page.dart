import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/delete_extacted_apk_tile.dart';
import '../widgets/side_header.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [SideHeader(header: 'Settings'), DeleteExtractedApksTile()],
    ),
  );
}

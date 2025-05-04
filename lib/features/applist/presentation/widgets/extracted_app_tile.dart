import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../common/app_tile.dart';
import '../../../appinfo/data/models/extracted_app_model.dart';

class ExtractedAppTile extends StatelessWidget {
  const ExtractedAppTile({super.key, required this.app, required this.index});

  final ExtractedAppModel app;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AppTile(
      title: app.appName,
      subTitle: app.appSize,
      packageName: app.packageName,
      trailing: IconButton(
        onPressed: () {
          final file = File(app.appPath);
          SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
        },
        icon: Icon(Symbols.share, color: Theme.of(context).colorScheme.primary),
      ),
      index: index,
    );
  }
}

import 'dart:io';

import 'package:app_extractor/common/app_tile.dart';
import 'package:app_extractor/features/appinfo/data/models/extracted_app_model.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:share_plus/share_plus.dart';

class ExtractedAppTile extends StatelessWidget {
  const ExtractedAppTile({super.key, required this.app});

  final ExtractedAppModel app;

  @override
  Widget build(BuildContext context) {
    return AppTile(
      icon: app.appIcon,
      title: app.appName,
      subTitle: app.appSize,
      trailingIcon: Symbols.share,
      trailingAction: () {
        final file = File(app.appPath);
        SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
      },
    );
  }
}

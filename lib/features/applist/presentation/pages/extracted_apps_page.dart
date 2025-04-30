import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/extracted_app_tile.dart';
import '../../../appinfo/application/app_info_provider.dart';

class ExtractedAppsPage extends StatelessWidget {
  const ExtractedAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final extractedAppsList =
        context.watch<AppInfoProvider>().extractedAppsList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Extracted Apps (${extractedAppsList.length})'),
      ),
      body: ListView.builder(
        itemCount: extractedAppsList.length,
        itemBuilder:
            (context, index) => ExtractedAppTile(app: extractedAppsList[index]),
      ),
    );
  }
}

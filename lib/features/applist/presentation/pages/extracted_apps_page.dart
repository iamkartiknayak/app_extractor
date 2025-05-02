import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../../../common/empty_data_widget.dart';
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
      body:
          extractedAppsList.isEmpty
              ? EmptyDataWidget(
                icon: Symbols.inbox,
                title: 'No APKs extracted yet',
                subTitle: 'Start by extracting an app to see it listed here',
              )
              : ListView.builder(
                itemCount: extractedAppsList.length,
                itemBuilder:
                    (context, index) => ExtractedAppTile(
                      app: extractedAppsList[index],
                      index: index,
                    ),
              ),
    );
  }
}

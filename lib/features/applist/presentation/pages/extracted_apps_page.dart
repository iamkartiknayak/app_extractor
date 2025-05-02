import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../../../common/empty_data_widget.dart';
import '../../application/applist_provider.dart';
import '../widgets/extracted_app_tile.dart';
import '../../../appinfo/application/app_info_provider.dart';

class ExtractedAppsPage extends StatelessWidget {
  const ExtractedAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final extractedAppsList =
        context.watch<AppInfoProvider>().extractedAppsList;

    return PopScope(
      canPop: !context.select<ApplistProvider, bool>((p) => p.longPress),
      onPopInvokedWithResult: (_, _) {
        context.read<ApplistProvider>().resetSelection();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 56.0),
          child: Selector<
            ApplistProvider,
            ({
              String title,
              bool searchEnabled,
              List<Application> appList,
              int selectedIndexListLength,
            })
          >(
            selector:
                (_, provider) => (
                  title: provider.currentTitle,
                  searchEnabled: provider.searchEnabled,
                  appList: provider.currentAppList,
                  selectedIndexListLength:
                      provider.selectedItemIndexList.length,
                ),
            builder: (_, data, __) {
              return data.selectedIndexListLength != 0
                  ? Builder(
                    builder: (_) {
                      final appListProvider = context.read<ApplistProvider>();

                      return AppBar(
                        title: Text('${data.selectedIndexListLength} selected'),
                        automaticallyImplyLeading: false,
                        actions: [
                          IconButton(
                            onPressed:
                                () => appListProvider.batchAppDelete(context),
                            icon: Icon(
                              data.searchEnabled
                                  ? Symbols.close
                                  : Symbols.delete_forever,
                            ),
                          ),
                          IconButton(
                            onPressed: appListProvider.resetSelection,
                            icon: Icon(
                              data.searchEnabled
                                  ? Symbols.close
                                  : Symbols.cancel,
                            ),
                          ),
                        ],
                      );
                    },
                  )
                  : AppBar(
                    title: Text('Extracted Apps (${extractedAppsList.length})'),
                  );
            },
          ),
        ),
        body: Selector<AppInfoProvider, int>(
          selector: (_, provider) => provider.extractedAppsList.length,
          builder: (context, extractedAppsListLength, child) {
            return extractedAppsListLength == 0
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
                );
          },
        ),
      ),
    );
  }
}

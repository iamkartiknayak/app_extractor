import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../common/custom_list_tile.dart';
import '../../../../common/empty_data_widget.dart';
import '../../../../common/leading_widget.dart';
import '../../../../core/helpers/app_interaction_helper.dart';
import '../../../appinfo/application/extracted_apps_provider.dart';
import '../../../appinfo/data/models/extracted_app_model.dart';
import '../../application/long_press_provider.dart';
import '../widgets/selection_app_bar.dart';

class ExtractedAppListPage extends ConsumerWidget {
  const ExtractedAppListPage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final exAppNotifier = ref.read(extractedAppsProvider.notifier);
    final extractedApps =
        ref.watch(extractedAppsProvider).extractedApps.values.toList();

    return PopScope(
      canPop: !ref.watch(longPressProvider),
      onPopInvokedWithResult: (_, _) => resetSelection(ref),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60.0),
          child: Consumer(
            builder: (_, final ref, _) {
              final longPress = ref.watch(longPressProvider);

              return longPress
                  ? SelectionAppBar(
                    onPressed: () => exAppNotifier.batchDeleteApks(ref),
                    icon: Symbols.delete_forever,
                  )
                  : AppBar(
                    title: Text('Extracted Apps (${extractedApps.length})'),
                  );
            },
          ),
        ),
        body:
            extractedApps.isEmpty
                ? const EmptyDataWidget(
                  icon: Symbols.inbox,
                  title: 'No APKs extracted yet',
                  subTitle: 'Start by extracting an app to see it listed here',
                )
                : _buildExtractedAppsList(extractedApps, context, ref),
      ),
    );
  }

  ListView _buildExtractedAppsList(
    final List<ExtractedAppModel> extractedApps,
    final BuildContext context,
    final WidgetRef ref,
  ) => ListView.separated(
    itemCount: extractedApps.length,
    itemBuilder: (_, final index) {
      final app = extractedApps[index];
      final tap = AppInteractionHelper.getTapHandlers(
        context: context,
        ref: ref,
        index: index,
      );

      return Consumer(
        builder: (_, final ref, _) {
          final longPress = ref.watch(longPressProvider);
          final selected = ref.watch(selectedItemsProvider).contains(index);

          return CustomListTile(
            onTap: tap.onTap,
            onLongPress: tap.onLongPress,
            selected: selected,
            leading: LeadingWidget(
              index: index,
              selected: selected,
              rawIcon: app.appIcon,
            ),
            title: app.appName,
            subTitle: app.packageName,
            trailing: longPress ? null : _buildShareButton(app, context),
          );
        },
      );
    },
    padding: const EdgeInsets.all(12.0),
    separatorBuilder: (_, _) => const SizedBox(height: 12.0),
  );

  IconButton _buildShareButton(
    final ExtractedAppModel app,
    final BuildContext context,
  ) => IconButton(
    onPressed: () {
      SharePlus.instance.share(ShareParams(files: [XFile(app.appPath)]));
    },
    icon: Icon(Symbols.share, color: Theme.of(context).colorScheme.primary),
  );
}

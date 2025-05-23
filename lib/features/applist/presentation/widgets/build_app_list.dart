import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/custom_list_tile.dart';
import '../../../../common/extract_share_button.dart';
import '../../../../common/leading_widget.dart';
import '../../../../core/helpers/app_interaction_helper.dart';
import '../../../home/application/home_provider.dart';
import '../../application/long_press_provider.dart';
import './shimmer_widget.dart';

class BuildAppList extends ConsumerWidget {
  const BuildAppList({super.key, required this.apps});

  final List<Application> apps;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isLoading = apps.isEmpty;

    return ListView.separated(
      controller: ref.read(scrollControllerProvider),
      itemCount: isLoading ? 10 : apps.length,
      itemBuilder: (_, final index) {
        if (isLoading) {
          return const ShimmerTile();
        }

        final app = apps[index];
        final tap = AppInteractionHelper.getTapHandlers(
          context: context,
          ref: ref,
          index: index,
          app: app,
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
                packageName: app.packageName,
              ),
              title: app.appName,
              subTitle: app.packageName,
              trailing: longPress ? null : ExtractShareButton(app: app),
            );
          },
        );
      },
      padding: const EdgeInsets.all(12.0),
      separatorBuilder: (_, _) => const SizedBox(height: 12.0),
    );
  }
}

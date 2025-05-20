import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/custom_list_tile.dart';
import '../../../../common/extract_share_button.dart';
import '../../../../common/leading_widget.dart';
import '../../../../core/helpers/app_interaction_helper.dart';
import '../../application/long_press_provider.dart';

class BuildAppList extends ConsumerWidget {
  const BuildAppList({super.key, required this.apps});

  final List<Application> apps;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final longPress = ref.watch(longPressProvider);
    debugPrint('build called...');

    return ListView.separated(
      itemCount: apps.length,
      itemBuilder: (_, final index) {
        final app = apps[index];
        final tap = AppInteractionHelper.getTapHandlers(
          context: context,
          ref: ref,
          index: index,
          app: app,
        );

        return CustomListTile(
          onTap: tap.onTap,
          onLongPress: tap.onLongPress,
          leading: LeadingWidget(index: index),
          title: app.appName,
          subTitle: app.packageName,
          trailing: longPress ? null : ExtractShareButton(app: app),
        );
      },
      padding: const EdgeInsets.all(12.0),
      separatorBuilder: (_, _) => const SizedBox(height: 12.0),
    );
  }
}

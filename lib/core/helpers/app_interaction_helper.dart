import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/appinfo/application/app_info_provider.dart';
import '../../features/appinfo/presentation/pages/app_info_page.dart';
import '../../features/applist/application/long_press_provider.dart';

typedef TapCallbacks = ({VoidCallback onTap, VoidCallback onLongPress});

class AppInteractionHelper {
  static TapCallbacks getTapHandlers({
    required final BuildContext context,
    required final WidgetRef ref,
    required final int index,
    final Application? app,
  }) => (
    onTap: () {
      final longPress = ref.read(longPressProvider);
      final openedAppNotifier = ref.read(openedAppIdProvider.notifier);

      if (longPress) {
        toggleSelectedIndex(ref, index);
      } else if (app != null) {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (_) => AppInfoPage(app: app)),
        ).then((_) {
          openedAppNotifier.state = null;
        });
        openedAppNotifier.state = app.packageName;
      }
    },
    onLongPress: () {
      ref.read(longPressProvider.notifier).state = true;
      toggleSelectedIndex(ref, index);
    },
  );
}

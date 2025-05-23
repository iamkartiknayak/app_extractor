import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../applist/application/long_press_provider.dart';
import '../../applist/application/search_provider.dart';
import '../../applist/presentation/pages/app_gallery.dart';
import '../../settings/presentation/pages/settings_page.dart';

final navbarProvider = NotifierProvider<NavbarIndexNotifier, int>(
  () => NavbarIndexNotifier(),
);

final scrollControllerProvider = Provider<ScrollController>(
  (_) => ScrollController(),
);

class NavbarIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void updateIndex(final int selectedIndex, final WidgetRef ref) {
    final scrollController = ref.read(scrollControllerProvider);

    if (scrollController.hasClients) {
      if (state == selectedIndex) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        return;
      } else {
        scrollController.jumpTo(0.0);
      }
    }

    ref.read(searchProvider.notifier).clearSearch();
    resetSelection(ref);
    state = selectedIndex;
  }
}

final navbarPages = Provider<List<Widget>>(
  (final ref) => const [
    AppGallery(AppGalleryType.installed),
    AppGallery(AppGalleryType.system),
    AppGallery(AppGalleryType.favorites),
    SettingsPage(),
  ],
);

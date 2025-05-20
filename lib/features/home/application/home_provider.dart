import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../applist/presentation/pages/app_gallery.dart';

final navbarProvider = NotifierProvider<NavbarIndexNotifier, int>(
  () => NavbarIndexNotifier(),
);

class NavbarIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void updateIndex(final int selectedIndex) {
    state = selectedIndex;
  }
}

final navbarPages = Provider<List<Widget>>(
  (final ref) => const [
    AppGallery(AppGalleryType.installed),
    AppGallery(AppGalleryType.system),
    Text('Favorite Apps Page'),
    Text('Settings Page'),
  ],
);

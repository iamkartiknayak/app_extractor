import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    Text('Installed Apps Page'),
    Text('System Apps Page'),
    Text('Favorite Apps Page'),
    Text('Settings Page'),
  ],
);

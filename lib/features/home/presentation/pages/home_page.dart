import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../application/home_provider.dart';
import '../widgets/navbar_item.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final currentIndex = ref.watch(navbarProvider);
    final pages = ref.read(navbarPages);

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (final index) {
          ref.read(navbarProvider.notifier).updateIndex(index, ref);
        },
        destinations: const [
          NavbarItem(icon: Symbols.archive, label: 'Installed Apps'),
          NavbarItem(icon: Symbols.phone_android, label: 'System Apps'),
          NavbarItem(icon: Symbols.favorite, label: 'Favorite Apps'),
          NavbarItem(icon: Symbols.settings, label: 'Settings'),
        ],
      ),
    );
  }
}

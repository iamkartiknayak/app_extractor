import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

import '../../application/home_provider.dart';
import '../../../applist/application/applist_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final navbarProvider = context.watch<NavbarIndexProvider>();
    context.read<ApplistProvider>().init();

    return Scaffold(
      body: IndexedStack(
        index: navbarProvider.currentIndex,
        children: navbarProvider.pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navbarProvider.currentIndex,
        onDestinationSelected: navbarProvider.updateIndex,
        destinations: [
          NavigationDestination(
            label: 'Installed Apps',
            icon: Icon(Symbols.archive),
            selectedIcon: Icon(Symbols.archive, fill: 1),
          ),
          NavigationDestination(
            label: 'System Apps',
            icon: Icon(Symbols.phone_android),
            selectedIcon: Icon(Symbols.phone_android, fill: 1),
          ),
          NavigationDestination(
            label: 'Favorite Apps',
            icon: Icon(Symbols.favorite),
            selectedIcon: Icon(Symbols.favorite, fill: 1),
          ),
          NavigationDestination(
            label: 'Settings',
            icon: Icon(Symbols.settings),
            selectedIcon: Icon(Symbols.settings, fill: 1),
          ),
        ],
      ),
    );
  }
}

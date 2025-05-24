import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../core/helpers/app_event_helper.dart';
import '../../application/home_provider.dart';
import '../widgets/navbar_item.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final AppEventHelper appEventHelper;

  @override
  void initState() {
    super.initState();
    appEventHelper = AppEventHelper(ref, context);
  }

  @override
  void dispose() {
    appEventHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
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

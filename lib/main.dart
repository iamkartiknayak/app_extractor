import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './core/helpers/box_helper.dart';
import './features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BoxHelper.instance.init();
  runApp(const ProviderScope(child: Dexify()));
}

class Dexify extends StatelessWidget {
  const Dexify({super.key});

  @override
  Widget build(final BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
    );

    return DynamicColorBuilder(
      builder: (final lightDynamic, final darkDynamic) {
        final lightScheme =
            lightDynamic?.harmonized() ??
            ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.light,
            );
        final darkScheme =
            darkDynamic?.harmonized() ??
            ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.dark,
            );

        return MaterialApp(
          title: 'Dexify',
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          theme: ThemeData(
            colorScheme: lightScheme,
            navigationBarTheme: NavigationBarThemeData(
              surfaceTintColor: lightScheme.surfaceTint,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: darkScheme,
            navigationBarTheme: NavigationBarThemeData(
              surfaceTintColor: darkScheme.surfaceTint,
            ),
            scaffoldBackgroundColor: darkScheme.surface,
          ),
        );
      },
    );
  }
}

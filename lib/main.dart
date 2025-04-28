import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './helpers/theme_helper.dart';
import './features/home/presentation/pages/home_page.dart';

void main() => runApp(AppExtractor());

class AppExtractor extends StatelessWidget {
  const AppExtractor({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
    );

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? darkColorScheme;
        ColorScheme? lightColorScheme;

        if (darkDynamic != null && lightDynamic != null) {
          darkColorScheme = darkDynamic.harmonized();
          lightColorScheme = lightDynamic.harmonized();
        } else {
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          );
          lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);
        }

        return MaterialApp(
          title: 'App Extractor',
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          theme: ThemeData(
            colorScheme: lightColorScheme,
            navigationBarTheme: NavigationBarThemeData(
              surfaceTintColor: lightColorScheme.surfaceTint,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            navigationBarTheme: NavigationBarThemeData(
              surfaceTintColor: darkColorScheme.surfaceTint,
            ),
            scaffoldBackgroundColor: ThemeHelper.darkenColor(
              darkColorScheme.surface,
              0.03,
            ),
          ),
        );
      },
    );
  }
}

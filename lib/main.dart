import 'package:flutter/material.dart';

import './features/home/presentation/pages/home_page.dart';

void main() => runApp(AppExtractor());

class AppExtractor extends StatelessWidget {
  const AppExtractor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Extractor',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

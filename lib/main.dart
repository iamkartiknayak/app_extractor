import 'package:flutter/material.dart';

void main() => runApp(AppExtractor());

class AppExtractor extends StatelessWidget {
  const AppExtractor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Extractor',
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('App Extractor'))),
    );
  }
}

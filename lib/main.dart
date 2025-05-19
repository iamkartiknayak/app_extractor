import 'package:flutter/material.dart';

void main() => runApp(const Dexify());

class Dexify extends StatelessWidget {
  const Dexify({super.key});

  @override
  Widget build(final BuildContext context) => const MaterialApp(
    title: 'Dexify',
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: Center(child: Text('Dexify'))),
  );
}

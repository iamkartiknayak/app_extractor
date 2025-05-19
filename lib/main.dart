import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './features/home/presentation/pages/home_page.dart';

void main() => runApp(const ProviderScope(child: Dexify()));

class Dexify extends StatelessWidget {
  const Dexify({super.key});

  @override
  Widget build(final BuildContext context) => const MaterialApp(
    title: 'Dexify',
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  );
}

import 'package:flutter/material.dart';

class SideHeader extends StatelessWidget {
  const SideHeader({super.key, required this.header});

  final String header;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0),
    child: Text(
      header,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

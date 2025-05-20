import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.onTap,
    required this.title,
    required this.subTitle,
    required this.trailing,
  });

  final VoidCallback? onTap;
  final String title;
  final String subTitle;
  final Widget trailing;

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.zero,
    color: Theme.of(context).colorScheme.surfaceTint.withValues(alpha: 0.04),
    child: ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(left: 16.0, right: 12.0),
      leading: Icon(
        Symbols.android,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: _TileText(text: title),
      subtitle: _TileText(text: subTitle),
      trailing: trailing,
    ),
  );
}

class _TileText extends StatelessWidget {
  const _TileText({required this.text});

  final String text;

  @override
  Widget build(final BuildContext context) =>
      Text(text, maxLines: 1, overflow: TextOverflow.ellipsis);
}

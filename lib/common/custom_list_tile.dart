import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.leading,
    required this.title,
    required this.subTitle,
    this.trailing,
  });

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget leading;
  final String title;
  final String subTitle;
  final Widget? trailing;

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.zero,
    color: Theme.of(context).colorScheme.surfaceTint.withValues(alpha: 0.04),
    child: ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      contentPadding: const EdgeInsets.only(left: 16.0, right: 12.0),
      leading: leading,
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

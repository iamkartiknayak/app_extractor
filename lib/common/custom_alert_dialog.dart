import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.actionButton,
  });

  final String title;
  final Widget content;
  final Widget? actionButton;

  @override
  Widget build(final BuildContext context) => AlertDialog(
    actionsPadding: const EdgeInsets.only(right: 24.0, bottom: 16.0),
    title: Text(title),
    contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 8.0),
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: content,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
      if (actionButton != null) actionButton!,
    ],
  );
}

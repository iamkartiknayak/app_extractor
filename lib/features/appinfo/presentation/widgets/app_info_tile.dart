import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants.dart';

class AppInfoTile extends StatelessWidget {
  const AppInfoTile({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => InkWell(
    customBorder: RoundedRectangleBorder(borderRadius: kBorderRadius),
    onTap: () {
      Clipboard.setData(ClipboardData(text: value));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$label has been copied to clipboard'),
          duration: const Duration(milliseconds: 800),
        ),
      );
    },
    child: Container(
      height: 52.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 16.0),
          Expanded(child: Text(label)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              maxLines: 2,
            ),
          ),
        ],
      ),
    ),
  );
}

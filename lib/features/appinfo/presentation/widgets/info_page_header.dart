import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../constants.dart';

class InfoPageHeader extends StatelessWidget {
  const InfoPageHeader({super.key, required this.app});

  final Application app;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(borderRadius: kBorderRadius),
            child:
                app is ApplicationWithIcon
                    ? Image.memory((app as ApplicationWithIcon).icon)
                    : Icon(Symbols.android),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.appName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(app.packageName, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          SizedBox(width: 12.0),
          IconButton(
            onPressed: () {},
            icon: Icon(Symbols.favorite),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

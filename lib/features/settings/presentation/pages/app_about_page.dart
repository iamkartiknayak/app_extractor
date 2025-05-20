import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/section_card.dart';

class AppAboutPage extends StatelessWidget {
  const AppAboutPage({super.key});

  static const gitProfile = 'github.com/iamkartiknayak';

  @override
  Widget build(final BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('App Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12.0,
          children: [
            SectionCard(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 64.0,
                    width: 64.0,
                    child: Image.asset(
                      'assets/icons/icon.png',
                      height: 64.0,
                      width: 64.0,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dexify', style: textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(
                        'Version 2.0.0',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description', style: textTheme.titleMedium),
                  Text(
                    'Dexify is a modern, ad-free APK extractor with Material 3 design, supporting app export, system app viewing, and grid/list layouts',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Features', style: textTheme.titleMedium),
                  Text(
                    '- View app info: version, build platform and more.\n'
                    '- Extract and backup APK files with ease.\n'
                    '- Share APKs or save them for future installations.\n'
                    '- Features include searching, batch operations.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Developer', style: textTheme.titleMedium),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        height: 50.0,
                        'https://avatars.githubusercontent.com/u/65574961?v=4',
                        errorBuilder:
                            (_, _, _) => Image.asset(
                              'assets/images/profile.jpg',
                              height: 50.0,
                              width: 50.0,
                            ),
                        loadingBuilder: (
                          _,
                          final child,
                          final loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Image.asset('assets/images/profile.jpg');
                        },
                      ),
                    ),
                    title: const Text('Kartik Nayak'),
                    subtitle: const Text(gitProfile),
                    subtitleTextStyle: TextStyle(color: colorScheme.primary),
                    trailing: IconButton(
                      onPressed: () {
                        launchUrl(
                          Uri.parse('https://$gitProfile/dexify'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      icon: const Icon(Symbols.launch),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text.rich(
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 16.0,
              ),
              TextSpan(
                children: [
                  const TextSpan(text: 'Made with '),
                  WidgetSpan(
                    child: Icon(
                      Symbols.favorite,
                      fill: 1,
                      size: 18.0,
                      color: colorScheme.primary,
                    ),
                  ),
                  const TextSpan(text: ' in '),
                  const TextSpan(
                    text: 'Bharat',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}

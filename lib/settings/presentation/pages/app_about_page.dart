import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/shimmer_container.dart';
import '../widgets/section_card.dart';

class AppAboutPage extends StatelessWidget {
  const AppAboutPage({super.key});

  static const gitProfile = 'github.com/iamkartiknayak';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('App Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionCard(
              child: Row(
                children: [
                  Container(
                    width: 64.0,
                    height: 64.0,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'APK',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('APK Extractor Pro', style: textTheme.titleLarge),
                        const SizedBox(height: 4),
                        Text(
                          'Version 2.3.1 (Build 230)',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Installed: April 2, 2025',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Features', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    '- View app info: version, build platform and more.\n'
                    '- Extract and backup APK files with ease.\n'
                    '- Share APKs or save them for future installations.\n'
                    '- Features include searching, batch extraction & deletion.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Developer', style: textTheme.titleMedium),
                  const SizedBox(height: 4.0),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      height: 50.0,
                      width: 50.0,

                      child: Image.network(
                        'https://avatars.githubusercontent.com/u/65574961?v=4',
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/profile.jpg');
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return ShimmerContainer(height: 20.0, width: 20.0);
                        },
                      ),
                    ),
                    title: Text('Kartik Nayak'),
                    subtitle: Text(gitProfile),
                    subtitleTextStyle: TextStyle(color: colorScheme.primary),
                    trailing: IconButton(
                      onPressed: () {
                        launchUrl(
                          Uri.parse('https://$gitProfile/app_extractor'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      icon: Icon(Symbols.launch),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: Text.rich(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16.0,
                ),
                TextSpan(
                  children: [
                    TextSpan(text: 'Made with '),
                    WidgetSpan(
                      child: Icon(
                        Symbols.favorite,
                        fill: 1,
                        size: 18.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    TextSpan(text: ' in '),
                    TextSpan(
                      text: 'Bharat',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}

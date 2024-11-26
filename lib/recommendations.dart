import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:provider/provider.dart';
import './themes/theme_provider.dart';
import './themes/themes.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Provider.of<ThemeProvider>(context).themeData == darkMode;

    return Scaffold(
        appBar: AppBar(),
        body: GridView.count(
          crossAxisCount: 1,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    // change colour to reference light/dark themes built by layla
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(
                        width: 8,
                        color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(10.0),
                child: Text(
                  'Top 3 Festivals for You...',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 255, 254, 254)
                          : Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    // change colour to reference light/dark themes built by layla
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(
                        width: 8,
                        color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(10.0),
                child: Text(
                  'Top 3 Festivals Your Favourite Artists Are At...',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    // change colour to reference light/dark themes built by layla
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(
                        width: 8,
                        color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(10.0),
                child: Text(
                  'Top 3 Festivals Including Your Favourite Genre...',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    // change colour to reference light/dark themes built by layla
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(
                        width: 8,
                        color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(10.0),
                child: Text(
                  'Top 3 Festivals that are a bit different...',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Colors.black),
                ),
              ),
            ),
          ],
        ));
  }
}

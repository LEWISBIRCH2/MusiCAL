import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
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
                    border: Border.all(width: 8),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(10.0),
                child: const Text(
                  'Top 3 Festivals for You...',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    // change colour to reference light/dark themes built by layla
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(width: 8),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(10.0),
                child: const Text(
                  'Top 3 Festivals Your Favourite Artists Are At...',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    // change colour to reference light/dark themes built by layla
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(width: 8),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(10.0),
                child: const Text(
                  'Top 3 Festivals Including Your Favourite Genre...',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    // change colour to reference light/dark themes built by layla
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(width: 8),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(10.0),
                child: const Text(
                  'Top 3 Festivals that are a bit different...',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                ),
              ),
            ),
          ],
        ));
  }
}

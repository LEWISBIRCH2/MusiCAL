import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// RichText(
//   text: TextSpan(
//     children: [
//       TextSpan(
//         text: 'Here is clickable',
//         style: TextStyle(color: Colors.black),
//       ),
//       TextSeparator(widget which represents an inline link),
//       TextSpan(
//         text: 'Cutsomise this part as needed',
//         style: TextStyle(color: Colors.black),
//       ),
//     ],),
// )

class Recommendations extends StatelessWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Row(
          children: [
            const Text(
              'Top 3 Festivals for You',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ));
  }
}

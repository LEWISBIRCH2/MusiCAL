import 'package:flutter/material.dart';
import 'defaulttab.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Center(
            child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          decoration: BoxDecoration(
              color: colorScheme.secondary,
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Login with Spotfy'),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Login with Spotify (Username)',
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Login with Spotify (Password)',
                  ),
                ),
                const ElevatedButton(
                    onPressed: null, child: Text('Click to Login'))
              ]),
        ),
      ),
    )));
  }
}

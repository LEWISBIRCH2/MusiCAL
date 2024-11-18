import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('MusiCAL - LOGIN-PAGE')),
        body: Center(
            child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
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
        )));
  }
}

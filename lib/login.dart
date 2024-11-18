import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('LOGIN-PAGE')),
        body: Center(
            child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'))));
  }
}

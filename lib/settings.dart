import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool showAccountSettings = false;
  bool showDarkMode = false;

  void toggleSection(String section) {
    setState(() {
      if (section == 'account') {
        showAccountSettings = !showAccountSettings;
      } else if (section == 'dark mode') {
        showDarkMode = !showDarkMode;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: showDarkMode
                ? Icon(Icons.contrast,
                    color: const Color.fromARGB(255, 157, 154, 154))
                : Icon(Icons.contrast,
                    color: const Color.fromARGB(255, 0, 0, 0)),
            title: showDarkMode ? Text('light mode') : Text('dark mode'),
            onTap: () => toggleSection('dark mode'),
          ),
          ListTile(
              leading: Icon(Icons.logout,
                  color: const Color.fromARGB(255, 39, 128, 31)),
              title: Text('logout')),
        ],
      ),
    );
  }
}

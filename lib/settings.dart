import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool showAccountSettings = false;
  bool showModeSettings = false;

  void toggleSection(String section) {
    setState(() {
      if (section == 'account') {
        showAccountSettings = !showAccountSettings;
      } else if (section == 'dark mode') {
        showModeSettings == !showModeSettings;
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
            leading: Icon(Icons.account_circle, color: Colors.blue),
            title: Text('Account'),
            onTap: () => toggleSection('account'),
          ),
          if (showAccountSettings)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [ListTile(title: Text('change username'))],
              ),
            ),
          ListTile(
            leading: Icon(Icons.contrast, color: Colors.orange),
            title: Text('dark mode'),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './themes/theme_provider.dart';
import './themes/themes.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void toggleDarkMode() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Provider.of<ThemeProvider>(context).themeData == darkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Icon(
              Icons.contrast,
              color: isDarkMode
                  ? const Color.fromARGB(255, 157, 154, 154)
                  : const Color.fromARGB(255, 0, 0, 0),
            ),
            title: Text(
              isDarkMode ? 'light mode' : 'dark mode',
              style: TextStyle(height: 5, fontSize: 20),
            ),
            onTap: toggleDarkMode,
          ),
          ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(
                Icons.logout,
                color: isDarkMode
                    ? const Color.fromARGB(255, 157, 154, 154)
                    : const Color.fromARGB(255, 0, 0, 0),
              ),
              title: Text('logout', style: TextStyle(height: 5, fontSize: 20))),
        ],
      ),
    );
  }
}

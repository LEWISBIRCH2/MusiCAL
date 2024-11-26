import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './themes/theme_provider.dart';
import './themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> toggleDarkMode(selectedMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('mode', selectedMode);

    final colScheme = prefs.getString('mode');

    if (colScheme == 'lightMode') {
      Provider.of<ThemeProvider>(context, listen: false)
          .toggleTheme('lightMode');
    } else if (colScheme == 'darkMode') {
      Provider.of<ThemeProvider>(context, listen: false)
          .toggleTheme('darkMode');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Provider.of<ThemeProvider>(context).themeData == darkMode;

    final localColourScheme = isDarkMode ? 'lightMode' : 'darkMode';

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
              onTap: () async {
                await toggleDarkMode(localColourScheme);
              }),
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

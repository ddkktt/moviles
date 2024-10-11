import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:entregafinal/themes/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Set to: ${themeProvider.inDarkMode ? 'Light' : 'Dark'} mode"),
        Switch(
          value: themeProvider.inDarkMode,
          activeColor: Theme.of(context).colorScheme.secondary,
          onChanged: (bool value) {
            // This is called when the user toggles the switch.
            setState(() {
              themeProvider.toggleTheme();
            });
          },
        )
      ],
    );
  }
}
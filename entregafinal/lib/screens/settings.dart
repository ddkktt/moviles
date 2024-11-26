import 'package:entregafinal/auth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final themeProvider = Provider.of<ThemeProvider>(context); // listen: true
  String? email = FirebaseAuth.instance.currentUser?.email;
  final bool isAdmin = Provider.of<RolesProvider>(context).isAdmin(email); // para admin

  // Construcción de la lista de widgets
  List<Widget> buildChildren() {
    List<Widget> widgets = [
      Text("Set to: ${themeProvider.inDarkMode ? 'Light' : 'Dark'} mode"),
      Switch(
        value: themeProvider.inDarkMode,
        activeColor: Theme.of(context).colorScheme.secondary,
        onChanged: (bool value) {
          // Cambia el tema directamente
          themeProvider.toggleTheme();
        },
      ),
    ];

    if (isAdmin) {
      widgets.add(
        ElevatedButton(
          onPressed: _getToken,
          child: const Text("Get Token"),
        ),
      );
    }

    return widgets;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: buildChildren(),
  );
}
}

void _getToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("Token conseguido y copiado al portapapeles: $fcmToken");
  await Clipboard.setData(ClipboardData(text: "$fcmToken"));
}

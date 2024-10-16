import 'package:entregafinal/data/data_provider.dart';
import 'package:entregafinal/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:entregafinal/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
        )
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widget Class',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const LoginScreen(),
    );
  }
}

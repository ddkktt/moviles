import 'package:entregafinal/auth/auth_gate.dart';
import 'package:entregafinal/auth/auth_provider.dart';
import 'package:entregafinal/bloc/shipments_bloc.dart';
import 'package:entregafinal/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:entregafinal/themes/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RolesProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Title del mensaje: ${message.notification?.title}");
  print("Body del mensaje: ${message.notification?.body}");
  print("ID del mensaje: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene el tema actual del ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);
    debugPrint("here");

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShipmentsBloc()..add(LoadShipmentsCounter()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeProvider.themeData, // Usa el tema dinámico
        home: const AuthGate(),
      ),
    );
  }
}

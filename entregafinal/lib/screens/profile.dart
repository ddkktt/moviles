import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // covered in material app for style purposes
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,

        // brightness and colors definition.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(02, 21, 38, 90),
          // ···
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(03, 52, 110, 100),
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(110, 172, 218, 90),
          ),
          // ···
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Perfil"),
        ),
        body: Column(     
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              iconSize: 180.0,
              onPressed: () {
                Alert(
                        context: context,
                        desc:
                            "Aqui se va a permitir cambiar la foto del usuario")
                    .show();
              },
              icon: const Icon(Icons.account_circle)
            ),
            const Center(
              child: Text(
                "Ulises Tejeda Chávez ",
                style: TextStyle(
                  fontSize: 40,
                
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

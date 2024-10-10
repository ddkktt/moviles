import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // covered in material app for style purposes
    return 
    Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
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
    );
  }
}

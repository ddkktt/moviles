import 'package:entregafinal/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';


class AuthGate extends StatelessWidget {
 const AuthGate({super.key});

 @override
 Widget build(BuildContext context) {
   return StreamBuilder<User?>(
     stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context, snapshot) {
       if (!snapshot.hasData) {
         return SignInScreen(
           headerMaxExtent: 270,
           providers: [
             EmailAuthProvider(),
           ],
           headerBuilder: (context, constraints, shrinkOffset) {
             return Padding(
               padding: const EdgeInsets.all(20),
               child: AspectRatio(
                 aspectRatio: 1,
                 child: Column (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:  CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Driver App",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 30,
                      )
                    ),
                    Image.asset(
                      'assets/images/photo_1.jpg',
                      height: 150,
                    ),
                  ],          
                 ),
               ),
             );
           },
           subtitleBuilder: (context, action) {
             return Padding(
               padding: const EdgeInsets.symmetric(vertical: 8.0),
               child: action == AuthAction.signIn
                   ? Text(
                    'Welcome to Driver App, please sign in!',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      )
                   )
                   : Text('Welcome to Driver App, please sign up!',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      )
                    ),
             );
           },
           footerBuilder: (context, action) {
             return Padding(
               padding: const EdgeInsets.only(top: 16),
               child: Text(
                 'By signing in, you agree to our terms and conditions.',
                 style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                 ),
               ),
             );
           },
           sideBuilder: (context, shrinkOffset) {
             return Padding(
               padding: const EdgeInsets.all(20),
               child: AspectRatio(
                 aspectRatio: 1,
                 child: Image.asset('assets/images/photo_1.jpg'),
               ),
             );
           },
         );
       }
       return const MainScreen();
     },
   );
 }
}
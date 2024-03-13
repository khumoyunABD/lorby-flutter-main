// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lorby/screens/home.dart';
// import 'package:lorby/screens/login.dart';
// import 'package:lorby/screens/register_or_login.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           //user logged in
//           if (snapshot.hasData) {
//             return const HomeScreen();
//           }

//           // user not logged in
//           else {
//             return const LoginScreen();
//           }
//         },
//       ),
//     );
//   }
// }

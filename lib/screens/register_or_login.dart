// import 'package:flutter/material.dart';
// import 'package:lorby/screens/login.dart';
// import 'package:lorby/screens/register.dart';

// class RegisterOrLoginScreen extends StatefulWidget {
//   const RegisterOrLoginScreen({super.key});

//   @override
//   State<RegisterOrLoginScreen> createState() => _RegisterOrLoginScreenState();
// }

// class _RegisterOrLoginScreenState extends State<RegisterOrLoginScreen> {
//   //show login page first
//   bool showLoginScreen = true;

//   // switching between login and register pages
//   void switchPages() {
//     setState(() {
//       showLoginScreen = !showLoginScreen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showLoginScreen) {
//       return LoginScreen(onTap: switchPages);
//     } else {
//       return RegisterScreen(
//         onTap: switchPages,
//       );
//     }
//   }
// }

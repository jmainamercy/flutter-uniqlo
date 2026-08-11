import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniqlo/model/cart.dart';
import 'package:uniqlo/screens/home_screen.dart';
import 'package:uniqlo/screens/login_screen.dart';
import 'package:uniqlo/screens/signup_screen.dart';
import 'package:uniqlo/screens/forgotpass_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Mulish"),
      home: ChangeNotifierProvider(
        create: (context) => CartModel(),
        child: const HomeScreen(),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot': (context) => const ForgotpassScreen(),
      },
    );
  }
}

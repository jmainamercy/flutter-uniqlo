import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniqlo/model/cart.dart';
import 'package:uniqlo/screens/home_screen.dart';
import 'package:uniqlo/screens/login_screen.dart';
import 'package:uniqlo/screens/redirect.dart';
import 'package:uniqlo/screens/signup_screen.dart';
import 'package:uniqlo/screens/forgotpass_screen.dart';
import 'package:uniqlo/viewmodel/view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => AuthViewmodel()),
      ],
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
      home: const Redirect(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot': (context) => const ForgotpassScreen(),
      },
    );
  }
}

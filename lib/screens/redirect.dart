import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniqlo/screens/home_screen.dart';
import 'package:uniqlo/screens/login_screen.dart';
import 'package:uniqlo/viewmodel/view_model.dart';

class Redirect extends StatelessWidget {
  const Redirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewmodel>(
      builder: (_, authViewModel, __) {
        var status = authViewModel.authStatus;
        switch (status) {
          case AuthStatus.authenticated:
            return const HomeScreen();
          case AuthStatus.unauthenticated:
            return const LoginScreen();
          case AuthStatus.authenticating:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
        }
      },
    );
  }
}

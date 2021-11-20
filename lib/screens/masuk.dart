import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donasi_mobile/screens/providers/auth.dart';
import 'package:donasi_mobile/screens/providers/todo.dart';

import 'package:donasi_mobile/screens/views/loading.dart';
import 'package:donasi_mobile/screens/views/login.dart';
import 'package:donasi_mobile/screens/views/register.dart';
import 'package:donasi_mobile/screens/views/password_reset.dart';
import 'package:donasi_mobile/screens/views/todos.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
//       builder: (context) => AuthProvider(),
      create: (context) => AuthProvider(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Router(),
          '/login': (context) => LogIn(),
          '/register': (context) => Register(),
          '/password-reset': (context) => PasswordReset(),
        },
      ),
    ),
  );
}

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Consumer<AuthProvider>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.Uninitialized:
            return Loading();
          case Status.Unauthenticated:
            return LogIn();
          case Status.Authenticated:
            return ChangeNotifierProvider(
              // builder: (context) => TodoProvider(authProvider),
              create: (context) => TodoProvider(authProvider),
              child: Todos(),
            );
          default:
            return LogIn();
        }
      },
    );
  }
}
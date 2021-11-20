import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:donasi_mobile/Constants/constants.dart';
import 'package:donasi_mobile/screens/splash_screen.dart';
import 'package:donasi_mobile/screens/main_ui.dart';
import 'package:donasi_mobile/screens/new_ui.dart';

import 'package:donasi_mobile/providers/auth.dart';
import 'package:donasi_mobile/providers/todo.dart';

import 'package:donasi_mobile/views/loading.dart';
import 'package:donasi_mobile/views/login.dart';
import 'package:donasi_mobile/views/register.dart';
import 'package:donasi_mobile/views/password_reset.dart';
import 'package:donasi_mobile/views/todos.dart';
// void main() => runApp(Router());
void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => AuthProvider(),
      child: MaterialApp(
              debugShowCheckedModeBanner: false,

        initialRoute: '/',
        routes: {
          '/': (context) => MyApp(),
          '/masuk': (context) => Router(),
          '/login': (context) => LogIn(),
          '/register': (context) => Register(),
          '/password-reset': (context) => PasswordReset(),
          MAIN_UI : (BuildContext context) => DefaultAppBarDemo(),
        SPLASH_SCREEN: (BuildContext context) => AnimatedSplashScreen(),
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
              builder: (context) => TodoProvider(authProvider),
              child: Todos(),
            );
          default:
            // return AnimatedSplashScreen();
            // return Loading();
                        return LogIn();

        }
      },
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Classified App Clone',
      theme: ThemeData(primaryColor: Colors.green[200]),
      routes: <String, WidgetBuilder>{
        MAIN_UI: (BuildContext context) => DefaultAppBarDemo(),
        SPLASH_SCREEN: (BuildContext context) => AnimatedSplashScreen(),


      },
      initialRoute: SPLASH_SCREEN,

    );
     
  }
}


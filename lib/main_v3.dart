import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:donasi_mobile/Constants/constants.dart';
import 'package:donasi_mobile/screens/splash_screen.dart';
import 'package:donasi_mobile/screens/main_ui.dart';
import 'package:donasi_mobile/screens/new_ui.dart';



void main() => runApp(MyApp());

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
      theme: ThemeData(primaryColor: Colors.orange[200]),
      routes: <String, WidgetBuilder>{
        MAIN_UI: (BuildContext context) => DefaultAppBarDemo(),
        SPLASH_SCREEN: (BuildContext context) => AnimatedSplashScreen(),


      },
      initialRoute: SPLASH_SCREEN,
    );
  }
}

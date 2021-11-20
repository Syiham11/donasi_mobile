import 'package:flutter/material.dart' hide Router;
// import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:donasi_mobile/views/register.dart';
import 'package:donasi_mobile/screens/background.dart';
import 'package:donasi_mobile/screens/rounded_button.dart';
// import 'package:donasi_mobile/screens/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:donasi_mobile/main_v2.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Selamat Datang Di Amalku",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
              Image.asset(
              "assets/icons/pilih.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      // return LoginScreen();
                                      return Router();

                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Register();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

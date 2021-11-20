import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'jamaah_cek.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class ColorPalette {
static const primaryColor       = Color(0xFFFFEB3B);
static const primaryDarkColor   = Color(0xFFD4E157);
static const underlineTextField = Color(0xFF000000);
static const hintColor          = Color(0xFF000000);
}

class Post {
  final String tambahan;
  final int perbulan;
  final String email;
  final String title;
  final String body;
  final String notlp;
 
  Post({this.perbulan, this.tambahan, this.title, this.body, this.email, this.notlp});
 
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      perbulan: json['perbulan'],
      tambahan: json['tambahan'],
      title: json['title'],
      body: json['body'],
      email: json['email'],
      notlp: json['notlp'],
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["perbulan"] = perbulan;
    map["tambahan"] = tambahan;
    map["email"] = email;
    map["notlp"] = notlp;
    map["title"] = title;
    map["body"] = body;
 
    return map;
  }
}

Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}
class MyApp extends StatelessWidget {
  final Future<Post> post;
   double firstFieldValue = 0;
  double secondFieldValue = 0;
  double thirdFieldValue = 0;

  MyApp({Key key, this.post});
  static final CREATE_POST_URL = 'https://ori.iumrah.co.id/api/mobile/cek_jamaah/index.php';
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();
  TextEditingController perbulanControler = new TextEditingController();
  TextEditingController tambahanControler = new TextEditingController();
  TextEditingController emailControler = new TextEditingController();
  TextEditingController notlpControler = new TextEditingController();
 
 

  @override
  Widget build(BuildContext context) {
    // print(perbulanControler+tambahanControler);
    return Scaffold(
      body: Container(
        // color: ColorPalette.primaryColor,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  _iconLogin(),
                  _titleDescription(),
                  _textField(),
                  _buildButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconLogin() {
    return Image.asset(
              "assets/images/zaka.png",
              width: 150.0,
              height: 150.0,
            );
  }

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8.0),
        ),
        Text(
          "Zakat Penghasilan",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
        Text(
          "Zakat adalah sodaqah yg bersifat wajib dari alquran dan sunnah, yg bersifat menggugurkan dosa atas kewajiban yg harus dilakukan. Nisob dan waktu telah ditentukan",
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _textField() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        TextFormField(
           controller: perbulanControler,
           
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField, 
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            hintText: "Pendapatan Perbulan",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
            
          ),
          style: TextStyle(color: Colors.black),
          autofocus: false,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        TextFormField(
           controller: tambahanControler,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField, 
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            hintText: "Pendapatan Tambahan (Jika Ada)",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.black),
          autofocus: false,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        TextFormField(
           controller: titleControler,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField, 
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            hintText: "Jumlah zakat",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.black),
          autofocus: false,
        ),
        
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        TextFormField(
           controller: bodyControler,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField, 
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            hintText: "Pezakat/muzaki",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.black),
          // obscureText: true,
          autofocus: false,
        ),
         Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        TextFormField(
           controller: emailControler,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField, 
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            hintText: "Email Pezakat",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.black),
          // obscureText: true,
          autofocus: false,
        ),
         Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        TextFormField(
           controller: notlpControler,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorPalette.underlineTextField, 
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            hintText: "No.Telepon Pezakat",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.black),
          // obscureText: true,
          autofocus: false,
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        InkWell(
          onTap: () async {},
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            width: double.infinity,
            
            child: Text(
              'LANJUTKAN',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              
            ),
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(30.0),
              
            ),
            
          ),
        ),
        
        //  new RaisedButton(
        //           onPressed: () async {
        //             Post newPost = new Post(
        //                 userId: "123", id: 0, title: titleControler.text, body: bodyControler.text);
        //             Post p = await createPost(CREATE_POST_URL,
        //                 body: newPost.toMap());
        //             print(p.title);
        //           },
        //           child: const Text("Create"),
                  
        //         )
        // Padding(
        //   padding: EdgeInsets.only(top: 16.0),
        // ),
         
        // FlatButton(
        //   child: Text(
        //     'Register',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   onPressed: () {
        //     // Navigator.pushNamed(context, RegisterPage.routeName);
        //   },
        // ),
      ],
    );
  }
}
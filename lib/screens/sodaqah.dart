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
  final String userId;
  final int id;
  final String title;
  final String body;
 final jumlah;
 final penerima;
 final notlp;

  Post({this.userId, this.id, this.title, this.body, this.penerima, this.jumlah, this.notlp});
 
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      penerima: json['penerima'],
      jumlah: json['jumlah'],
      notlp: json['notlp'],
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = userId;
    map["title"] = title;
    map["body"] = body;
    map["penerima"] = penerima;
    map["jumlah"] = jumlah;
    map["notlp"] = notlp;
 
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
class Sodaqah extends StatelessWidget {
  final Future<Post> post;
 
  Sodaqah({Key key, this.post});
  static final CREATE_POST_URL = 'https://ori.iumrah.co.id/api/mobile/cek_jamaah/index.php';
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();
  TextEditingController jumlahControler = new TextEditingController();
  TextEditingController penerimaControler = new TextEditingController();
  TextEditingController notlpControler = new TextEditingController();
 
 

  @override
  Widget build(BuildContext context) {
    
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
              "assets/images/so.png",
              width: 150.0,
              height: 150.0,
            );
  }

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        Text(
          "Sodaqah",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
        Text(
          "Sodaqah adalah pemberian yg tidak wajib atau bersifat sunnah yg mendatang kan pahala serta kasih sayang Allah kpd pelakunya. Besarnya tdk ditentukan dan waktunya juga tdk ditentukan",
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
           controller: penerimaControler,
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
            hintText: "Pilih Penerima Sodaqah",
            hintStyle: TextStyle(color: ColorPalette.hintColor),
          ),
          style: TextStyle(color: Colors.black),
          autofocus: false,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        TextFormField(
           controller: jumlahControler,
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
            hintText: "Jumlah Sodaqah",
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
            hintText: "Nama Pemberi Sodaqah",
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
            hintText: "Email Pemberi Sodaqah",
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
            hintText: "No.Telepon Pemberi Sodaqah",
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
          onTap: () async {
                    Post newPost = new Post(
                        userId: "123", id: 0, title: titleControler.text, body: bodyControler.text);
                    Post p = await createPost(CREATE_POST_URL,
                        body: newPost.toMap());
                    // print(p.title);
                    if(p.title != 'null'){
// Navigator.of(context).push(MaterialPageRoute(builder: (context) => Jamaah("${p.title}")));
                    }else{
                      print('gagal');
                 Alert(
      context: context,
      type: AlertType.error,
      title: "Mohon Maaf",
      desc: "Jamaah Tidak Dapat Ditemukan, Mohon Cek Kembali ID Jamaah Serta Tanggal Lahir Anda",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
                    }
            

                  },
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
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'icon_badge.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_html/flutter_html.dart';
import 'package:percent_indicator/percent_indicator.dart';
// import 'package:flutter_html/html_parser.dart';
// import 'package:flutter_html/style.dart';
// import 'package:donasi_mobile/screens/form.dart';

class Formcek extends StatefulWidget {
  @override
  _FormcekState createState() => new _FormcekState();
}

class _FormcekState extends State<Formcek> {
  // List places;
  List places;

  double _height;
  double _width;
  Future<String> getData() async {
    var response = await http.get(
        // Uri.encodeFull("https://ori.iumrah.co.id/api/mobile/paket/detail/index.php?p1=${widget.recordName}"),
        Uri.encodeFull("http://139.59.127.33/api/v1/infaq/detail/18"),
        headers: {"Accept": "application/json"});

    setState(() {
      places = json.decode(response.body);
    });

    return "Success";
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    if (places == null) {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text("Paket Umrah"),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'loading',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 24),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[300]),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(children: <Widget>[
        // this is the TabBar
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            primary: false,
            itemCount: places == null ? 0 : places.length,
            itemBuilder: (BuildContext context, int index) {
              Map place = places[index];

              return Padding(
                padding: EdgeInsets.only(right: 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "http://139.59.127.33/banner/${place["banner"]}",
                    height: 150,
                    width: MediaQuery.of(context).size.width - 40,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 20),

        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            "${places[0]["title"]}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            maxLines: 2,
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 3),

        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            "Pengelola ${places[0]["name"]}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Colors.blue[300],
            ),
            maxLines: 2,
            textAlign: TextAlign.left,
          ),
        ),

        SizedBox(height: 5),

        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: LinearPercentIndicator(
            width: _width / 1.20,
            lineHeight: 10.0,
            percent: 0.9,
            center: Text("Dana Terkumpul 90%",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                )),
            progressColor: Colors.green,
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'images/ustd.png',
                height: _height / 20,
                width: _width / 20,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: _width / 2.50,
              child: Text(
                "Donatur ${places[0]["donatur"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'images/target.png',
                height: _height / 17,
                width: _width / 17,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Target ${places[0]["target"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
      ]),
    );
  }
}

import 'package:flutter/material.dart';

import '../screens/details.dart';
import 'package:percent_indicator/percent_indicator.dart';

class VerticalPlaceBeranda extends StatelessWidget {
  final Map place;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  double _height;
  double _width;
  VerticalPlaceBeranda({this.place});

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        child: Container(
          height: _height / 2.20,
          width: 100,
//                    color: Colors.red,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "http://139.59.127.33/banner/${place["banner"]}",
                    height: 178,
                    width: _width / 1.10,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  height: _height / 7.30,
                  width: MediaQuery.of(context).size.width - 40,
                  child: ListView(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${place["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "pengelola ${place["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.blue[300],
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      new LinearPercentIndicator(
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
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'images/ustd.png',
                            height: _height / 20,
                            width: _width / 20,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: _width / 2.50,
                            child: Text(
                              "Donatur ${place["donatur"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(width: 4),
                          Image.asset(
                            'images/target.png',
                            height: _height / 17,
                            width: _width / 17,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Target ${place["target"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Details();
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details("${place["id"]}")));
              },
            ),
          );
        },
      ),
    );
  }
}

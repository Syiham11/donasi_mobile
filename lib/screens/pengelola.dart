import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:donasi_mobile/Model/categoryModel.dart';
import 'package:donasi_mobile/Model/productModel.dart';
import 'package:donasi_mobile/screens/custom_shape.dart';
import 'package:donasi_mobile/screens/mainui_customcard.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:donasi_mobile/screens/choose.dart';


class Pengelola extends StatefulWidget {
  @override
  _Beranda createState() => _Beranda();
 
 
    
}

class _Beranda extends State<Pengelola>{
  var scaffoldKey = GlobalKey<ScaffoldState>();


  double _height;
  double _width;
  List places;
Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://139.59.127.33//api/v1/pengelola"),
        headers: {"Accept": "application/json"});
     setState(() {
      places = json.decode(response.body);
    });
    
    return "Success";
  }
  @override
  void initState() {
   
    super.initState();
     getData();


  }

   

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    if (places == null) {
      return Scaffold(
      appBar: AppBar(
        title: Text("Welcome To App Donasi"),
                backgroundColor: Colors.greenAccent,

      ),
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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    ),
      );
    }
    return Scaffold(
     
      body: Container(
        height: _height,
        width: _width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
               

           Padding(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: places == null ? 0 : places.length,
              itemBuilder: (BuildContext context, int index) {
                Map place = places[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom:15.0),
                  child: InkWell(
                    child: Container(
                      height: 70,
//                    color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              "http://139.59.127.33//foto_bangunan/${place["foto_bangunan"]}",
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(width: 15),

                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width-130,
                            child: ListView(
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${place["nama_mitra"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                ),

                                SizedBox(height: 3),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 13,
                                      color: Colors.blueGrey[300],
                                    ),

                                    SizedBox(width: 3),

                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${place["alamat_mitra"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.blueGrey[300],
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
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
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            // return Details();
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Opacity(
            opacity: 0.75,
            child: Container(
              height: _height / 6,
              padding: EdgeInsets.only(top: _height / 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[200], Colors.greenAccent],
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.black,
                  ),
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                title: Text("FlutterDevs"),
                subtitle: Text("flutterDevs@aeologic.com",style: TextStyle(fontSize: 13),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders & Payments"),
          ),
        ],
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
          Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _height / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[200], Colors.greenAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _height / 3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[200], Colors.greenAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.25,
          child: ClipPath(
            clipper: CustomShapeClipper3(),
            child: Container(
              height: _height / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[200], Colors.greenAccent],
                ),
              ),
            ),
          ),
        ),
         
        Container(
                     margin: EdgeInsets.only(left: 30, right: 30, top: _height / 7.75),

           height: 150.0,
  width: _width,
        child: Carousel(
    images: [
      NetworkImage('https://cdn.iumrah.co.id/img/99.jpg'),
      NetworkImage('https://cdn.iumrah.co.id/img/78.jpg'),
      NetworkImage('https://cdn.iumrah.co.id/img/jack.jpg')

    ],
    dotSize: 4.0,
    dotSpacing: 15.0,
    dotColor: Colors.greenAccent,
    indicatorBgPadding: 5.0,
    dotBgColor: Colors.white.withOpacity(0.1),
    borderRadius: true,
  )
         ),
         Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: _height / 2.93),
          child: Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 8,
            child: Container(
          
              padding: EdgeInsets.all(10),
               child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
              Image.asset(
                      'images/program.png',
                    height: _height / 15,
                    width: _width / 15,
                  ),
            
          ],
        ),
        Column(
           
          children: [
            // Icon(Icons.kitchen, color: Colors.green[500]),
            Text('Program Tersedia', style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          )),
          Text('1000', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15, color: Colors.green.withOpacity(0.6)
          ), ),
            
          ],
        ),
        SizedBox(
                  width: 5,
                ),
         Column(
          children: [
 Image.asset(
                      'images/donasi.png',
                    height: _height / 15,
                    width: _width / 15,
                  ),           
          ],
        ),
        Column(
          children: [
            // Icon(Icons.timer, color: Colors.green[500]),
            Text('Donasi Terkumpul', style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          )),
          Text('1000', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15, color: Colors.green.withOpacity(0.6)
          ), ),
          ],
        ),
      ]
               ),
            
            
            ),
        
          ),

         ),
        
        Container(
          //color: Colors.blue,
            margin: EdgeInsets.only(left: 20, right: 20, top: _height / 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            
                Flexible(
                  child: Container(
                    height: _height / 20,
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        
                        SizedBox(width: 10,),
                        Flexible(
                            child: Text('Pengelola',
                                style: TextStyle(
                                    color: Colors.white, fontSize: _height/40, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                // overflow: TextOverflow.fade,
                                softWrap: false)),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: GestureDetector(
                   onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Pilih();
                // return Register();
                // return Router();
                // return LogIn();
                // return ProfileListItem();



                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details("${place["id"]}")));

              },
            ),
          );
        },
                      child: Icon(Icons.account_circle, color: Colors.black,size: _height/30,)),
                  ),
              ],
            )),


      ],
    );
  }

}

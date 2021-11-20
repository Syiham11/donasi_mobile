import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:donasi_mobile/Model/categoryModel.dart';
import 'package:donasi_mobile/Model/productModel.dart';
import 'package:donasi_mobile/screens/custom_shape.dart';
import 'package:donasi_mobile/screens/mainui_customcard.dart';
import 'package:donasi_mobile/screens/choose.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import '../screens/details.dart';
import 'package:donasi_mobile/widgets/vertical_place_beranda.dart';
// import 'package:donasi_mobile/screens/masuk.dart';
import 'package:donasi_mobile/views/login.dart';
import 'package:donasi_mobile/main_v2.dart';
// import 'package:donasi_mobile/views/prof.dart';


class Beranda extends StatefulWidget {
  @override
  _Beranda createState() => _Beranda();
 
 
    
}

class _Beranda extends State<Beranda>{
  var scaffoldKey = GlobalKey<ScaffoldState>();


  bool isExpanded = false;
  List<Category> categoryItems;
  List<Product> trendingListItems;
  List<Product> recommendListItems;
  List<Product> dealsListItems;
  double _height;
  double _width;
  
      List places;
      List laporan;
Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://139.59.127.33//api/v1/infaq/beranda"),
        headers: {"Accept": "application/json"});
     setState(() {
      places = json.decode(response.body);
    });
    
    return "Success";
  }
Future<String> getLaporan() async {
    var response = await http.get(
        Uri.encodeFull("http://139.59.127.33//api/v1/laporan/beranda"),
        headers: {"Accept": "application/json"});
     setState(() {
      laporan = json.decode(response.body);
    });
    
    return "Success";
  }
  @override
  void initState() {
    super.initState();
     getData();
     getLaporan();
   

  }

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

      if (places == null) {
      return Scaffold(
      appBar: AppBar(
        title: Text("Welcome To App Donasi"),
        backgroundColor: Colors.green[300],

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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
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
              clipShape(), // gabung warna & slider
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Penerima Manfaat',
                        style: TextStyle(
                             fontSize: 16)),
                    GestureDetector(
                        onTap: _expand, // show list penerima manfaat
                        child: Text(
                          isExpanded ? "Show less" : "Show all",
                          style: TextStyle(
                              color: Colors.green[200],
                              ),
                        )),
                    //IconButton(icon: isExpanded? Icon(Icons.arrow_drop_up, color: Colors.orange[200],) : Icon(Icons.arrow_drop_down, color: Colors.orange[200],), onPressed: _expand)
                  ],
                ),
              ),
              expandList(), // list sedikit penerima manfaat
              Divider(),
              /////////////////// gabung laporan terbaru
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Laporan Terbaru",
                        style: TextStyle(
                            fontSize: 16)),
                    GestureDetector(
                        onTap: () {
                         // Navigator.of(context).pushNamed(TRENDING_UI);
                          print('Showing all');
                        },
                        child: Text(
                          'Show all',
                          style: TextStyle(
                              color: Colors.green[300],
                             ),
                        )
                        )
                  ],
                ),
              ),
               Container(
            padding: EdgeInsets.only(top: 10, left: 20),
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: laporan == null ? 0 : laporan.length,
              itemBuilder: (BuildContext context, int index) {

                Map place = laporan.reversed.toList()[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    
                    child: Container(
                      height: 250,
                      width: 200,
                      
//                      color: Colors.green,
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "http://139.59.127.33//banner/${place["image"]}",
                              height: 178,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${place["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                          ),

                          SizedBox(height: 3),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Pengelola ${place["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.green[300],
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
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
              ////////////end laporan terbaru
              //////// gabung donasi infaq header
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
               
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Donasi Infaq",
                        style: TextStyle(
                             fontSize: 16)),
                    GestureDetector(
                        onTap: () {
                          //Navigator.of(context).pushNamed(DEALS_UI);
                          print('Showing all');
                        },
                        child: Text(
                          'Show all',
                          style: TextStyle(
                              color: Colors.green[300],
                              ),
                        ))
                  ],
                ),
              ),
///////////////////////// list donasi infaq
                      buildVerticalList(),

            ],
          ),
        ),
      ),
    );
  }
////////////////////////////////end donasi infaq
//////////////////////////// warna & slider 
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
                  colors: [Colors.green[200], Colors.green[200]],
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
          margin: EdgeInsets.only(left: 30, right: 30, top: _height / 2.90),
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
                            child: Text('Amalku',
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
//////////////// end slider & warna atas


//////////////////////////// penerima manfaat
  Widget expandList() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: AnimatedCrossFade(
        firstChild: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
              //        Navigator.of(context)
              // .push(MaterialPageRoute(builder: (context) => PaketUmrah()));
                  },
                  child: Image.asset(
                    'images/ustd.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Gaji Usatad",
                    style: TextStyle( fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
              //          Navigator.of(context)
              // .push(MaterialPageRoute(builder: (context) => PaketHaji()));
                    },
                    child: Image.asset(
                    'images/bs.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Mesjid",
                    style: TextStyle(fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
              //          Navigator.of(context)
              // .push(MaterialPageRoute(builder: (context) => PaketWisata()));
                    },
                    child: Image.asset(
                      'images/al.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Wakaf Al Quran",
                    style: TextStyle(fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(FURNITURE_ITEM_LIST);
                      print('Routing to Furniture item list');
                    },
                    child: Image.asset(
                      'assets/images/hotel.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Rumah Sakit",
                    style: TextStyle(fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    //Navigator.of(context).pushNamed(CARS_ITEM_LIST);
                    print('Routing to Cars item list');
                  },
                  child: Image.asset(
                      'images/yat.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Yatim Piatu",
                    style: TextStyle( fontSize: 11),
                    textAlign: TextAlign.center,

                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    //Navigator.of(context).pushNamed(BIKES_ITEM_LIST);
                    print('Routing to Bikes item list');
                  },
                  child: Image.asset(
                    'images/pia.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Pakir Miskin",
                    style: TextStyle( fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                   onTap: () {
              //          Navigator.of(context)
              // .push(MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: Image.asset(
                      'images/mad.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Pesantren",
                    style: TextStyle( fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    //Navigator.of(context).pushNamed(PETS_ITEM_LIST);
                    print('Routing to Pets item list');
                  },
                  child: Image.asset(
                    'images/sem.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Paket Sembako",
                    style: TextStyle(fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
        secondChild: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(ELECTRONICS_ITEM_LIST);
                    print('Routing to Electronics item list');
                  },
                  child: Image.asset(
                    'assets/images/gadget.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Electronics",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(PROPERTIES_ITEM_LIST);
                      print('Routing to Properties item list');
                    },
                    child: Image.asset(
                      'assets/images/house.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Properties",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(JOBS_ITEM_LIST);
                      print('Routing to Jobs item list');
                    },
                    child: Image.asset(
                      'assets/images/job.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Jobs",
                    style: TextStyle( fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(FURNITURE_ITEM_LIST);
                      print('Routing to Furniture item list');
                    },
                    child: Image.asset(
                      'assets/images/sofa.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Furniture",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    //Navigator.of(context).pushNamed(CARS_ITEM_LIST);
                    print('Routing to Cars item list');
                  },
                  child: Image.asset(
                    'assets/images/car.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Cars",
                    style: TextStyle( fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    //Navigator.of(context).pushNamed(BIKES_ITEM_LIST);
                    print('Routing to Bikes item list');
                  },
                  child: Image.asset(
                    'assets/images/bike.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Bikes",
                    style: TextStyle( fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(MOBILES_ITEM_LIST);
                      print('Routing to Mobiles item list');
                    },
                    child: Image.asset(
                      'assets/images/smartphone.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Mobiles",
                    style: TextStyle( fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    //Navigator.of(context).pushNamed(PETS_ITEM_LIST);
                    print('Routing to Pets item list');
                  },
                  child: Image.asset(
                    'assets/images/pet.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Pets",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    //Navigator.of(context).pushNamed(FASHION_ITEM_LIST);
                    print('Routing to Fashion item list');
                  },
                  child: Image.asset(
                    'assets/images/dress.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Fashion",
                    style: TextStyle( fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
        crossFadeState:
        isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      ),
    );
  }
//////////////////////////////////////////////end penerima Manfaat
buildVerticalList() {
    return Padding(
                        padding: EdgeInsets.all(7),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return VerticalPlaceBeranda(place: place);
        },
      ),
    );
  }
}

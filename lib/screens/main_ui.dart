// import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// import 'package:donasi_mobile/Model/categoryModel.dart';
// import 'package:donasi_mobile/Model/productModel.dart';
// // import 'package:donasi_mobile/screens/custom_shape.dart';
// // import 'package:donasi_mobile/screens/mainui_customcard.dart';
// import '../screens/beranda.dart';
// import '../screens/zakat.dart';
// import '../screens/home.dart';
// import '../screens/sodaqah.dart';
// import '../screens/pengelola.dart';
// // import 'package:google_nav_bar/google_nav_bar.dart';
// // import 'package:line_icons/line_icons.dart';
// import 'package:ff_navigation_bar/ff_navigation_bar.dart';

// class MainUI extends StatefulWidget {
//   @override
//   _MainUIState createState() => _MainUIState();

// }

// class _MainUIState extends State<MainUI> {
//   var scaffoldKey = GlobalKey<ScaffoldState>();


//   bool isExpanded = false;
//   List<Category> categoryItems;
//   List<Product> trendingListItems;
//   List<Product> recommendListItems;
//   List<Product> dealsListItems;
//   double _height;
//   double _width;
//   @override
//   void initState() {
   
//     super.initState();
   
//   }



//   int _selectedIndex = 0;
//   static const double IconSize = 200; 
//   static List<Widget> _widgetOptions = <Widget>[
//     Beranda(),
//     MyApp(),
//     Home(),
//     Sodaqah(),
//     Pengelola()
//     // BusinessPage(),
//     // SchoolPage(),
//   ];


//   void _expand() {
//     setState(() {
//       isExpanded ? isExpanded = false : isExpanded = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     _height = MediaQuery.of(context).size.height;
//     _width = MediaQuery.of(context).size.width;
//     return Scaffold(
       
//      body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
       
//       bottomNavigationBar: FFNavigationBar(
//         theme: FFNavigationBarTheme(
//           barBackgroundColor: Colors.white,
//           selectedItemBorderColor: Colors.white,
//           selectedItemBackgroundColor: Colors.green,
//           selectedItemIconColor: Colors.white,
//           selectedItemLabelColor: Colors.black,
//         ),
//         selectedIndex: _selectedIndex,
//         onSelectTab: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         items: [
//           FFNavigationBarItem(
//             iconData: Icons.home,
//             label: 'Beranda',
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.people,
//             // iconData: new Image.asset('assets/images/kaaba.png'), ImageIcon(AssetImage("assets/images/kaaba.png"),),
//             label: 'Zakat',
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.attach_money,
//             label: 'Infaq',
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.note,
//             label: 'Sodaqah',
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.settings,
//             label: 'Pengelola',
//           ),
//         ],
//       ),
//     );
  

  
//   }
// }

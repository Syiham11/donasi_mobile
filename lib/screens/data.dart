/*
 *  Copyright 2020 chaobinwu89@gmail.com
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'donasi_mobile/screens/badge.dart';
import 'package:donasi_mobile/screens/badge.dart';
import 'package:donasi_mobile/screens/choice_value.dart';
import 'package:donasi_mobile/screens/named_color.dart';

/// tab config used in example
class Data {
  static const gradients = [
    null,
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue, Colors.redAccent, Colors.green, Colors.blue],
      tileMode: TileMode.repeated,
    ),
    LinearGradient(
      begin: Alignment.center,
      end: Alignment(-1, 1),
      colors: [Colors.redAccent, Colors.green, Colors.blue],
      tileMode: TileMode.repeated,
    ),
    RadialGradient(
      center: const Alignment(0, 0), // near the top right
      radius: 5,
      colors: [Colors.green, Colors.blue, Colors.redAccent],
    )
  ];

  static const namedColors = [
    // NamedColor(Color(0xFF64B5F6), 'Blue'), 0xFF4CAF50 0xFF43A047
        NamedColor(Color(0xFF4CAF50), 'Blue'),

    NamedColor(Color(0xFFf44336), 'Read'),
    NamedColor(Color(0xFF673AB7), 'Purple'),
    NamedColor(Color(0xFF009688), 'Green'),
    NamedColor(Color(0xFFFFC107), 'Yellow'),
    NamedColor(Color(0xFF607D8B), 'Grey'),
  ];
  static const badges = [
    null,
    Badge('1'),
    Badge('hot',
        badgeColor: Colors.orange, padding: EdgeInsets.only(left: 7, right: 7)),
    Badge('99+', borderRadius: 2)
  ];

  static const curves = [
    ChoiceValue<Curve>(
      title: 'Curves.bounceInOut',
      label: 'The curve bounceInOut is used',
      value: Curves.bounceInOut,
    ),
    ChoiceValue<Curve>(
      title: 'Curves.decelerate',
      value: Curves.decelerate,
      label: 'The curve decelerate is used',
    ),
    ChoiceValue<Curve>(
      title: 'Curves.easeInOut',
      value: Curves.easeInOut,
      label: 'The curve easeInOut is used',
    ),
    ChoiceValue<Curve>(
      title: 'Curves.fastOutSlowIn',
      value: Curves.fastOutSlowIn,
      label: 'The curve fastOutSlowIn is used',
    ),
  ];

  static List<TabItem> items({bool image}) {
    if (image) {
      return [
       TabItem<Image>(
          icon: Image.asset('images/infaq.png'),
          activeIcon: Image.asset('images/infaq.png'),
          title: 'Infaq',
        ),
        TabItem<Image>(
            icon: Image.asset('images/zakate.png'),
            activeIcon: Image.asset('images/zakate.png'),
            title: 'Zakat'),
        
         TabItem<Image>(
          icon: Image.asset('images/beranda.png'),
          activeIcon: Image.asset('images/beranda.png'),
          title: 'Beranda',
        ),
        TabItem<Image>(
          icon: Image.asset('images/sodaqah.png'),
          activeIcon: Image.asset('images/sodaqah.png'),
          title: 'Sodaqah',
        ),
        TabItem<Image>(
          icon: Image.asset('images/mesjid.png'),
          activeIcon: Image.asset('images/mesjid.png'),
          title: 'Pengelola',
        ),
      ];
    }
    return [
      TabItem<IconData>(icon: Icons.home, title: 'Home'),
      TabItem<IconData>(icon: Icons.map, title: "Discovery"),
      TabItem<IconData>(icon: Icons.publish, title: "Publish"),
      TabItem<IconData>(icon: Icons.message, title: 'Message'),
      TabItem<IconData>(icon: Icons.people, title: 'Profile'),
    ];
  }
}
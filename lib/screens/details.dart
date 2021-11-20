import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'icon_badge.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:donasi_mobile/screens/form_infaq.dart';

class Details extends StatefulWidget {
//  final String recordName;
//   const Details(this.recordName);

  @override
  _DetailsState createState() => new _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
  // this will control the button clicks and tab changing
  TabController _controller;

  // this will control the animation when a button changes from an off state to an on state
  AnimationController _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  AnimationController _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  Animation _colorTweenBackgroundOn;
  Animation _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  Animation _colorTweenForegroundOn;
  Animation _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  // these will be our tab icons. You can use whatever you like for the content of your buttons
  List _icons = [
    "Tentang",
    "Laporan",
    "Donatur",
    "Galery"
    // "Syarat & Ketentuan"
  ];

  // active button's foreground color
  Color _foregroundOn = Colors.white;
  Color _foregroundOff = Colors.black;

  // active button's background color
  Color _backgroundOn = Colors.green[400];
  Color _backgroundOff = Colors.grey[300];
  // scroll controller for the TabBar
  ScrollController _scrollController = new ScrollController();
// this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  List _keys = [];

  // regist if the the button was tapped
  bool _buttonTap = false;

  // List places;
  List places;
  List laporans;
  List galerys;
  List donaturs;
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

  Future<String> getLaporan() async {
    var response = await http.get(
        // Uri.encodeFull("https://ori.iumrah.co.id/api/mobile/paket/detail/index.php?p1=${widget.recordName}"),
        Uri.encodeFull("http://139.59.127.33/api/v1/infaq/detaillaporan/18"),
        headers: {"Accept": "application/json"});

    setState(() {
      laporans = json.decode(response.body);
    });

    return "Success";
  }

  Future<String> getGalery() async {
    var response = await http.get(
        // Uri.encodeFull("https://ori.iumrah.co.id/api/mobile/paket/detail/index.php?p1=${widget.recordName}"),
        Uri.encodeFull("http://139.59.127.33/api/v1/infaq/listfoto/18"),
        headers: {"Accept": "application/json"});

    setState(() {
      galerys = json.decode(response.body);
    });

    return "Success";
  }

  Future<String> getDonatur() async {
    var response = await http.get(
        // Uri.encodeFull("https://ori.iumrah.co.id/api/mobile/paket/detail/index.php?p1=${widget.recordName}"),
        Uri.encodeFull("http://139.59.127.33/api/v1/infaq/listdonatur/18"),
        headers: {"Accept": "application/json"});

    setState(() {
      donaturs = json.decode(response.body);
    });

    return "Success";
  }

  void initState() {
    super.initState();
    getData();
    getLaporan();
    getGalery();
    getDonatur();
    for (int index = 0; index < _icons.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(new GlobalKey());
    }
    // this creates the controller with 6 tabs (in our case)
    _controller = TabController(vsync: this, length: _icons.length);
    // this will execute the function every time there's a swipe animation
    _controller.animation.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller.addListener(_handleTabChange);
    _animationControllerOff =
        AnimationController(vsync: this, duration: Duration(milliseconds: 75));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);

    _animationControllerOn =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);
  }

  @override
  void dispose() {
    _controller.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Infaq"),
        backgroundColor: Colors.green[300],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        // this is the TabBar
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 20),
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            primary: false,
            itemCount: places == null ? 0 : places.length,
            itemBuilder: (BuildContext context, int index) {
              Map place = places[index];

              return Padding(
                padding: EdgeInsets.only(right: 10),
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
          padding: EdgeInsets.only(left: 20),
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
          padding: EdgeInsets.only(left: 20),
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
          padding: EdgeInsets.only(left: 20),
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
              padding: EdgeInsets.only(left: 20),
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

        Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: RaisedButton(
            color: Colors.green,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.green[300],
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => FormDetail()));
            },
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: new Text('Infaq Sekarang',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
          ),
        ),

        SizedBox(height: 20),

        Container(
            height: 49.0,
            // this generates our tabs buttons
            child: ListView.builder(
                // this gives the TabBar a bounce effect when scrolling farther than it's size
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                // make the list horizontal
                scrollDirection: Axis.horizontal,
                // number of tabs
                itemCount: _icons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      // each button's key
                      key: _keys[index],
                      // padding for the buttons
                      padding: EdgeInsets.all(6.0),
                      child: ButtonTheme(
                          child: AnimatedBuilder(
                        animation: _colorTweenBackgroundOn,
                        builder: (context, child) => FlatButton(
                          // get the color of the button's background (dependent of its state)
                          color: _getBackgroundColor(index),
                          // make the button a rectangle with round corners
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(7.0)),
                          onPressed: () {
                            setState(() {
                              _buttonTap = true;
                              // trigger the controller to change between Tab Views
                              _controller.animateTo(index);
                              // set the current index
                              _setCurrentIndex(index);
                              // scroll to the tapped button (needed if we tap the active button and it's not on its position)
                              _scrollTo(index);
                            });
                          },

                          child: new Center(
                            child: new Text("${_icons[index]}"),
                          ),
                        ),
                      )));
                })),
        Flexible(
            // this will host our Tab Views
            child: TabBarView(
          // and it is controlled by the controller

          controller: _controller,
          children: <Widget>[
            // our Tab Views
            // Icon(_icons[0]),
            //// tab1
            Container(
              height: 10.0,
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  itemCount: places == null ? 0 : places.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map place = places[index];

                    return Html(
                      data: "${place["desc"]}",
                    );
                  }),
            ),
            // tab 2
            Container(
              height: 10.0,
              padding: EdgeInsets.only(left: 5),
              alignment: Alignment.centerRight,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  itemCount: laporans == null ? 0 : laporans.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map laporan = laporans[index];
                    return Card(
                      child: Html(
                          data:
                              "<p></p><h3 style='text-align: center;'><center>Pencairan Dana ${laporan["pencairan"]}</center></3><br><p><center><img src='http://139.59.127.33/banner/${laporan["image"]}'><h6>Tanggal Pelaporan ${laporan["created_at"]}</h6><p>${laporan["title"]}</P></center></p>",
                          style: {
                            "h3": Style(
                              textAlign: TextAlign.center,
                            ),
                          }),
                    );
                  }),
            ),
            // tab 3
            Container(
              height: 5.0,
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  itemCount: donaturs == null ? 0 : donaturs.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map donatur = donaturs[index];
                    if (donatur["keterangan"] != null) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 1,
                        child: Html(
                            data:
                                "<div>${donatur["nama"]} <Strong>Rp. ${donatur["nominal"]}</strong><div><strong>Pesan: </strong><span> ${donatur["keterangan"]}</span></div><h6>Tanggal Donasi ${donatur["created_at"]}</h6></div>",
                            style: {
                              "div": Style(
                                margin: EdgeInsets.all(1),
                              ),
                            }),
                      );
                    } else {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 1,
                        child: Html(
                            data:
                                "<div>${donatur["nama"]} <Strong>Rp. ${donatur["nominal"]}</strong><div><h6>Tanggal Donasi ${donatur["created_at"]}</h6></div>",
                            style: {
                              "div": Style(
                                margin: EdgeInsets.all(1),
                              ),
                            }),
                      );
                    }
                  }),
            ),
            // tab 4
            Container(
              height: 10.0,
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerRight,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  itemCount: galerys == null ? 0 : galerys.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map galery = galerys[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 1,
                      child: Html(
                          data:
                              "<p><img src='http://139.59.127.33/banner/${galery["image"]}' style='width:10px;'></p>",
                          style: {
                            "p": Style(
                              textAlign: TextAlign.center,
                            ),
                          }),
                    );
                  }),
            ),
          ],
        )),
      ]),
    );
  }

  // runs during the switching tabs animation
  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller.animation.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller.index);

    // this resets the button tap
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn.reset();
    _animationControllerOff.reset();

    // run the animations!
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[_icons.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return _colorTweenBackgroundOn.value;
    } else if (index == _prevControllerIndex) {
      // if it's the previous active button
      return _colorTweenBackgroundOff.value;
    } else {
      // if the button is inactive
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff.value;
    } else {
      return _foregroundOff;
    }
  }
}

import 'dart:async';
import 'dart:io' show Platform;

import 'package:camera/camera.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:rufford/BeaconScan.dart';
import 'package:rufford/detect_screen.dart';
import 'package:rufford/detect_screen.dart';
import 'package:flutter/material.dart';

import 'package:residemenu/residemenu.dart';

import 'package:rufford/detail.dart';
import 'package:rufford/tutorial.dart';
import 'package:share/share.dart';
import 'package:rufford/textStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:flutter/gestures.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/services.dart';

import 'Hunt.dart';
import 'home.dart';

class Surveys extends StatefulWidget {
  @override
  SurveysState createState() {
    return new SurveysState();
  }
}


class SurveysState extends State<Surveys> with TickerProviderStateMixin {
  //MenuController _menuController;
  var data;
  int visited = 0;
  String reward = "";
  String time = "Tap to activate \nuse within 10 minutes";
  bool activate1 = true;

  checkReward() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    activate1 = (prefs.getBool('reward') ?? true);
    visited = (prefs.getInt('visited') ?? 0);
    setState(() {

    });
  }





  /// to build a reside menu drawer build by library
  Widget buildItem(String msg, VoidCallback method) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: ResideMenuItem(
          title: msg,
          icon: const Icon(Icons.home, color: Colors.grey),
          right: const Icon(Icons.arrow_forward, color: Colors.grey),
        ),
        onTap: () => method,
      ),
    );
  }

  _sharer() {
    Share.share(" TOUGHEST - Test your knowledge.\n" +
        "The app that will make you an amazing candidate for any job.\n"
            "Are you ready?\n"
            "Download it now\n"
            "https://play.google.com/store/apps/details?id=tricky.questions");
  }

  _goHome() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home()));
  }

  _goDetect() async {
    List<CameraDescription> cameras;
    cameras = await availableCameras();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetectScreen(cameras, "Black Texture")));
  }



  _goBeacon() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyApp()));
  }

  openBrowserTab1() async {
    await FlutterWebBrowser.openWebPage(url: "https://forms.office.com/r/uEaPNWhnv1");
  }

  openBrowserTab2() async {
    await FlutterWebBrowser.openWebPage(url: "https://forms.office.com/r/LSQTwGPB0n");
  }







  @override
  Future<void> initState() {
    super.initState();
    //_menuController = new MenuController(vsync: this);
    checkReward();

  }

  setFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('reward', false);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //to use reside menu library we have to return a residemenu scafford.
//     return new ResideMenu.scafford(
//      // direction: ScrollDirection.LEFT,
//       decoration: new BoxDecoration(
//           image: new DecorationImage(
//               image: new AssetImage("assets/images/background.jpg"),
//               fit: BoxFit.cover)),
//       controller: _menuController,
//       leftScaffold: new MenuScaffold(
//         header: new ConstrainedBox(
//           constraints: new BoxConstraints(),
//           child: new CircleAvatar(
//             backgroundImage: new AssetImage('assets/images/icon.png'),
//             radius: 60.0,
//           ),
//         ),
//         children: <Widget>[
//           ///I have to make these drawer list widgets manually cause it is containing different methods.
// //           added Changes
//           new Material(
//             color: Colors.transparent,
//             child: new InkWell(
//               child: ResideMenuItem(
//                 title: 'Home',
//                 titleStyle: TextStyle(color: Colors.black,fontSize: 20.0),
//                 icon: const Icon(Icons.home, color: Colors.black),
//               ),
//               onTap: () => _goHome(),
//             ),
//           ),
//
//           new Material(
//             color: Colors.transparent,
//             child: new InkWell(
//               child: ResideMenuItem(
//                 title: 'Beacon',
//                 titleStyle: TextStyle(color: Colors.black,fontSize: 20.0),
//                 icon: const Icon(Icons.map_rounded, color: Colors.black),
//               ),
//               onTap: () => _goBeacon(),
//             ),
//           ),
//           new Material(
//             color: Colors.transparent,
//             child: new InkWell(
//               child: ResideMenuItem(
//                 title: 'Camera',
//                 titleStyle: TextStyle(color: Colors.black,fontSize: 20.0),
//                 icon: const Icon(Icons.camera, color: Colors.black),
//               ),
//               onTap: () => _goDetect(),
//             ),
//           ),
//           new Material(
//             color: Colors.transparent,
//             child: new InkWell(
//               child: ResideMenuItem(
//                 title: 'Share',
//                 titleStyle: TextStyle(color: Colors.black,fontSize: 20.0),
//                 icon: const Icon(Icons.share, color: Colors.black),
//               ),
//               onTap: () => _sharer(),
//             ),
//           ),
//
//         ],
//       ),
    return new Scaffold(
      appBar: new AppBar(
        elevation: 10.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: new Text(
          'Surveys',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(

        children: <Widget>[
          Padding(padding: const EdgeInsets.all(8.0)),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('Providing your feedback helps to improve the research and the app. The surveys linked below should only take 1-2 minutes to complete. Thank-you for your help.',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,

              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(16.0)),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('1 - Complete the Initial survey:',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                  fontWeight: FontWeight.bold

              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            onPressed: () => openBrowserTab1(),
            child: Text('Open initial survey'),
          ),
          Padding(padding: const EdgeInsets.all(16.0)),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('2- Complete the app feedback survey after playing the treasure hunt:',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                  fontWeight: FontWeight.bold

              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            onPressed: () => openBrowserTab2(),
            child: Text('Open feedback survey'),
          ),
        ],
      ),

    );
  }
}

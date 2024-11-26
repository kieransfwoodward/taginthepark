import 'dart:async';
import 'dart:io' show Platform;

import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:rufford/BeaconScan.dart';
import 'package:rufford/detect_screen.dart';
import 'package:rufford/detect_screen.dart';
import 'package:flutter/material.dart';

import 'package:residemenu/residemenu.dart';

import 'package:rufford/detail.dart';
// import 'package:rufford/externalmodelmanagementexample.dart';
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

class Info extends StatefulWidget {
  @override
  InfoState createState() {
    return new InfoState();
  }
}


class InfoState extends State<Info> with TickerProviderStateMixin {
  //MenuController _menuController;
  var data;





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





  @override
  Future<void> initState() {
    super.initState();
   // _menuController = new MenuController(vsync: this);

  }






  ///creating a carousel using carousel pro library.
  final myCraousal = Carousel(
    dotSize: 1.0,
    dotIncreaseSize: 2.0,
    borderRadius: true,
    radius: Radius.circular(1.0),
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(seconds: 2),
    images: [
      AssetImage('assets/images/card1.jpg'),
      AssetImage('assets/images/card3.jpeg'),
      AssetImage('assets/images/card4.jpeg'),
      AssetImage('assets/images/card2.jpg'),
    ],
  );



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
            'Rufford Abbey',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(

          children: <Widget>[
            Container(
              key: Key('banner'),
              padding: EdgeInsets.only(bottom: 5.0),
              height: height / 2.5,
              child: myCraousal,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('An interactive proximity-based game that offers challenges, quizzes and rewards while walking around an outdoor park. \nTo complete the challenges, you need to visit a designated locations at Rufford Country Park called “Tag In the Park game zones” Every time you visit a location you, it will be added to your list of visited location. \nThe Tag in The Park game platform has been developed by the Smart Sensing Team at Nottingham Trent University led by Prof. Eiman Kanjo and Dr. Kieran Woodward. Contact the team at contact@tagwithme.co.uk ',
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),

            ),
            ElevatedButton(

              onPressed: () => MapsLauncher.launchQuery(
                  'Rufford Country Park, Ollerton NG22 9DF'),
              child: Text('Get directions'),
            ),
            // ElevatedButton(
            //
            //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => ExternalModelManagementWidget())),
            //   child: Text('AR test'),
            // ),
          ],
        ),
      );
  }
}

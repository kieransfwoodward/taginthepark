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

class Rewards extends StatefulWidget {
  @override
  RewardsState createState() {
    return new RewardsState();
  }
}


class RewardsState extends State<Rewards> with TickerProviderStateMixin {
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

  Future<void> checkdate() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String SPdate = (prefs.getString('date') ?? "NA");
    if (formattedDate == SPdate){
       visited = (prefs.getInt('visited') ?? 0);
       if(visited > 4){
         reward = "10% off coffee";
       }
       if (visited > 9){
         reward = "25% off coffee";
       }
       if (visited > 14){
         reward = "50% off coffee";
       }
    }
    else{

    }
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
          'Reward',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(

        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Complete the treasure hunt to earn rewards.',
              style: new TextStyle(
                fontSize: 32.0,
                color: Colors.black,

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Once visited 10 locations (game zones) you can claim a free coffee or a small treat bag.',
              style: new TextStyle(
                fontSize: 24.0,
                color: Colors.black,
              ),
            ),

          ),
          if(visited > 10 && activate1)GestureDetector(
    child: Container(
            margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Color(0xFF419AE3)
    ),
    height: 180.0,
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Text(
    "Free coffee or small swet bag worth 40p",
    style: Style.headerstyle,
    ),
      // Text(
      //   "Expires today.",
      //   //style: Style.headerstyle,
      // ),
      Text(
        "",
        style: Style.headerstyle,
      ),
      Text(
        time,
        style: Style.headerstyle,
      ),

    ],
    )
    ),
    ),
    onTap: () {
    print("tapped");
    setFalse();
    Timer _timer;
    int _start = 600;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
            time = "$_start";

          });
        }
      },
    );



    }
            )
        ],
      ),

    );
  }
}

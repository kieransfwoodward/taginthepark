import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mark922_flutter_lottie/mark922_flutter_lottie.dart';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:residemenu/residemenu.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rufford/externalmodelmanagementexample.dart';
import 'package:rufford/tutorial.dart';
import 'package:share/share.dart';
import 'dart:math';
import 'package:rufford/textStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:rufford/BeaconScan.dart';
import 'package:rufford/detect_screen.dart';
import 'package:sensors/sensors.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:pedometer/pedometer.dart';





import 'BeaconScan.dart';
import 'detect_screen.dart';
import 'home.dart';


class Hunt extends StatefulWidget {
  final String quest, ans;
  static var randomNumber = Random();
  Hunt({this.quest, this.ans});

  static final List<Color> _colors = [
    Colors.red,
    Colors.teal,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.purple,
    Colors.blue,
  ];

  @override
  HuntState createState() {
    return HuntState();
  }
}

//This class helps to create links, that we are using in about dialog.
class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
      style: style,
      text: text ?? url,
      recognizer: new TapGestureRecognizer()
        ..onTap = () {
          urlLauncher.launch(url);
        });
}


class HuntState extends State<Hunt> with TickerProviderStateMixin  {
  LottieController controller2;
  // final firestoreInstance = FirebaseFirestore.instance;
  String subtitle = "No question yet";
 // MenuController _menuController;
  int count = 0;
  bool hide = false;
  String title = "Walk around to find locations and then complete the activity";
  double beaconDistance = 0;
  String beaconID = "";
  String _beaconResult = 'Not Scanned Yet.';
  int _nrMessaggesReceived = 0;
  String find = "leaf";
  final StreamController<String> beaconEventsController =
  StreamController<String>.broadcast();
  double percent = 1;
  String distanceLength = "Keep walking";
//  bool first = true;
  double smallestDistance = 1000;
  String closestBeacon = "";
  int closestBeaconIndex = 0;
  int locationsVisited = 0;
  int nfcCount = 2;
  bool firstNFC = true;
  String popupimage = "assets/images/confetti.gif";
  List beaconIDs;
  String findImage;

  List beaconIDsAndroid = [
    // ["4BE4F4B6-54A0-413C-83B4-B76697000319", "assets/images/abbeyNFC.jpeg", "NFC", 1,  "test 1", "test 2"],
    // ["b9407f30-f5f8-466e-aff9-25556b57fe6d", "assets/images/abbeyQuiz.jpeg", "quiz", 1, "When was Rufford Abbey founded?", "1146", "1536", "1216"], //yellow
    //   ["4be4f4b6-54a0-413c-83b4-b76697000319", "assets/images/treesNFC.jpeg", "NFC", 1, "test 1", "test 2"], //pink 1
    //  ["57e2751a-7919-4185-9b9e-78cc77b37ee3", "assets/images/statueAI.jpeg", "AI", 1, "the stone statue"], //green
    //  ["15767d07-3c58-4cb5-1848-8be6c583e67c", "assets/images/treeQuiz.jpeg", "AI", 1, "How many trees are protected by fences?", "3", "2", "5"], //beetroot
    //  ["106b08b2-e622-465b-b4f8-824a6d9b48a1","assets/images/statueAI.jpeg", "quiz",1, "What was the ice house originally used for?", "Storing ice", "A dungeon", "Swimming"], //blue
    //  ["f8102d6f-3f74-45e3-8400-7cf883b9c685", "assets/images/millQuiz.jpeg", "quiz",1, "When was the mill built?", "1750", "1850", "1650"], //pink 3
    //  ["00000000-0000-0000-0000-000000000002", "assets/images/bridgeQuiz.jpeg", "quiz",1, "How big is Rufford lake?", "40 acres", "400 acres", "4 acres"], //pink 3

    // ["4BE4F4B6-54A0-413C-83B4-B76697000319", "assets/images/statueAI.jpeg", "AI", 1, "the stone statue"], //green
    // ["b9407f30-f5f8-466e-aff9-25556b57fe6d", "assets/images/stumpAI.jpg", "AI", 1, "the carved wooden bust"], //green
    //
    // ["4be4f4b6-54a0-413c-83b4-b76697000319", "assets/images/AppleAI.jpg", "AI", 1, "the Golden delicious"], //green
    //
    // ["57e2751a-7919-4185-9b9e-78cc77b37ee3", "assets/images/pillarAI.jpg", "AI", 1, "the Two vessels"],
    //
    // ["15767d07-3c58-4cb5-1848-8be6c583e67c", "assets/images/manAI.jpg", "AI", 1, "the oil patch warrior"], //green


    // ["4BE4F4B6-54A0-413C-83B4-B76697000319", "assets/images/statueAI.jpeg", "AI", 1, "the stone statue"], //green
    // ["b9407f30-f5f8-466e-aff9-25556b57fe6d", "assets/images/stumpAI.jpg", "AI", 1, "the carved wooden bust"], //green
    // //
    // ["4be4f4b6-54a0-413c-83b4-b76697000319", "assets/images/AppleAI.jpg", "AI", 1, "the Golden delicious"], //green
    // //
    // ["57e2751a-7919-4185-9b9e-78cc77b37ee3", "assets/images/pillarAI.jpg", "AI", 1, "the Two vessels"],


    ["00000000-0000-0000-0000-000000000001", "assets/images/abbeyNFC.jpeg", "NFC", 6, "Abbey","I am located at the front of the Abbey, find this historic time keeping device",  "test 1", "test 2"],
    ["00000000-0000-0000-0000-000000000004", "assets/images/abbeyQuiz.jpeg", "quiz", 12, "Abbey","You can find me by a door tucked away on the corner of the Abbey", "When was Rufford Abbey founded?", "1146", "1536", "1216"], //yellow
    ["00000000-0000-0000-0000-000000000005", "assets/images/treesNFC.jpeg", "NFC", 12, "Lake side trees","You’ll find me where you have to make a decision on which direction to walk the lake", "test 1", "test 2"], //pink 1
    ["00000000-0000-0000-0000-000000000002", "assets/images/statueAI.jpeg", "AI", 5, "Stone statue","Find me located at the corner of two long bushes", "the stone statue"], //green
    ["00000000-0000-0000-0000-000000000003", "assets/images/treeQuiz.jpeg", "quiz", 7, "Tress","I am the centre of 3 important trees", "How many trees are protected by fences?", "3", "2", "5"], //beetroot
    ["00000000-0000-0000-0000-000000000007","assets/images/iceHouseQuiz.jpeg", "quiz",6, "Ice house","My location was used to store fresh foods before the invention of fridges", "What was the ice house originally used for?", "Storing ice", "A dungeon", "Swimming"], //blue
    ["00000000-0000-0000-0000-000000000008", "assets/images/millQuiz.jpeg", "quiz",10, "Mill","Find me at the visitor board outside the large building on the edge of the lake", "When was the mill built?", "1750", "1850", "1650"], //pink 3
    ["00000000-0000-0000-0000-000000000010", "assets/images/bridgeQuiz.jpeg", "quiz",1, "Bridge","Take a stroll around the lake to find my location", "How big is Rufford lake?", "40 acres", "400 acres", "4 acres"], //pink 3
    //was 5
    ["00000000-0000-0000-0000-000000000017", "assets/images/cubeNFC.jpeg", "NFC", 6, "Pine Cube","You will find me upon a pedestal at the end of the formal gardens pathway", "test 1", "test 2"], //pink 1 was 4.5
    ["00000000-0000-0000-0000-000000000009", "assets/images/bridgeNFC.jpeg", "NFC", 1, "Mill bridge","Continue walking around the lake to find my tags", "test 1", "test 2"], //pink 1
    //was 5
    ["00000000-0000-0000-0000-000000000006", "assets/images/stumpAI.jpg", "AI", 1, "Carved wooden bust","I will be seen when you walk between the Ice house and the lake", "the carved wooden bust"], //green
    //was 5
    ["00000000-0000-0000-0000-000000000011", "assets/images/AppleAI.jpg", "AI", 6, "Golden delicious","In the entrance to the formal gardens is where you’ll find me", "the Golden delicious"], //green was 5
    ["00000000-0000-0000-0000-000000000012", "assets/images/pillarAI.jpg", "AI", 5, "Two vessels","You’ll have to look carefully. I’m hidden in the corner of the formal gardens", "the Two vessels"], //green
    //["00000000-0000-0000-0000-000000000014", "assets/images/manAI.jpg", "AI", 4, "the oil patch warrior"], //green
    ["00000000-0000-0000-0000-000000000016", "assets/images/arch.jpg", "AI", 7, "Dragon gateway","I’m the gateway between a play area and the formal gardens", "the Dragon gateway"], //green
    ["00000000-0000-0000-0000-000000000015", "assets/images/houseAI.jpeg", "AI", 5, "Shrine at Nemi","I’ll be found between the two ends of the formal gardens pathway", "the shrine at Nemi"], //green
    ["00000000-0000-0000-0000-000000000013", "assets/images/stoneAI.jpeg", "AI", 5, "Leaf stone","In a secluded corner outside of the play area", "the Leaf stone"], //green

  ];

  List beaconIDsios = [
    // ["4BE4F4B6-54A0-413C-83B4-B76697000319", "assets/images/abbeyNFC.jpeg", "NFC", 1,  "test 1", "test 2"],
    // ["b9407f30-f5f8-466e-aff9-25556b57fe6d", "assets/images/abbeyQuiz.jpeg", "quiz", 1, "When was Rufford Abbey founded?", "1146", "1536", "1216"], //yellow
    //   ["4be4f4b6-54a0-413c-83b4-b76697000319", "assets/images/treesNFC.jpeg", "NFC", 1, "test 1", "test 2"], //pink 1
    //  ["57e2751a-7919-4185-9b9e-78cc77b37ee3", "assets/images/statueAI.jpeg", "AI", 1, "the stone statue"], //green
    //  ["15767d07-3c58-4cb5-1848-8be6c583e67c", "assets/images/treeQuiz.jpeg", "AI", 1, "How many trees are protected by fences?", "3", "2", "5"], //beetroot
    //  ["106b08b2-e622-465b-b4f8-824a6d9b48a1","assets/images/statueAI.jpeg", "quiz",1, "What was the ice house originally used for?", "Storing ice", "A dungeon", "Swimming"], //blue
    //  ["f8102d6f-3f74-45e3-8400-7cf883b9c685", "assets/images/millQuiz.jpeg", "quiz",1, "When was the mill built?", "1750", "1850", "1650"], //pink 3
    //  ["00000000-0000-0000-0000-000000000002", "assets/images/bridgeQuiz.jpeg", "quiz",1, "How big is Rufford lake?", "40 acres", "400 acres", "4 acres"], //pink 3

    //  ["4BE4F4B6-54A0-413C-83B4-B76697000319", "assets/images/statueAI.jpeg", "NFC", 1, "the stone statue"], //green
    //  ["b9407f30-f5f8-466e-aff9-25556b57fe6d", "assets/images/stumpAI.jpg", "NFC", 1, "the carved wooden bust"], //green
    // //
    //  ["4be4f4b6-54a0-413c-83b4-b76697000319", "assets/images/AppleAI.jpg", "NFC", 1, "the Golden delicious"], //green
    // //
    //  ["57e2751a-7919-4185-9b9e-78cc77b37ee3", "assets/images/pillarAI.jpg", "NFC", 1, "the Two vessels"],
    //
    // ["15767d07-3c58-4cb5-1848-8be6c583e67c", "assets/images/manAI.jpg", "AI", 1, "the oil patch warrior"], //green




    ["00000000-0000-0000-0000-000000000001", "assets/images/abbeyNFC.jpeg", "NFC", 3, "Abbey","I am located at the front of the Abbey, find this historic time keeping device",  "test 1", "test 2"],
    ["00000000-0000-0000-0000-000000000004", "assets/images/abbeyQuiz.jpeg", "quiz", 10, "Abbey","You can find me by a door tucked away on the corner of the Abbey", "When was Rufford Abbey founded?", "1146", "1536", "1216"], //yellow
    ["00000000-0000-0000-0000-000000000005", "assets/images/treesNFC.jpeg", "NFC", 8, "Lake side trees","You’ll find me where you have to make a decision on which direction to walk the lake", "test 1", "test 2"], //pink 1
    ["00000000-0000-0000-0000-000000000002", "assets/images/statueAI.jpeg", "AI", 3, "Stone statue","Find me located at the corner of two long bushes", "the stone statue"], //green
    ["00000000-0000-0000-0000-000000000003", "assets/images/treeQuiz.jpeg", "quiz", 5, "Tress","I am the centre of 3 important trees", "How many trees are protected by fences?", "3", "2", "5"], //beetroot
    ["00000000-0000-0000-0000-000000000007","assets/images/iceHouseQuiz.jpeg", "quiz",4, "Ice house","My location was used to store fresh foods before the invention of fridges", "What was the ice house originally used for?", "Storing ice", "A dungeon", "Swimming"], //blue
    ["00000000-0000-0000-0000-000000000008", "assets/images/millQuiz.jpeg", "quiz",6, "Mill","Find me at the visitor board outside the large building on the edge of the lake", "When was the mill built?", "1750", "1850", "1650"], //pink 3
    ["00000000-0000-0000-0000-000000000010", "assets/images/bridgeQuiz.jpeg", "quiz",3, "bridge","Take a stroll around the lake to find my location", "How big is Rufford lake?", "40 acres", "400 acres", "4 acres"], //pink 3
    ["00000000-0000-0000-0000-000000000017", "assets/images/cubeNFC.jpeg", "NFC", 3, "Pine cube","You will find me upon a pedestal at the end of the formal gardens pathway", "test 1", "test 2"], //pink 1 was 4.5
    ["00000000-0000-0000-0000-000000000009", "assets/images/bridgeNFC.jpeg", "NFC", 2, "Mill bridge","Continue walking around the lake to find my tags", "test 1", "test 2"], //pink 1
    ["00000000-0000-0000-0000-000000000006", "assets/images/stumpAI.jpg", "AI", 1, "Carved wooden bust","I will be seen when you walk between the Ice house and the lake", "the carved wooden bust"], //green
    ["00000000-0000-0000-0000-000000000011", "assets/images/AppleAI.jpg", "AI", 4, "Golden delicious","In the entrance to the formal gardens is where you’ll find me", "the Golden delicious"], //green was 5
    ["00000000-0000-0000-0000-000000000012", "assets/images/pillarAI.jpg", "AI", 2, "Two vessels","You’ll have to look carefully. I’m hidden in the corner of the formal gardens", "the Two vessels"], //green
    //["00000000-0000-0000-0000-000000000014", "assets/images/manAI.jpg", "AI", 4, "the oil patch warrior"], //green
    ["00000000-0000-0000-0000-000000000016", "assets/images/arch.jpg", "AI", 4, "Dragon gateway","I’m the gateway between a play area and the formal gardens", "the Dragon gateway"], //green
    ["00000000-0000-0000-0000-000000000015", "assets/images/houseAI.jpeg", "AI", 1, "Shring at Nemi","I’ll be found between the two ends of the formal gardens pathway", "the shrine at Nemi"], //green
    ["00000000-0000-0000-0000-000000000013", "assets/images/stoneAI.jpeg", "AI", 1, "Leaf stone","In a secluded corner outside of the play area", "the Leaf stone"], //green

  ];


  List<CameraDescription> cameras;
  String imageName = "";
  double acceleration = 0;
  double accSpeed = 0;
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  int steps = 0;
  bool firstLaunch = true;
  int offset = 0;
  StreamSubscription<NDEFMessage> stream;
  bool showsteps = false;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];


  @override
  Future<void> initState() {


    super.initState();

    checkPermission();
    checkPermission2();


    if(Platform.isAndroid) {
      beaconIDs = beaconIDsAndroid;
    }
    if(Platform.isIOS) {
      beaconIDs = beaconIDsios;
    }


    _onPressed();
    checkdate();
    initPlatformState();
    //  _menuController = new MenuController(vsync: this);


    if(Platform.isAndroid){
      nfcCount==2;
      startNFC();
    }


    // userAccelerometerEvents.listen((UserAccelerometerEvent event) {
    //   double x = event.x*event.x;
    //   double y = event.y*event.y;
    //   double z = event.z*event.z;
    //   acceleration = x+y+z;
    //   acceleration = sqrt(acceleration);
    // setState(() {
    //   accSpeed = acceleration;
    // });
    // });


    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      double x = event.x*event.x;
      double y = event.y*event.y;
      double z = event.z*event.z;
      acceleration = x+y+z;
      acceleration = sqrt(acceleration);
      setState(() {
        accSpeed = acceleration;
      });
    }));




    // BeaconsPlugin.startMonitoring;


  }

  checkPermission2() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Permission.camera.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

    if (await Permission.camera.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
  }

  checkPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      Permission.location.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

    if (await Permission.location.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
  }

  checkdate() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String SPdate = (prefs.getString('date') ?? "NA");
    // if (formattedDate == SPdate){
    //   List beaconIDsTemp = jsonDecode(prefs.getString('beaconIDs'));
    //   beaconIDs = beaconIDsTemp;
    //   locationsVisited = (prefs.getInt('visited') ?? 0);
    //   firstLaunch = false;
    //
    // }
    // else{
    //   await prefs.setString('date', formattedDate);
    //   await prefs.setBool('reward', true);
    //   await prefs.setInt('setps', 0);
    //   await prefs.setInt('offset', 0);
    //   await prefs.setInt('visited', 0);
    //   await prefs.setString('beaconIDs', "");
    //   firstLaunch = true;
    // }
  }

  @override
  void dispose() {
    beaconEventsController.close();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }






  Future<void> onStepCount(StepCount event) async {
    DateTime timeStamp = event.timeStamp;
    showsteps = true;
    steps = event.steps;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    offset = (prefs.getInt('offset') ?? offset);
    if(offset == 0){
      offset = steps;
      await prefs.setInt('offset', steps);
    }
    setState(() {
      steps = steps - offset;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    /// Handle status changed
    String status = event.status;
    DateTime timeStamp = event.timeStamp;
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatus Error: $error');

    showsteps = false;


  }

  void onStepCountError(error) {
    print('onStepCount Error: $error');
    showsteps = false;

  }

  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: false,
    isOverlayTapDismiss: false,
  );

  _openPopup(context, title, text, game) {
    bool show = true;
    popupimage = "assets/images/confetti.gif";
    if (Platform.isAndroid && game == "NFC"  && nfcCount == 2) {
      show = false;

        nfcCount = 0;


        setState(() {
          locationsVisited++;
        });

        startNFC();

    }

      if(game == "AI"){
        popupimage = findImage;
      }
      if(game == "NFC"){
        popupimage = "assets/images/NFCblack.png";
      }
      if(title == "Congratulations"){
        popupimage = "assets/images/confetti.gif";
      }


    Alert(
        context: context,
        style: alertStyle,
        title: title,
        //   type: AlertType.,

        content: Column(
          children: <Widget>[
            Text(
              text,
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            // TextField(
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     icon: Icon(Icons.lock),
            //     labelText: 'Password',
            //   ),
            // ),
          ],
        ),


        image: Image.asset(popupimage),
        buttons: [
          if(show)DialogButton(
            color: Colors.lime,
            onPressed: () {

              Navigator.pop(context);


              if(game == "NFC"){
                if (nfcCount==2){
                  nfcCount = 0;
                }
                if(nfcCount==0){
                  setState(() {
                    locationsVisited++;
                  });
                  startNFC();
                }
                else if(nfcCount == 1){
                  beaconIDs.removeAt(closestBeaconIndex);
                  updateSP();
                  smallestDistance = 1000;
                  closestBeacon = "";
                  imageName = "";
                  nfcCount = 2;
                  firstNFC = true;
                }
              }
              else if(game == "AI"){
                _openPopup(context, "Congratulations", "You found the a $find", "answer");
                gotoCamera();



              }


            },
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }





  _openPopupImage(context, i) {

    Alert(
        context: context,
        style: alertStyle,
      title: beaconIDs[i][4],
      desc: beaconIDs[i][5],
        //   type: AlertType.,

        content: Column(
          children: <Widget>[


          ],
        ),


        image: Image.asset(beaconIDs[i][1]),
        buttons: [
          DialogButton(
            color: Colors.lime,
            onPressed: () {

              Navigator.pop(context);

            },
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  gotoCamera() async {
    List<CameraDescription> cameras;
    cameras = await availableCameras();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetectScreen(cameras, find)));
  }

  _openPopupNoImage(context, title, text, game) {
    bool show = true;

    Alert(
        context: context,
        style: alertStyle,
        title: title,
        //   type: AlertType.,

        content: Column(
          children: <Widget>[
            Text(
              text,
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(game=="NFC")Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(game=="NFC")MaterialButton(

                onPressed: () {
                  startNFC();
                  Navigator.pop(context);
                },
                color: Colors.lime,
                textColor: Colors.white,
                height: 70.0,
//                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                minWidth: 200.0,
                child: Text('Try again', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),

            if(game=="NFC")Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),

            if(game=="NFC")MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.red[900],
                textColor: Colors.white,
                height: 50.0,
//                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                minWidth: 200.0,
                child: Text('Give up', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            // TextField(
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     icon: Icon(Icons.lock),
            //     labelText: 'Password',
            //   ),
            // ),
          ],
        ),


        buttons: [
          if(show && game !="NFC")DialogButton(
            color: Colors.lime,
            onPressed: () {




              Navigator.pop(context);



            },
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),

        ]).show();
  }

  _openQuizPopup(context, title, correct, wrong1, wrong2) {
    Alert(
        context: context,
        title: title,
        //   type: AlertType.,

        content: Column(
          children: <Widget>[
            Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(!hide)MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  _openPopup(context, "Correct", "$correct was the correct answer", "answer");
                },
                color: Colors.lime,
                textColor: Colors.white,
                height: 70.0,
//                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                minWidth: 200.0,
                child: Text(correct, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(!hide)MaterialButton(

                onPressed: () {
                  Navigator.pop(context);
                  _openPopupNoImage(context, "Incorrect", "$correct was the correct answer", "answer");
                },

                color: Colors.lime,
                textColor: Colors.white,
                //   padding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                height: 70.0,
                minWidth: 200.0,
                child: Text(wrong1, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(!hide)MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  _openPopupNoImage(context, "Incorrect", "$correct was the correct answer", "answer");
                },
                color: Colors.lime,
                textColor: Colors.white,
                //   padding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                height: 70.0,
                minWidth: 200.0,
                child: Text(wrong2, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),




          ],
        ),


        buttons: [
          DialogButton(
            color: Colors.lime,
            onPressed: () => Navigator.pop(context),
            height: 0.0,
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),


        ]
    ).show();

  }

  _openQuizPopup3(context, title, correct, wrong1, wrong2) {
    Alert(
        context: context,
        title: title,
        //   type: AlertType.,

        content: Column(
          children: <Widget>[

            Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(!hide)MaterialButton(

                onPressed: () {
                  Navigator.pop(context);
                  _openPopupNoImage(context, "Incorrect", "$correct was the correct answer", "answer");
                },

                color: Colors.lime,
                textColor: Colors.white,
                //   padding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                height: 70.0,
                minWidth: 200.0,
                child: Text(wrong1, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(!hide)MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  _openPopup(context, "Correct", "$correct was the correct answer", "answer");
                },
                color: Colors.lime,
                textColor: Colors.white,
                height: 70.0,
//                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                minWidth: 200.0,
                child: Text(correct, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(!hide)MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  _openPopupNoImage(context, "Incorrect", "$correct was the correct answer", "answer");
                },
                color: Colors.lime,
                textColor: Colors.white,
                //   padding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                height: 70.0,
                minWidth: 200.0,
                child: Text(wrong2, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),




          ],
        ),


        buttons: [
          DialogButton(
            color: Colors.lime,
            onPressed: () => Navigator.pop(context),
            height: 0.0,
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),


        ]
    ).show();

  }


  _openQuizPopup2(context, title, correct, wrong1, wrong2) {
    Alert(
        context: context,
        title: title,
        //   type: AlertType.,

        content: Column(
          children: <Widget>[
            Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(!hide)MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  _openPopupNoImage(context, "Incorrect", "$correct was the correct answer", "answer");
                },
                color: Colors.lime,
                textColor: Colors.white,
                //   padding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                height: 70.0,
                minWidth: 200.0,
                child: Text(wrong2, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),

            Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),
            if(!hide)MaterialButton(

                onPressed: () {
                  Navigator.pop(context);
                  _openPopupNoImage(context, "Incorrect", "$correct was the correct answer", "answer");
                },

                color: Colors.lime,
                textColor: Colors.white,
                //   padding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
                height: 70.0,
                minWidth: 200.0,
                child: Text(wrong1, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Text(
              "",
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],

              ),
            ),

            if(!hide)MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  _openPopup(context, "Correct", "$correct was the correct answer", "answer");
                },
                color: Colors.lime,
                textColor: Colors.white,
                height: 70.0,
//                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                minWidth: 200.0,
                child: Text(correct, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),


          ],
        ),


        buttons: [
          DialogButton(
            color: Colors.lime,
            onPressed: () => Navigator.pop(context),
            height: 0.0,
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),


        ]
    ).show();

  }


  Future<void> updateSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('beaconIDs', jsonEncode(beaconIDs));
    await prefs.setInt('visited', locationsVisited);

    if(locationsVisited == 16){
      distanceLength = "Congratulations";
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    print('1');

    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _stepCountStream = await Pedometer.stepCountStream;

    /// Listen to streams and handle errors
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);


    if (Platform.isAndroid) {
      print('2');
      //Prominent disclosure
      await BeaconsPlugin.setDisclosureDialogMessage(
          title: "Need Location Permission",
          message: "This app requires location for the treasure hunt to work.");
      print('3');

      //Only in case, you want the dialog to be shown again. By Default, dialog will never be shown if permissions are granted.
      await BeaconsPlugin.clearDisclosureDialogShowFlag(false);
    }

    BeaconsPlugin.listenToBeacons(beaconEventsController);
    print('4');
    if(Platform.isIOS){
      await BeaconsPlugin.addRegion(
          "BeaconType1", "b9407f30-f5f8-466e-aff9-25556b57fe6d");
      await BeaconsPlugin.addRegion(
          "BeaconType2", "4be4f4b6-54a0-413c-83b4-b76697000319");
      await BeaconsPlugin.addRegion(
          "BeaconType3", "57e2751a-7919-4185-9b9e-78cc77b37ee3");
      await BeaconsPlugin.addRegion(
          "BeaconType4", "15767d07-3c58-4cb5-1848-8be6c583e67c");
      await BeaconsPlugin.addRegion(
          "BeaconType5", "106b08b2-e622-465b-b4f8-824a6d9b48a1");
      await BeaconsPlugin.addRegion(
          "BeaconType6", "00000000-0000-0000-0000-000000000001");
      await BeaconsPlugin.addRegion(
          "BeaconType7", "00000000-0000-0000-0000-000000000002");
      await BeaconsPlugin.addRegion(
          "BeaconType8", "00000000-0000-0000-0000-000000000003");
      await BeaconsPlugin.addRegion(
          "BeaconType9", "00000000-0000-0000-0000-000000000004");
      await BeaconsPlugin.addRegion(
          "BeaconType10", "00000000-0000-0000-0000-000000000005");
      await BeaconsPlugin.addRegion(
          "BeaconType11", "00000000-0000-0000-0000-000000000006");
      await BeaconsPlugin.addRegion(
          "BeaconType12", "00000000-0000-0000-0000-000000000007");
      await BeaconsPlugin.addRegion(
          "BeaconType13", "00000000-0000-0000-0000-000000000008");
      await BeaconsPlugin.addRegion(
          "BeaconType14", "00000000-0000-0000-0000-000000000009");
      await BeaconsPlugin.addRegion(
          "BeaconType15", "00000000-0000-0000-0000-000000000010");
      await BeaconsPlugin.addRegion(
          "BeaconType16", "00000000-0000-0000-0000-000000000011");
      await BeaconsPlugin.addRegion(
          "BeaconType17", "00000000-0000-0000-0000-000000000012");
      await BeaconsPlugin.addRegion(
          "BeaconType18", "00000000-0000-0000-0000-000000000013");
      await BeaconsPlugin.addRegion(
          "BeaconType19", "00000000-0000-0000-0000-000000000014");
      await BeaconsPlugin.addRegion(
          "BeaconType20", "00000000-0000-0000-0000-000000000015");
      await BeaconsPlugin.addRegion(
          "BeaconType21", "00000000-0000-0000-0000-000000000016");
      await BeaconsPlugin.addRegion(
          "BeaconType22", "00000000-0000-0000-0000-000000000017");

    }


    print('5');
    beaconEventsController.stream.listen(
            (data)  {
          print('6');
          if (data.isNotEmpty) {
            // print("Beacons DataReceived: " + data);
            print('7');
            _beaconResult = data;
            String start = 'uuid": "';
            String end;
            if (Platform.isAndroid) {
              end = '"macAddress';
            }
            else if (Platform.isIOS) {
              end = '"major';
            }

            int startIndex = data.indexOf(start);
            int endIndex = data.indexOf(end, startIndex + start.length);
            String data2 = data.substring(startIndex + start.length, endIndex);
            end = '"';
            endIndex = data2.indexOf(end, 0);
            print(data2.substring(0, endIndex));
            String uuid = data2.substring(0, endIndex);
            uuid = uuid.toLowerCase();
            print(uuid);

            start = 'distance": "';
            end = '"proximity';
            startIndex = data.indexOf(start);
            endIndex = data.indexOf(end, startIndex + start.length);
            data2 = data.substring(startIndex + start.length, endIndex);
            end = '"';
            endIndex = data2.indexOf(end, 0);
            print(data2.substring(0, endIndex));
            String Strdistance = data2.substring(0, endIndex);
            double distance = double.parse(Strdistance);

            print("test1");
            print(uuid);
            //  print(beaconIDs[i][0]);
            print("end");

            for(var i = 0; i < beaconIDs.length; i++) {
              if (smallestDistance != 1000) {
                if (closestBeacon == uuid) {
                  smallestDistance = distance;
                }
              }
              if (uuid == beaconIDs[i][0]) {
                print("test2");
                print(smallestDistance);


                if (distance < smallestDistance) {
                  print("test3");
                  print(smallestDistance);
                  closestBeacon = uuid;
                  closestBeaconIndex = i;
                  smallestDistance = distance;
                }
              }
            }

            if(smallestDistance < beaconIDs[closestBeaconIndex][3] ){

              setState(()   {
                distanceLength = "Very close";
                percent = 3;
              });

              if(beaconIDs[closestBeaconIndex][2] == "AI"){

                find = beaconIDs[closestBeaconIndex][6];
                findImage = beaconIDs[closestBeaconIndex][1];
                _openPopup(context, "Camera game", "Press continue and then point your camera at $find with at least 85% accuracy to earn this location", "AI");
                beaconIDs.removeAt(closestBeaconIndex);

                smallestDistance = 1000;
                closestBeacon = "";
                imageName = "";
                setState(() {
                  locationsVisited++;
                });
                updateSP();


              }

              // dispose();


              else if(beaconIDs[closestBeaconIndex][2] == "quiz"){



                Random random = new Random();
                int randomNumber = random.nextInt(3);

                if (randomNumber == 0){
                  _openQuizPopup(context,beaconIDs[closestBeaconIndex][6] , beaconIDs[closestBeaconIndex][7], beaconIDs[closestBeaconIndex][8], beaconIDs[closestBeaconIndex][9]);
                  beaconIDs.removeAt(closestBeaconIndex);
                  smallestDistance = 1000;
                  closestBeacon = "";
                  imageName = "";
                  setState(() {
                    locationsVisited++;
                  });
                  updateSP();
                }
                if (randomNumber == 1){
                  _openQuizPopup2(context,beaconIDs[closestBeaconIndex][6] , beaconIDs[closestBeaconIndex][7], beaconIDs[closestBeaconIndex][8], beaconIDs[closestBeaconIndex][9]);
                  beaconIDs.removeAt(closestBeaconIndex);
                  smallestDistance = 1000;
                  imageName = "";
                  closestBeacon = "";
                  setState(() {
                    locationsVisited++;
                  });
                  updateSP();
                }
                else{
                  _openQuizPopup3(context,beaconIDs[closestBeaconIndex][6] , beaconIDs[closestBeaconIndex][7], beaconIDs[closestBeaconIndex][8], beaconIDs[closestBeaconIndex][9]);
                  beaconIDs.removeAt(closestBeaconIndex);
                  smallestDistance = 1000;
                  imageName = "";
                  closestBeacon = "";
                  setState(() {
                    locationsVisited++;
                  });
                  updateSP();

                }






              }
              else if(beaconIDs[closestBeaconIndex][2] == "NFC"){
                print("NFC FOUND!!!!!!!!!!!!");
                print(firstNFC);
                if(firstNFC){
                  print("NFC FOUND 2 !!!!!!!!!!!!");
                  _openPopup(context, "Tag game", "Find a nearby Tag in the park tag and tap it with the back of the phone to earn this location" , "NFC");
                  firstNFC = false;
                }
              }
              // first = false;
            }

            else if (smallestDistance < beaconIDs[closestBeaconIndex][3]*2  && smallestDistance >= beaconIDs[closestBeaconIndex][3] ){
              setState(() {
                HapticFeedback.mediumImpact();
                distanceLength = "Very close";
                percent = 3;
                imageName = beaconIDs[closestBeaconIndex][1];
              });
            }

            else if (smallestDistance < beaconIDs[closestBeaconIndex][3]*4 && smallestDistance >= beaconIDs[closestBeaconIndex][3]*2){
              setState(() {
                distanceLength = "Nearby";
                percent = 2;
                imageName = beaconIDs[closestBeaconIndex][1];
              });
            }
            else if (smallestDistance >= beaconIDs[closestBeaconIndex][3]*4 && smallestDistance < 999){
              setState(() {
                distanceLength = "Getting closer";
                percent = 1.5;
                imageName = beaconIDs[closestBeaconIndex][1];
              });
            }
            else{
              if(beaconIDs.length == 0){
                setState(() {
                  distanceLength = "Congratulations!!! \n Game Over.";
                  percent = 1;
                  imageName = "";
                });

              }
              else{
                setState(() {
                  distanceLength = "Keep walking";
                  percent = 1;
                  imageName = "";
                });
              }

            }

            //   smallestDistance = 1000;

            _nrMessaggesReceived++;

            //  print("Beacons DataReceived: " + data);
          }
        },
        onDone: () {print("done");},
        onError: (error) {
          print("Error: $error");
        });

    //Send 'true' to run in background
    await BeaconsPlugin.runInBackground(true);

    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring;
          // setState(() {
          //
          // });
        }
      });
    } else if (Platform.isIOS) {
      await BeaconsPlugin.startMonitoring;
      // setState(() {
      //
      // });
    }

    if (!mounted) return;
  }




  startNFC() async {
    bool playing = true;
    NDEFMessage message;
    //  bool _supportsNFC = false;

    // NFC.isNDEFSupported.then((bool isSupported) {
    //   setState(() {
    //     _supportsNFC = isSupported;
    //   });
    // });
    bool isAvailable = await NfcManager.instance.isAvailable();
    if(isAvailable==true) {
      try {
        // message = await NFC
        //     .readNDEF(once: false, throwOnUserCancel: true, readerMode: NFCDispatchReaderMode())
        //     .first;

        // message = await NFC.readNDEF(once: true).first;

        bool once1 = true;
        if (Platform.isAndroid) {
          once1 = false;
        }
        if (Platform.isIOS) {
          once1 = true;
        }


        stream = NFC.readNDEF(once: once1, throwOnUserCancel: true,
        ).listen((NDEFMessage message) {
          print("read NDEF message: ${message.payload}");

          //    for (var i = 2; i < beaconIDs[closestBeaconIndex].length; i++) {
          //    if (message.payload == beaconIDs[closestBeaconIndex][i]) {
          if (playing && nfcCount==0){
            if (Platform.isAndroid) {
              Navigator.pop(context);
            }
            playing = false;
            nfcCount = 1;
            _openPopup(
                context, "Congratulations", "You found a tag!", "NFC");
            // stream.cancel();
          }



          //     }
          //   }
        }, onError: (e) {
          // Check error handling guide below
          print(e);
          // startNFC();
          if(playing && nfcCount==0){
            playing = false;
            _openPopupNoImage(context, "Keep looking", "Find the tag then press try again to scan", "NFC");
          }
        });
      } catch (e) {
        print(e);
        //startNFC();
        if (playing && nfcCount==0){
          playing = false;
          _openPopupNoImage(context, "Keep looking", "Find the tag then press try again to scan", "NFC");
        }
        return;
      }
    }
    else{
      if (playing && nfcCount==0){
        if (Platform.isAndroid){
          Navigator.pop(context);
        }
        playing = false;
        nfcCount = 1;
        _openPopup(
            context, "Congratulations", "", "NFC");
      }

    }

    // print("records: ${message.payload}");



  }
  //}

  share(String question, String answer) {
    Share.share("Q:" +
        question +
        "\n\n" +
        "A:" +
        answer +
        "\n\nDownload the app for more amazing Q/A\n " +
        "https://play.google.com/store/apps/details?id=tricky.questions");
  }



  Future<void> _onPressed() async {
    await BeaconsPlugin.startMonitoring;
    cameras = await availableCameras();
    //   count = prefs.getInt('count');

    //   count++;

  }

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
    // dispose();
  }

  _goDetect() {

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetectScreen(cameras, "leaf")));

    // dispose();
  }



  _goBeacon() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyApp()));
    //  dispose();
  }

  showAbout(BuildContext context) {
    final TextStyle linkStyle =
    Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue);
    final TextStyle bodyStyle =
    new TextStyle(fontSize: 15.0, color: Colors.black);

    return showAboutDialog(
        context: context,
        applicationIcon: Center(
          child: Image(
            height: 150.0,
            width: 200.0,
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: new RichText(
                  textAlign: TextAlign.start,
                  text: new TextSpan(children: <TextSpan>[
                    new TextSpan(
                        style: bodyStyle,
                        text: 'This app is a treasure hunt designed for use at Rufford Abbey' +
                            ' built in collaboration with Nottingham Trent University '
                                "\n\n"),
                    new TextSpan(
                      style: bodyStyle,
                      text: 'for enquiries:' + "\n\n",
                    ),
                    new _LinkTextSpan(
                        style: linkStyle,
                        text: 'Send an E-mail' + "\n\n",
                        url:
                        'mailto:indiancoder001@gmail.com?subject=App enquiry'),
                  ]))),
        ]);
  }




  @override
  Widget build(BuildContext context) {







    return (
        // direction: ScrollDirection.LEFT,
        // decoration: new BoxDecoration(
        //     image: new DecorationImage(
        //         image: new AssetImage("assets/images/background.jpg"),
        //         fit: BoxFit.cover)),
        // controller: _menuController,
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
        new Scaffold(
          appBar: new AppBar(
            elevation: 10.0,
            centerTitle: true,
            backgroundColor: Colors.white,
              actions: <Widget>[
                // IconButton(
                //   icon: Icon(Icons.add_a_photo_outlined),
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => ExternalModelManagementWidget()));
                //   },
                // ),
              ],
            // leading: new GestureDetector(
            //   child: const Icon(
            //     Icons.menu,
            //     color: Colors.black,
            //   ),
            //   onTap: () {
            //     _menuController.openMenu(true);
            //   },
            // ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: new Text(
              'Treasure hunt',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: AnimatedBackground()),




                  Column(
                    children:  <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  <Widget>[


                            if(showsteps == true)Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                margin: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),

                                  color: Color(0x66bbbbbb),

                                  borderRadius: BorderRadius.all(Radius.circular(20)),

                                ),
                                child: Text(
                                  " \u{1F6B6} $steps",
                                  textAlign: TextAlign.right,
                                  style: new TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,

                                  ),

                                ),



                              ),
                            ),


                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 3.0,
                            ),

                            color: Color(0x66bbbbbb),

                            borderRadius: BorderRadius.all(Radius.circular(20)),

                          ),


                          child: Text(

                            "$locationsVisited/16 locations",
                            textAlign: TextAlign.right,
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,

                            ),

                          ),



                        ),
                      ),


                       ],
                      ),

                       // child: Text('Deliver features faster', textAlign: TextAlign.center),

                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                           // padding: EdgeInsets.symmetric(horizontal: 32.0),
                            padding: EdgeInsets.all(40.0),

                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 3.0,
                              ),

                             // color: Color(0x99bbbbbb),

                              borderRadius: BorderRadius.all(Radius.circular(120)),

                            ),
                          child: Column(children:  <Widget>[
                            Text(distanceLength, style: TextStyle(color: Colors.white), textScaleFactor: 3),
                            if(imageName != "") Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),



                                child: CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(imageName),


                            ),
                            ),

                            ])



                        ),
                        ),



                      Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text("Find the remaining locations:", style: TextStyle(color: Colors.white), textScaleFactor: 1.5, textAlign: TextAlign.center),
                      ),



                      Expanded(

                          child: GridView.count(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                              crossAxisCount: 5,
                              children:<Widget>[



                                for(var i = 0; i < beaconIDs.length; i++) Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GestureDetector(
                                  onTap: () {
                                    _openPopupImage(context, i);

                                  },
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(beaconIDs[i][1]),

                                  ),
                      ),
                                ),

                                // Image.asset('assets/images/Orangery.jpg',
                                //   height: 200,
                                //   width: 200,
                                //   fit: BoxFit.cover,
                                //  ),


                              ])
                      ),




                    ],
                  ),






                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.all(16.0),





                    ),
                  ),




                  onBottom(AnimatedWave(
                    height: 180 * percent,
                    speed: accSpeed + 0.3, //originally 2
                  )),
                  onBottom(AnimatedWave(
                    height: 120 * percent,
                    speed: (accSpeed +0.3)/3, //originally 0.9
                    offset: pi,
                  )),
                  onBottom(AnimatedWave(
                    height: 220 * percent,
                    speed: (accSpeed +0.3)/2, //originally 1.2
                    offset: pi / 2,
                  )),




                ],
              )
          ),
        ));
  }
  Widget onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );

}

































//classes for background animation


class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: LoopAnimation<double>(
            duration: (5000 / speed).round().milliseconds,
            tween: 0.0.tweenTo(2 * pi),
            builder: (context, child, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum _BgProps { color1, color2 }

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_BgProps>()
      ..add(
          _BgProps.color1, Color(0xffD38312).tweenTo(Colors.lightBlue.shade900))
      ..add(_BgProps.color2, Color(0xffA83279).tweenTo(Colors.blue.shade600));

    return MirrorAnimation<MultiTweenValues<_BgProps>>(
      tween: tween,
      duration: 100.seconds,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    value.get(_BgProps.color1),
                    value.get(_BgProps.color2)
                  ])),
        );
      },
    );
  }
}
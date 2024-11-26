import 'dart:async';
import 'dart:io' show Platform;

import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:rufford/BeaconScan.dart';
import 'package:rufford/detect_screen.dart';
import 'package:rufford/detect_screen.dart';
import 'package:flutter/material.dart';

import 'package:residemenu/residemenu.dart';

import 'package:rufford/detail.dart';
import 'package:rufford/rewards.dart';
import 'package:rufford/surveys.dart';
import 'package:rufford/tutorial.dart';
import 'package:rufford/ui/home/home_page.dart';
import 'package:share/share.dart';
import 'package:rufford/textStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:flutter/gestures.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/services.dart';

import 'Hunt.dart';
import 'info.dart';
import 'map.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
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

class HomeState extends State<Home> with TickerProviderStateMixin {
 // MenuController _menuController;
  var data;

  // static const _productIds = {'product_1'};
  // InAppPurchase _connection = InAppPurchase.instance;
  // StreamSubscription<List<PurchaseDetails>> _subscription;
  // List<ProductDetails> _products = [];


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
        builder: (context) => DetectScreen(cameras, "the Dragon gateway")));
  }


  _goBeacon() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyApp()));
  }

  _goHunt() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Hunt()));
    _buyProduct;
  }


  @override
  Future<void> initState() {
    super.initState();
    print('started');
    checkFirstSeen();
   // _menuController = new MenuController(vsync: this);
    setZero();
    // Stream purchaseUpdated =
    //     InAppPurchase.instance.purchaseStream;
    // _subscription = purchaseUpdated.listen((purchaseDetailsList) {
    //   _listenToPurchaseUpdated(purchaseDetailsList);
    // }, onDone: () {
    //   _subscription.cancel();
    // }, onError: (error) {
    //   // handle error here.
    // });


    initStoreInfo();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {

    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  initStoreInfo() async {
    // ProductDetailsResponse productDetailResponse =
    // await _connection.queryProductDetails(_productIds);
    // if (productDetailResponse.error == null) {
    //   setState(() {
    //     _products = productDetailResponse.productDetails;
    //   });
    // }

  }

  // _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  //   purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
  //     if (purchaseDetails.status == PurchaseStatus.pending) {
  //       // show progress bar or something
  //     } else {
  //       if (purchaseDetails.status == PurchaseStatus.error) {
  //         // show error message or failure icon
  //       } else if (purchaseDetails.status == PurchaseStatus.purchased) {
  //         // show success message and deliver the product.
  //         Navigator.of(context).push(MaterialPageRoute(
  //                  builder: (context) => Hunt()));
  //       }
  //     }
  //   });
  // }

  _buyProduct() {
    // print("buy");
    // final PurchaseParam purchaseParam =
    // PurchaseParam(productDetails: _products[0]);
    // _connection.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
  }


  setZero() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('count', 1);
  }

  ///shows the about dialog.
  showAbout(BuildContext context) {
    final TextStyle linkStyle =
    Theme
        .of(context)
        .textTheme
        .bodyText1
        .copyWith(color: Colors.blue);
    final TextStyle bodyStyle =
    new TextStyle(fontSize: 15.0, color: Colors.black);

    return showAboutDialog(
        context: context,
        applicationIcon: Center(
          child: Image(
            height: 150.0,
            width: 200.0,
            fit: BoxFit.fitWidth,
            //  image: AssetImage("assets/images/logo.png"),
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
                        text: 'This app is a treasure hunt designed for use at Rufford Country park' +
                            ' built by Tag With Me '
                                "\n\n"),
                    new TextSpan(
                      style: bodyStyle,
                      text: 'For enquiries:' + "\n\n",
                    ),
                    new _LinkTextSpan(
                        style: linkStyle,
                        text: 'Send an E-mail' + "\n\n",
                        url:
                        'mailto:tagwithmeapp@gmail.com?subject=App enquiry'),
                  ]))),
        ]);
  }

  ///Lis-t of interview questions.
  Widget getListItems(Color color, IconData icon, String title, String link) {
    return GestureDetector(
        key: title == 'Behavioural Based' ? Key('item') : null,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: color
          ),
          height: 180.0,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 100.0,
                    color: Colors.white,
                  ),
                  Text(
                    title,
                    style: Style.headerstyle,
                  )

                ],
              )),
        ),
        onTap: () {
          if (link == "hunt") {
            print("tapped");
            //  checkdate();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Hunt()));
          }
          if (link == "info") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Info()));
          }
          if (link == "map") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Mapscreen()));
          }
          if (link == "guide") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage()));
          }
          if (link == "rewards") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Rewards()));
          }
          if (link == "surveys") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Surveys()));
          }
          if (link == "help") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IntroScreen()));
          }

          //  _buyProduct();
          //    Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => Hunt()));
        });
  }


  Future<void> checkdate() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String SPdate = (prefs.getString('date') ?? "NA");
    // if (formattedDate == SPdate){
    //   Navigator.of(context).push(MaterialPageRoute(
    //              builder: (context) => Hunt()));
    // }
    // else{
    //   _buyProduct();
    // }
  }

  ///creating a carousel using carousel pro library.
  final myCraousal = Carousel(
    dotSize: 1.0,
    dotIncreaseSize: 2.0,
    borderRadius: true,
    radius: Radius.circular(1.0),
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(seconds: 1),
    images: [
      AssetImage('assets/images/card1.jpg'),
      AssetImage('assets/images/card2.jpg'),
      AssetImage('assets/images/card3.jpg'),
      AssetImage('assets/images/card4.jpeg'),

    ],
  );


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;

    //to use reside menu library we have to return a residemenu scafford.
    //  return
//     new ResideMenu.scafford(
//
//       direction: ScrollDirection.LEFT,
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
      //  backgroundColor: Color(0xFFbad5b8),
      appBar: new AppBar(
        elevation: 10.0,
        centerTitle: true,
        backgroundColor: Color(0xFF546062),
        automaticallyImplyLeading: false,
        // leading: new GestureDetector(
        //   child: const Icon(
        //     Icons.menu,
        //     color: Colors.white,
        //   ),
        //   onTap: () {
        //     _menuController.openMenu(true);
        //   },
        // ),
        title: new Text(
          'Tag In The Park - Rufford',
          style: TextStyle(color: Colors.white),
        ),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(
        //         Icons.info,
        //         color: Colors.white,
        //         size: 20.0,
        //       ),
        //       onPressed: () => showAbout(context))
        // ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            key: Key('banner'),
            padding: EdgeInsets.only(bottom: 5.0),
            height: height / 2.5,
            child: myCraousal,
          ),
          getListItems(Color(0xFF4974a5), Icons.map_rounded, 'Start Game', "hunt"),
          getListItems(Color(0xFF419AE3), Icons.assignment, 'Feedback survey', "surveys"),
          getListItems(Color(0xFF699b66), Icons.book, 'Guide', "guide"),
          //    if(false)getListItems(Color(0xFF419AE3), Icons.monetization_on, 'Rewards', "rewards"),
          getListItems(Color(0xFFbf3f4c), Icons.pin_drop, 'Map', "map"),
          getListItems(Color(0xFF4aaaaa), Icons.help_outline, 'Tutorial', "help"),
          getListItems(Color(0xFF7a49a5), Icons.info, 'Info', "info"),
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';

import 'package:rufford/ui/home/home_page.dart';
import 'home.dart';



void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  runApp(Main());
}

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Josefin Sans'),
      home: Home(),
    );
  }


}


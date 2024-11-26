import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'camerascreen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetectScreen extends StatefulWidget {
  final List<CameraDescription> cameras;


  final String title = "test";




  DetectScreen(this.cameras, this.name);
  final String name;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DetectScreen> {
  String predOne = '';
  String find = "";
  double percent = 0.0;
  bool once = true;

  double _height;
  double _width;

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
  }

  loadTfliteModel() async {
    String res;
    res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt");
    print(res);
  }

  setRecognitions(outputs) {
    setState(() {
      for(var i = 0; i < outputs.length; i++){
        if(outputs[i]['label'] == find){

          double test = double.parse((outputs[i]['confidence']).toStringAsFixed(3));
          test = test*100;
          percent = test;
          predOne = "Detection accuracy: " + test.toString() + "%";

           if(test > 85) {
             if (once){
               once = false;
               Future.delayed(const Duration(milliseconds: 2000), () {
                 Navigator.pop(context);
                 // dispose();

               });
             }

           }

        }
      }


    });
  }


  @override
  Widget build(BuildContext context) {
    find = widget.name;
    return Scaffold(
      appBar: new AppBar(
        elevation: 10.0,
        centerTitle: true,
        backgroundColor: Colors.white,
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
          'Camera game',
          style: TextStyle(color: Colors.black),
        ),
      ),
  //    backgroundColor: Colors.blueGrey,

      body: Stack(
        children: [
          Camera(widget.cameras, setRecognitions),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 250.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 20.0)],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Find $find",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(left:30,right:30),
                    alignment:Alignment.center,
                    child: LinearPercentIndicator( //leaner progress bar
                      animation: false,
                      animationDuration: 0,
                      lineHeight: 20.0,
                      percent:percent/100,
                      // center: Text(
                      //   percent.toString() + "%",
                      //   style: TextStyle(
                      //       fontSize: 12.0,
                      //       fontWeight: FontWeight.w600,
                      //       color: Colors.black),
                      // ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green[800],
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$predOne",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
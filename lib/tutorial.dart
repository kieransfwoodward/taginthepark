import 'package:flutter/material.dart';

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}


class IntroScreenState extends State<IntroScreen> {
 List<Slide> slides = [];

 @override
 void initState() {
   super.initState();
   checkFirstSeen();
   slides.add(
     new Slide(
       title: "Tag in the park",
       description: "An interactive proximity based game that offers challenges, quizzes and rewards while walking around an outdoor park. \n\n To complete the challenges you need to visit a designated locations at Rufford Country Park called Tag In the Park game zones.",
        pathImage: "assets/icon/logo3.png",
       backgroundColor: Color(0xfff5a623),
         styleDescription: TextStyle(
           color: Colors.white,
             fontSize: 24.0,),
     ),
   );
   slides.add(
     new Slide(
       title: "Treasure hunt",
       description: "Walk around the park and visit all of the different Tag in The Park game zones. Visit the zones and complete the fun challenge or quiz to earn rewards linked to each location. ",
        pathImage: "assets/images/walking.png",
       backgroundColor: Color(0xff203152),
       styleDescription: TextStyle(
         color: Colors.white,
         fontSize: 24.0,),

     ),
   );
   slides.add(
     new Slide(
       title: "Camera Game",
       description: "For the AI camera game you need to point your camera at the special objects (e.g. sculpture or status) to allow the algorithm to recognise it.",
        pathImage: "assets/images/camera.png",
       backgroundColor: Color(0xfff5a623),
       styleDescription: TextStyle(
         color: Colors.white,
         fontSize: 24.0,),
     ),
   );
   slides.add(
     new Slide(
       title: "Tag me Game",
       description: "Some locations will trigger a request to scan a tag with your phone to complete this location to your list of visited park zones. ",
       pathImage: "assets/images/tag.png",
       backgroundColor: Color(0xff203152),
       styleDescription: TextStyle(
         color: Colors.white,
         fontSize: 24.0,
       ),
     ),
   );
   slides.add(
     new Slide(
       title: "Multiple Choice Quiz",
       description:
       "Some locations will offer Multiple Choice Quizes to complete the challenges to be added to the list of visited park zones.",
        pathImage: "assets/images/quiz.png",
       backgroundColor: Color(0xff9932CC),
       styleDescription: TextStyle(
         color: Colors.white,
         fontSize: 24.0,),
     ),
   );
   // slides.add(
   //   new Slide(
   //     title: "Earn Rewards",
   //     description: "Collect points to earn rewards",
   //      pathImage: "assets/images/prize.png",
   //     backgroundColor: Color(0xfff5a623),
   //     styleDescription: TextStyle(
   //       color: Colors.white,
   //       fontSize: 24.0,),
   //   ),
   // );


 }


 Future checkFirstSeen() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setBool('seen', true);
 }


 void onDonePress() {
   // Do what you want
   Navigator.of(context).push(MaterialPageRoute(
       builder: (context) => Home()));
 }

 @override
 Widget build(BuildContext context) {
   return new IntroSlider(
     slides: this.slides,
     onDonePress: this.onDonePress,
   );
 }
}
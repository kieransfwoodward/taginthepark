// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import "package:latlong/latlong.dart"
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlutterMap(
//         options: MapOptions(
//           center: new LatLng(51.5, -0.09),
//           zoom: 16.0,
//           minZoom: 10,
//         ),
//         layers: [
//           new TileLayerOptions(
//             urlTemplate:
//             'https://api.mapbox.com/styles/v1/kieranwoodward/ckq0n76cf02dy17qhukha7q29/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2llcmFud29vZHdhcmQiLCJhIjoiY2txMG13b2s0MDVlNDJvcDh1bXlqemJiZyJ9.M0CsTj_53Aic8mucZkOFXQ',
//             additionalOptions: {
//               'accessToken': 'pk.eyJ1Ijoia2llcmFud29vZHdhcmQiLCJhIjoiY2txMG13b2s0MDVlNDJvcDh1bXlqemJiZyJ9.M0CsTj_53Aic8mucZkOFXQ',
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
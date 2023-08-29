import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';



import 'package:flutter/material.dart';
import 'package:google_map_demo/screens/home_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
  
//   static final LatLng _kMapCenter =
//       LatLng(37.4219983, -122.084);
//   static final CameraPosition _kInitialPosition =
//       CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0.0, bearing: 0.0);
//   @override
//   Widget build(BuildContext context) {
//     var onMapCreated;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: _kInitialPosition,
//         onMapCreated: (controller) => _kMapCenter,
//          mapType: MapType.terrain,
//         myLocationEnabled: true,
//       ),
//     );
//   }
// }
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
  
//   @override 
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   LatLng _initialcameraposition = LatLng(17.387140, 78.491684);
//   late GoogleMapController _controller;
//   Location _location = Location();

//   void _onMapCreated(GoogleMapController _cntlr)
//   {
//     _controller = _cntlr;
//     _location.onLocationChanged.listen((l) { 
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng( l.latitude!, l.longitude!),zoom: 0),
//           ),
//       );
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: CameraPosition(target: _initialcameraposition),
//               mapType: MapType.normal,
//               onMapCreated: _onMapCreated,
//               myLocationEnabled: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  
// }

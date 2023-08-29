import 'package:flutter/material.dart';
import 'package:google_map_demo/screens/current_location.dart';
import 'package:google_map_demo/screens/polyline_screen.dart';
import 'package:google_map_demo/screens/search_location.dart';
import 'package:google_map_demo/simple_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen
 extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key:key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Maps"),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const SimpleMap();
              } ));
              
            }, child: const Text("Simple Map")),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const CurrentLocation();
              } ));
              
            }, child: const Text("Current Location Map")),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return  const SearchLocation();
              } ));
              
            }, child: const Text("Search Location")),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return  const PolylineScreen();
              } ));
              
            }, child: const Text("Polyline")),
            // ElevatedButton(onPressed: (){
            //   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            //     return  const LocationPage();
            //   } ));
              
            // }, child: const Text("User Current Location")),
            // ElevatedButton(onPressed: (){
            //   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            //     return  const UserCurrentLocation();
            //   } ));
              
            // }, child: const Text("Auto Search Location"))

          ],
        ),
      ),
    );
  }
}
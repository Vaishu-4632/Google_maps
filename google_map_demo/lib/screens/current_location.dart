import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
   Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(17.387140, 78.491684), zoom: 14);

  final List<Marker> _marker = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
      position: LatLng(20.42796133580664, 75.885749655962),
      infoWindow: InfoWindow(
        title: 'My Position',
      )
  ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Location Map"),
      ),
      body: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          markers: Set<Marker>.of(_marker),
          zoomControlsEnabled: true,
          mapType: MapType.terrain,
          myLocationButtonEnabled: true,
          compassEnabled: true,

          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async{
            // Position position = await _currentPosition();
            // googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude),zoom: 14)));
            // markers.clear();
            // markers.add( Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));
            // setState(() {
              
            // });
            _currentPosition().then((value) async {
            print(value.latitude.toString() +" "+value.longitude.toString());
 
            // marker added for current users location
            _marker.add(
                Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(
                    title: 'My Current Location',
                  ),
                )
            );
 
            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );
 
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {
            });
          });
          }, label: const Icon(Icons.local_activity)),
    );

  }
  Future<Position> _currentPosition() async{
  //    await Geolocator.requestPermission().then((value){
  //   }).onError((error, stackTrace) async {
  //     await Geolocator.requestPermission();
  //     print("ERROR"+error.toString());
  //   });
  //   return await Geolocator.getCurrentPosition();
  // }
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error("Location service disabled");
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("permission denied");
      }
    } 
    if(permission == LocationPermission.deniedForever){
      return Future.error("permission are perminantely denied");
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}

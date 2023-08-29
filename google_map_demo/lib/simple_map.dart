import 'dart:async';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatefulWidget {
  const SimpleMap({Key? key}) : super(key: key);

  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  void initState() {
    myCurrentLocation();
    super.initState();
  }

  final Completer<GoogleMapController> _controller = Completer();
  static final LatLng _kMapCenter = LatLng(17.387140, 78.491684);
  static final CameraPosition _kInitialPosition = CameraPosition(
      target: _kMapCenter, zoom: 11.0, tilt: 60.0, bearing: 192.0);
  static final CameraPosition _targetPosition = CameraPosition(
      target: LatLng(19.018255973653343, 72.84793849278007),
      zoom: 11.0,
      tilt: 60.0,
      bearing: 192.0);
  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: const MarkerId("marker_1"),
          position: _kMapCenter,
          infoWindow: const InfoWindow(title: 'Marker 1'),
          rotation: 90),
      const Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(17.387140, 78.491684),
      ),
    };
  }
  // Set<Circle> _createCircle() {
  //   return {
  //     Circle(
  //       circleId: CircleId('1'),
  //       consumeTapEvents: true,
  //       strokeColor: Colors.teal,
  //       fillColor: Colors.blue.withOpacity(0.2),
  //       strokeWidth: 2,
  //       center: _kMapCenter,
  //       radius: 5000,
  //     ),
  //     Circle(
  //       circleId: CircleId('2'),
  //       consumeTapEvents: true,
  //       strokeColor: Colors.teal,
  //       fillColor: Colors.blue.withOpacity(0.2),
  //       strokeWidth: 2,
  //       center: LatLng(18.997962200185533, 72.8379758747611),
  //       radius: 6000,
  //     ),
  //   };
  // }
  void onCameraMove(CameraPosition cameraPosition) {
    debugPrint('$cameraPosition');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Map"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
        onMapCreated: (controller) => _kMapCenter,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        buildingsEnabled: true,
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        onCameraMove: onCameraMove,
      ),
      
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            getLocation();
          },
          label: Icon(Icons.directions_bike)),
    );
  }

  Future<void> getLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kInitialPosition));
  }

  late LocationData currentLocation;
  var location = Location();

  myCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();
      print("locationLatitude: ${currentLocation.latitude.toString()}");
      print("locationLongitude: ${currentLocation.longitude.toString()}");
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        String error = 'Permission denied';
        print(error);
      }
      currentLocation = currentLocation;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';



class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

 class _SearchLocationState extends State<SearchLocation> {

  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();
  List<Marker> markersList = [];
  final String key = "AIzaSyDDtjpcdPVWb4RFhRK7e2K9awAGE9Fs-dY";
  final LatLng _center = const LatLng(
      45.4654219, 9.1859243); //milan coordinates -- default location
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyDDtjpcdPVWb4RFhRK7e2K9awAGE9Fs-dY");
  

  late PlaceDetails search;

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<void> displayPrediction(Prediction p) async {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(
        p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    setState(() {
      search = detail.result;
      searchController.text = detail.result.name;
      Marker marker = Marker(
          markerId: MarkerId(''),
          draggable: false,
          infoWindow: InfoWindow(
            title: "Search Location",
          ),
          onTap: () {
          },
          position: LatLng(lat, lng)
      );
      markersList.add(marker);
    });

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lng),
        zoom: 10.0
    )));
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: Set.from(markersList),
          ),
          Positioned(
              top: 10.0,
              right: 15.0,
              left: 15.0,
              child: Column(
                children: <Widget>[
                  Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white
                      ),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: const InputDecoration(
                                hintText: 'Search Location',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15.0, top: 15.0),
                                  icon: Icon(Icons.search),
                            ),
                            controller: searchController,
                            onTap: () async {
                              Prediction? p = await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey: key,
                                  mode: Mode.overlay,
                                  language: "en",
                                  components: [
                                    Component(Component.country, "en")
                                  ]);
                              displayPrediction(p!);
                            },
                          ),
                        ],
                      )
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  computePath()async{
    LatLng origin = LatLng(search.geometry!.location.lat, search.geometry!.location.lng);
  }}
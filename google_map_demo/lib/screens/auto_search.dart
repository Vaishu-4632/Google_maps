import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class AutoSearch extends StatefulWidget {
   const AutoSearch({super.key});

  // final String title;

  @override
  _AutoSearchState createState() => _AutoSearchState();
}

class _AutoSearchState extends State<AutoSearch> {
  var _controller = TextEditingController();
  var uuid = new Uuid();
   String? _sessionToken;
  List<dynamic> _placeList = [];
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(27.6602292, 85.308027); 
  String location = "Search Location"; 

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kplacesApiKey = "AIzaSyDDtjpcdPVWb4RFhRK7e2K9awAGE9Fs-dY";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }
  // late final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AutoComplete"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Seek your location here",
                  focusColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: Icon(Icons.map),
                  // suffixIcon: IconButton(
                  //   icon: Icon(Icons.cancel),
                  // ),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_placeList[index]["description"]),
                );
              },
            ),
            GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: startLocation, //initial position
                    zoom: 14.0, //initial zoom level
                  ),
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) { //method called when map is created
                    setState(() {
                      mapController = controller; 
                    });
                  },
                  
             ),
          ],
        ),
      ),
    );
  }
}
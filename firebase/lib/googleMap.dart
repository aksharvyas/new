import 'dart:async';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert' as convert;

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => GoogleMapsState();
}

class GoogleMapsState extends State<GoogleMaps> {
  final search = TextEditingController();
  List<LatLng> points = [
    LatLng(19.0759837, 72.8776559),
    LatLng(28.679079, 77.069710),
  ];
  Location currentLocation = Location();
  GoogleMapController? controller;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> _markers = {};
  Set<Circle> _circle = {};
  Set<Polygon> _polygon = {};
  Set<Polyline> _polyline = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    _polyline.add(Polyline(polylineId: PolylineId(''), points: points));
    _polygon.add(Polygon(
      // given polygonId
      polygonId: PolygonId('1'),
      // initialize the list of points to display polygon
      points: points,
      // given color to polygon
      fillColor: Colors.green.withOpacity(0.3),
      // given border color to polygon
      strokeColor: Colors.green,
      geodesic: true,
      // given width of border
      strokeWidth: 4,
    ));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.0759837, 72.8776559),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker _kGooglePlexMarker = const Marker(
      markerId: MarkerId('_kGooglePlex'),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: "Location"),
      position: LatLng(37.43296265331129, -122.08832357078792));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: const Icon(
            Icons.my_location,
            size: 25,
          ),
          icon: null,
          onPressed: getLocation,
        ),
        appBar: AppBar(
          title: Text("Google Maps"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              TextField(
                controller: search,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    getPlaceId(search.text);
                    getPlace(search.text);
                    setState(() {

                    });
                  },
                )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: GoogleMap(
                  indoorViewEnabled: true,
                  onCameraMove: null,
                  mapType: MapType.normal,
                 // polygons: _polygon,
                 polylines: _polyline,
                  circles: _circle,
                  markers: _markers,
                  zoomControlsEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controllers) {
                    controller = controllers;
                  },
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) async {
      await controller
          ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        // tilt: 59.440717697143555,
        zoom: 15.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        points[0] = LatLng(loc.latitude!, loc.longitude!);
      });

      _markers.add(Marker(
        markerId: const MarkerId('Home'),
        position: points[1],
        icon: BitmapDescriptor.defaultMarker,
        visible: true,
      ));
      _circle.add(Circle(
          circleId: const CircleId('Home'),
          center: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
          radius: 25,
          strokeWidth: 5,
          fillColor: Colors.white,
          strokeColor: Colors.blue,
          visible: true));
    });
    setState(() {});
  }

  Future<String> getPlaceId(String input) async {
    final String key = "AIzaSyBgZpYXzr4O9NX0utR_EwjrnduijYpOBTA";
    String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key";
    final response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    String placeid = await getPlaceId(input);
    final String key = "AIzaSyBgZpYXzr4O9NX0utR_EwjrnduijYpOBTA";
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$key";
    final response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;
    print(results);
    points[0]=LatLng(results['geometry']['location']['lat'], results['geometry']['location']['lng']);
    _polyline.clear();
    _polyline.add(Polyline(polylineId: PolylineId(''), points: points, jointType: JointType.bevel));
    // print(results['geometry']['location']['lat']);
    currentLocation.onLocationChanged.listen((LocationData loc) async {


    await controller
        ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(results['geometry']['location']['lat'],results['geometry']['location']['lng']),
      // tilt: 59.440717697143555,
      zoom: 15.0,
    )));

    setState(() {
      points[1] = LatLng(results['geometry']['location']['lat'],results['geometry']['location']['lng']);
    });

    _markers.add(Marker(
      markerId: const MarkerId('Home'),
      position: points[1],
      icon: BitmapDescriptor.defaultMarker,
      visible: true,
    ));
    _circle.add(Circle(
        circleId: const CircleId('Home'),
        center: LatLng(results['geometry']['location']['lat'],results['geometry']['location']['lng']),
        radius: 25,
        strokeWidth: 5,
        fillColor: Colors.white,
        strokeColor: Colors.blue,
        visible: true));});
    return results;
  }
}

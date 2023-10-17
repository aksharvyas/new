import 'dart:async';
import 'dart:typed_data';

import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/model/list_patients_model.dart';
import 'package:fitness_ble_app/src/app/screen/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

import 'ble_listing_page.dart';

class GoogleMapPage extends StatefulWidget {
  ListPatientsData addPatientModel;
  GoogleMapPage(this.addPatientModel);
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  //Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _controller;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  String googleAPIKey = "AIzaSyD65V_vIOHSfoXXIZlir5EnqJfN5BMqtHs";
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  late StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  late Marker marker;
  late Circle circle;

  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
    permissionRequest();
  }
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/images/markerpoint.png");
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/images/markerpoint.png");
  }

  permissionRequest()async{
   var statuses = await [
    Permission.storage,
        Permission.location,
    Permission.locationAlways,
    Permission.locationWhenInUse,
    ].request();
    print("$statuses");
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () async {},
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(appBarPng),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "${widget.addPatientModel.firstName} ${widget.addPatientModel.lastName} recording on",
          style: appbarTextStyle,
        ),
        //centerTitle: true,
        leadingWidth: 25,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Image.asset(
              backButtonPng,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .6,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                 myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  mapToolbarEnabled: true,
                  compassEnabled: true,
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: _markers,
                  polylines: _polylines,
                  onCameraMove: (CameraPosition cameraPosition){
                    //print("${cameraPosition.target}");
                  },
                  onTap: (l){
                    print("${l.latitude} ${l.longitude}");
                  },
                  onMapCreated: (GoogleMapController controller) {
                    //_controller.complete(controller);
                    setState(() {
                      setMapPins();
                      setPolylines();
                      getCurrentLocation();
                    });

                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("75 bpm",style: cardTextStyle.copyWith(fontSize: 18,color: Colors.blue),),
                          VerticalDivider(thickness: 4,color: Colors.blue,indent: 2,endIndent: 6,),
                          Text("8 mph",style: cardTextStyle.copyWith(fontSize: 18,color: Colors.blue))],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),

          Positioned.fill(
            top: MediaQuery.of(context).size.height * .4 - (100 / 2), // (background container size) - (circle height / 2)
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 90,
                width: 90,
                child: Image.asset(googleMapRecordButtonPng)
              ),
            ),
          )


        ],
      ),
    );
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId("sourcePin"),
          position: SOURCE_LOCATION,
          icon: sourceIcon
      ));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId("destPin"),
          position: DEST_LOCATION,
          icon: destinationIcon
      ));
    });
  }

   LatLng SOURCE_LOCATION = LatLng(23.072477349907146, 72.5170236825943);
   LatLng DEST_LOCATION = LatLng(23.06908180864413, 72.51496374607086);
  setPolylines() async {

    PolylineResult result =  await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
          PointLatLng( SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude),
          PointLatLng(DEST_LOCATION.latitude,
        DEST_LOCATION.longitude));
     print("PolylineResult ${result.points}");
    if(result.points.isNotEmpty){
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      print("result polylineresult $result");
      result.points.forEach((PointLatLng point){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    polylineCoordinates.add(LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude));
    polylineCoordinates.add(LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude));
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          visible: true,
          width: 12,
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap
      );

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      print("polyline ${polyline.points}");
      _polylines.add(polyline);
    });
  }
  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/markerpoint.png");
    return byteData.buffer.asUint8List();
  }

  setPolyLinesDraw(){
    setState(() {
      //polylineCoordinates.add(LatLng(s.latitude,s.longitude));
      //polylineCoordinates.add(LatLng(d.latitude,d.longitude));
      polylineCoordinates.add(LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude));
      polylineCoordinates.add(LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude));
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          visible: true,
          width: 12,
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap
      );

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      print("polyline ${polyline.points}");
      _polylines.add(polyline);
    });

  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
   setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading!,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy!,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      print("imageData $imageData");
      var location = await _locationTracker.getLocation();
      SOURCE_LOCATION = LatLng(location.latitude!,location.longitude!);
      updateMarkerAndCircle(location, imageData);
      print("get $location ");
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        print("newLocalData $newLocalData ");
        setState(() {
          DEST_LOCATION = LatLng(newLocalData.latitude!,newLocalData.longitude!);
          print(" if newLocalData $newLocalData ");
          setPolyLinesDraw();

        _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
              tilt: 0,
              zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        });
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }


}

///https://stackoverflow.com/questions/51351257/flutter-profile-page-with-cover-image-and-avatar
///
///
///


/*
class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  GoogleMapController mapController;
  double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  double _destLatitude = 6.849660, _destLongitude = 3.648190;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyD65V_vIOHSfoXXIZlir5EnqJfN5BMqtHs";

  @override
  void initState() {
    super.initState();
    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin", BitmapDescriptor.defaultMarker);
    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination", BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude),
                zoom: 15
            ),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            onCameraMove: (CameraPosition cameraPosition){
              print("${cameraPosition.target}");
            },
            onTap: (l){
              print("${l.latitude} ${l.longitude}");
            },
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          )
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async
  {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor)
  {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine()
  {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red, points: polylineCoordinates
    );
    polylines[id] = polyline;
    setState(() {
    });
  }

  _getPolyline()async
  {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng (_destLatitude, _destLongitude));
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point){
        print("points ${point.latitude}, ${point.longitude}");
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

}*/

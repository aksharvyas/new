import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:fitness_ble_app/src/app.dart';
import 'package:fitness_ble_app/src/app/screen/bloc/GlobalBloc.dart';
import 'package:fitness_ble_app/src/app/screen/bloc/bloc_provider.dart';
import 'package:fitness_ble_app/src/app/screen/const_string.dart';
import 'package:fitness_ble_app/src/app/screen/pages/ble_listing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // BackgroundIsolateBinaryMessenger.ensureInitialized();


  runApp(MyApp());
  Timer.periodic(Duration(minutes: 1),(timer) {
    backgroundTask();
  },);
  // startBackgroundTask();
}
// void startBackgroundTask() async{
//   ReceivePort geekReceive= ReceivePort();
//   await Isolate.spawn(backgroundTask, geekReceive.sendPort); // You can pass data via the second argument if needed.
// }
void backgroundTask()async{

    print("upload csv called"+await DateFormat('HH:mm:ss').format(DateTime.now()));
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/myCsv.csv';
    File file = File(path );
    if(await file.exists()){
      BLEListingPageState bleListingPageState = BLEListingPageState();
      await bleListingPageState.uploadCsvOnAPI(file);
  }}





class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: GlobalBloc(),
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitness App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: Arial_Rounded_Mt,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
       home: FitnessApp(),
        //home: BarChartSample2(),
        //home: FlutterBlueApp(),
      ),
    );
  }
}



class Log{
 static logs(String str){
    log(str);
  }
}


/*

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MapScreen(),
));

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  double _originLatitude = 26.48424, _originLongitude = 50.04551;
  double _destLatitude = 26.46423, _destLongitude = 50.06358;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyAX8TRG8tk_8GbXhqER_4eTc30HDdsUaRc";

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude), zoom: 15),
            myLocationEnabled: true,
            rotateGesturesEnabled: true,

            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _getPolyline();
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAX8TRG8tk_8GbXhqER_4eTc30HDdsUaRc",
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        print("points ${point.latitude} ${point.longitude}");
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}*/

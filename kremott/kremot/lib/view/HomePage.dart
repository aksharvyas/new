import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:kremot/data/remote/network/ApiEndPoints.dart';
import 'package:kremot/data/remote/network/NetworkApiService.dart';
import 'package:kremot/global/storage.dart';
import 'package:kremot/models/LightItem.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kremot/models/PlacesWithOwnerPermissionsModel.dart';
import 'package:kremot/models/SceneItem.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:kremot/utils/Constants.dart';
import 'package:kremot/view/widgets/DialogCloseButton.dart';
import 'package:kremot/view/widgets/DialogTitle.dart';
import 'package:kremot/view/widgets/DialogCenterButton.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:kremot/view/widgets/homepage/HomePageDrawer.dart';
import 'package:kremot/view/widgets/homepage/HomePageRoomsList.dart';
import 'package:kremot/view/widgets/homepage/HomePageScenesList.dart';
import 'package:kremot/view/widgets/homepage/HomePageSelectPlaceList.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/RoomsVM.dart';
import 'package:location/location.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:number_system/number_system.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import '../models/FanItem.dart';
import '../models/IndicatorModel.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../models/SwitchCmacModel.dart';
import '../models/SwitchModel.dart';
import '../models/blesh.dart';
import '../models/deviceModel.dart';
import '../models/updateRoomCmacSwitch.dart';
import '../protocol/DeviceSwitchInfo.dart';
import '../res/AppColors.dart';
import '../res/AppDimensions.dart';
import '../test.dart';
import '../utils/Utils.dart';
import '../view_model/HomeVM.dart';
import '../view_model/PlacesWithOwnerPermissionsVM.dart';
import '../view_model/ScenesVM.dart';
import 'widgets/homepage/HomePagePairing.dart';
import 'widgets/homepage/HomePagePlacesList.dart';
import 'package:convert/convert.dart';
import 'package:restart_app/restart_app.dart';

class HomePage extends StatefulWidget {
  final NordicNrfMesh nordicNrfMesh;
  HomePage(
    this.nordicNrfMesh, {
    Key? key,
  }) : super(key: key);

  // final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  // final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool? showLoader = false;

  final ScrollController listController = ScrollController();
  final AutoScrollController controller = AutoScrollController();
  final AutoScrollController controllerIR = AutoScrollController();
  final AutoScrollController controllerSwitch = AutoScrollController();
  late List<Widget> items = [];
  late List<Widget> itemsIR = [];
  late List<Widget> itemsSwitch = [];
  late List<Widget> itemsHomeRemotePlaces = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentFocusedIndex = 0;
  AutoScrollController controllerScene = AutoScrollController();
  FocusNode fan1FocusNode = FocusNode();
  TextEditingController fan1Controller = TextEditingController(text: "FAN 1");
  bool fan1Editable = false;
  bool fan1Renamed = false;
  bool allONEnabled = false;
  bool allOFFEnabled = false;
  bool isFan1Selected = false;
  static bool scenesEnabled = true;
  String homeroom = "";

  String? light;
  bool ex = false;

  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};
  final Map<Guid, List<int>> readValues1 = <Guid, List<int>>{};
  final Map<Guid, List<int>> readValues2 = <Guid, List<int>>{};
  final Map<Guid, List<int>> readValues3 = <Guid, List<int>>{};

  double itemWidth1 = 35.0;
  int itemCount1 = 9;
  int selected1 = 4;
  bool isExpandPair1 = true;
  bool isExpandPair2 = true;
  bool isExpandPair3 = true;
  bool isExpandPair4 = true;
  double extendheight = 438.18;
  double top = 201.99;
  double top1 = 261.82;
  double top2 = 283.34;
  double top3 = 650;
  double top4 = 470.07;
  double top5 = 470.07;
  double top6 = 271.82;
  late double width;
  late double height;

  List<DeviceListViewModel>? deviceListViewModel;
  List<DeviceListViewModel>? deviceListViewModelLocal;

  final List<DeviceSwitchInfo> _deviceSwitchInfo = [];

  List<LightItem> _lightList = [];

  final List<FanItem> _fanList = [];

  final List<SceneItem> sceneItems = [];

  List<SwitchViewModel>? _switchViewModel;
  List<SwitchViewModel>? _switchViewModelLocal;

  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: 1);
  final FixedExtentScrollController _scrollController1 =
      FixedExtentScrollController(initialItem: 1);

  double itemWidth = 35.0;
  int itemCount = 8;
  int selected = 4;

  bool isNonePairedDevice = false;
  bool isFanDevice = false;

  late MqttServerClient client;

  final List<DraggableGridItem> _listOfDraggableGridItem = [];

  //final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  List<BluetoothService> _services = [];

  //final FlutterBluePlus flutterBlueA5 = FlutterBluePlus.instance;
  // final List<BluetoothDevice> devicesListA5 = <BluetoothDevice>[];

  //List<BluetoothService> _servicesA5 = [];

  final HomeVM viewModelHome = HomeVM();

  List<IndicatorItem> _indicatorList = [];

  List<int> intReadSsi = [];

  int? beforeIndex;
  int? afterIndex;

  BluetoothDevice? _device;

  bool isRefersh = false;

  late IndicatorItem indicatorPairDevice;

  late IndicatorItem indicatorAllON;

  late IndicatorItem indicatorAllOF;

  late IndicatorItem indicatorAllMasterOff;

  late IndicatorItem indicatorRoom1;

  late IndicatorItem indicatorRoom2;

  late IndicatorItem indicatorSync;

  //BluetoothDevice? _deviceA5;

  String Room1ID = "HG87FED654CBA123";

  String Room2ID = "HG87FED654CBA321";

  //String Room2ID = "HG87FED654CBA123";
  String RoomID = "";

  List<String> lstQueue = [];
  final List<BluetoothDevice> devicesListA5 = <BluetoothDevice>[];
  bool isStartedPair = false;

  StreamSubscription? _scanSubscription;
  bool isProvisioning = false;
  final _serviceData = <String, Uuid>{};
  final _pdevices = <DiscoveredDevice>{};
  final udevices = <DiscoveredDevice>{};
  bool isScanning = true;

  int? companyIdentifire;
  int? productIdentifire;
  int? versionIdentifire;

  late SharedPreferences prefs;
  late IMeshNetwork? _meshNetwork;
  late final MeshManagerApi _meshManagerApi;
  late final StreamSubscription<IMeshNetwork?> onNetworkUpdateSubscription;
  late final StreamSubscription<IMeshNetwork?> onNetworkImportSubscription;
  late final StreamSubscription<IMeshNetwork?> onNetworkLoadingSubscription;
  final bleMeshManager = BleMeshManager();
  int? elementAddress;

  var lightList = [
    // LightItem('SW 32', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
  ];

  var lightList1 = [
    //
    // LightItem('SW 16', switchUnSelectedImage, false, false, false, false, false,
    //     FocusNode()),
  ];

  final ItemScrollController itemScrollController = ItemScrollController();

  final testArray = [for (var i = 1; i < 9; i++) '$i'];

  bool isPairingVisible = false;
  bool isWithoutPairingVisible = true;

  //double itemWidth1 = fanButtonUnSelectedWidth;
  //int itemCount1 = 8;
  //int selected1 = 2;
  bool isExpandPairTop = false;
  bool isExpandPairBottom = false;
  double extendHeight = 469;

  Timer? topTimer;
  Timer? bottomTimer;

  PlacesWithOwnerPermissionsVM placesWithOwnerPermissionsVM =
      PlacesWithOwnerPermissionsVM();
  RoomsVM roomsVM = RoomsVM();
  ScenesVM scenesVM = ScenesVM();
  final test Test = test();
  // static bool scenesEnabled = true;
  // bool allONEnabled = false;
  // bool allOFFEnabled = false;

  final builder1 = MqttClientPayloadBuilder();

  bool isBLEDeviceConnected = false;
  late var _permissionStatus;
  String get sendTopic => networkId! + "/OPR";
  String get receiveTopic => networkId! + "/RSP";
  bool ak = true;
  bool renameDialogOpened = false;
  String? switches;
  Location location = new Location();
  late bool _serviceEnabled;
  late LocationData _locationData;
  bool startNextDeviceProcess = false;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    print("init start");
    print(_pdevices);
    print(udevices);
    isBLEDeviceConnected ? print(_meshNetwork) : print("null");
    checkInternet();
    checklocation();
    checkBLE();
    checkPermissionStatus();

    Timer.periodic(Duration(seconds: 1), (timer) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? stringValue = prefs.getString('flag');
      print(stringValue);
    });
    getPerfances();

    //loadBLEMesh();
    addDeviceCalled == false ? connect() : null;
    getData();
    RoomID = Room1ID;
    // loadBLEMesh();

    // connectblueDeviceA5();
    getSwitchScene();
    getswitchData();
    //startProcessQueue();

    IndicatorItem indicatorItem = IndicatorItem(
        "Scan", false, Timer(const Duration(milliseconds: 0), () => {}), 0);

    setState(() {
      _indicatorList.add(indicatorItem);
    });

    IndicatorItem indicatorItemDepair = IndicatorItem(
        "DePair", false, Timer(const Duration(milliseconds: 0), () => {}), 0);

    setState(() {
      _indicatorList.add(indicatorItemDepair);
    });

    indicatorPairDevice = IndicatorItem("PAIR DEVICE", false,
        Timer(const Duration(milliseconds: 0), () => {}), 0);

    indicatorAllON = IndicatorItem(
        "ALL ON", false, Timer(const Duration(milliseconds: 0), () => {}), 0);

    indicatorAllOF = IndicatorItem(
        "ALL OFF", false, Timer(const Duration(milliseconds: 0), () => {}), 0);
    indicatorAllMasterOff = IndicatorItem("MASTER OFF", false,
        Timer(const Duration(milliseconds: 0), () => {}), 0);

    indicatorRoom1 = IndicatorItem(
        "Room1", false, Timer(const Duration(milliseconds: 0), () => {}), 0);
    indicatorRoom2 = IndicatorItem(
        "Room2", false, Timer(const Duration(milliseconds: 0), () => {}), 0);

    indicatorSync = IndicatorItem(
        "Sync", false, Timer(const Duration(milliseconds: 0), () => {}), 0);

    _meshManagerApi = widget.nordicNrfMesh.meshManagerApi;
    _meshNetwork = widget.nordicNrfMesh.meshManagerApi.meshNetwork;

    onNetworkUpdateSubscription =
        widget.nordicNrfMesh.meshManagerApi.onNetworkUpdated.listen((event) {
      setState(() {
        _meshNetwork = event;
      });
    });
    onNetworkImportSubscription =
        widget.nordicNrfMesh.meshManagerApi.onNetworkImported.listen((event) {
      setState(() {
        _meshNetwork = event;
      });
    });
    onNetworkLoadingSubscription =
        widget.nordicNrfMesh.meshManagerApi.onNetworkLoaded.listen((event) {
      setState(() {
        _meshNetwork = event;
      });
    });

    String intTo8bitString(int number, {bool prefix = false}) => prefix
        ? '0x${number.toRadixString(2).padLeft(8, '0')}'
        : '${number.toRadixString(2).padLeft(8, '0')}';

    Uint8List hexToUint8List(String hex) {
      if (!(hex is String)) {
        throw 'Expected string containing hex digits';
      }
      if (hex.length % 2 != 0) {
        throw 'Odd number of hex digits';
      }
      var l = hex.length ~/ 2;
      var result = new Uint8List(l);
      for (var i = 0; i < l; ++i) {
        var x = int.parse(hex.substring(i * 2, (2 * (i + 1))), radix: 16);
        if (x.isNaN) {
          throw 'Expected hex string';
        }
        result[i] = x;
      }
      return result;
    }

    print("before listen");

    // if (ex) {
    widget.nordicNrfMesh.meshManagerApi.onGenericLevelStatus.listen((event) {
      print('onGenericLevelStatus Json : ' + event.toJson().toString());
      String returnComand = event.level.decToHex(4);
      print('Hex Data Receivedfffff : ' + returnComand);

      if (returnComand.substring(1, 3).toUpperCase() == '3F' &&
          returnComand.substring(3, 5).toUpperCase() != '3F') {
        print("not called method inside 3f=========================");
        widget.nordicNrfMesh.meshManagerApi
            .sendGenericLevelSet(event.source, 20303)
            .timeout(const Duration(seconds: 2));
      } else if (returnComand.substring(1, 3).toUpperCase() == '4F' &&
          returnComand.substring(3, 5).toUpperCase() != '4F') {
        setEnableElement(event.source.toString());
        print(
            "  not called method inside 4f========================= ${event.source}");
        widget.nordicNrfMesh.meshManagerApi
            .sendGenericLevelSet(event.source, 24415)
            .timeout(const Duration(seconds: 2));
        startNextDeviceProcess = true;
        setMeshData();
      } else if (returnComand.substring(1, 3).toUpperCase() == '3F' &&
          returnComand.substring(3, 5).toUpperCase() == '3F') {
      } else if (returnComand.substring(1, 3).toUpperCase() == '4F' &&
          returnComand.substring(3, 5).toUpperCase() == '4F') {
      } else {
        Uint8List bytes = Uint8List.fromList(
            hexToUint8List(returnComand.substring(1, 5).toUpperCase()));
        String commandCode = intTo8bitString(bytes[1]).substring(0, 4);

        print('commandCode : $commandCode');

//   print("ex is true");
        callCommandsNew(event.source.toString(),
            returnComand.substring(1, 3).toUpperCase(), commandCode);
      }

      setState(() {});
    });
    //}

    getMeshData();
    _initSpeech();
  }

  void getButtonData(TextEditingController conn) async {
    print("get button called" + _lightList.length.toString());
    SharedPreferences renameButton = await SharedPreferences.getInstance();
    for (int i = 0; i < _lightList.length; i++) {
      print("lightlistcount" + _lightList[i].cmIndex.toString());
      if (renameButton.containsKey(_lightList[i].cmIndex.toString()) &&
          _lightList[i].cmIndex == i + 1) {
        _lightList[i].setName(await renameButton
            .getString(_lightList[i].cmIndex.toString())
            .toString());
      }
    }
    ak = false;
    setState(() {});
  }

  void _initSpeech() async {
    await Permission.microphone.request();
    _speechEnabled = await _speechToText.initialize();

    _startListening();
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: Duration(hours: 1),
      localeId: "en_US",
    );

    _speechToText.isNotListening ? _startListening() : _startListening();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    bool okremote = false;
    if (!okremote) {
      setState(() {
        _lastWords = "";
      });
    }
    //_lastWords="remote scene 1";
    bool isSwitch = false;
    bool? isOn;
    if (result.recognizedWords.substring(0, 5) == "remot" &&
        result.recognizedWords.substring(0, 6) != "remote") {
      setState(() {
        _lastWords = _lastWords + result.recognizedWords;
        _lastWords = _lastWords.trim();
      });

      print("speech recognition     ${result.recognizedWords}");
      print("last words if  ${_lastWords.toString()}");
      print("confidence     ${result.confidence}");
      String as = _lastWords.substring(6, _lastWords.length);
      String? switchName;
      print("asssssss    $as");
      if (as.substring(as.length - 2, as.length) == "on") {
        isOn = true;
        switchName = as.substring(0, as.length - 3).toUpperCase();
        setState(() {});
        print("switchNameeeeee" + switchName);
      } else if (as.substring(as.length - 3, as.length) == "off") {
        isOn = false;
        switchName = as.substring(0, as.length - 4).toUpperCase();
        setState(() {});
        print("switchNameeeeee" + switchName);
      } else if (as.substring(as.length - 2, as.length) == "of") {
        isOn = false;
        switchName = as.substring(0, as.length - 3).toUpperCase();
        setState(() {});
        print("switchNameeeeee" + switchName);
      }
      setState(() {});

      for (int i = 0; i < _lightList.length; i++) {
        if (switchName == (_lightList[i].getName()).toUpperCase()) {
          print("switchNameList" + (_lightList[i].getName()).toUpperCase());
          isSwitch = true;
          setState(() {});

          if (isOn == false) {
            onSwitches(_lightList[i], switchName!);
          }

          if (isOn!) {
            onSwitches(_lightList[i], switchName!);
          }
        }
      }
      String scene = _lastWords.substring(6, 13).toUpperCase();

      if (!isSwitch) {
        print("sceneeeeeeee   $scene");
        for (int i = 0; i < sceneItems.length; i++) {
          String command = _lastWords.substring(6, 11);
          if ((command == "Sen ${i + 1}" ||
                  command == "remote scene ${i + 1}") ||
              (scene == sceneItems[i].getName() && command == "on")) {
            HomePageScenesListState homePageScenesListState =
                HomePageScenesListState();
            homePageScenesListState.onScene(i);
            setState(() {
              masterOFFImage = unSelectedButtonImage;
              allONImage = unSelectedButtonImage;
              allOFFImage = unSelectedButtonImage;
            });
          }
        }
      }

      okremote = true;
      setState(() {});
    } else if (result.recognizedWords.substring(0, 6) == "remote") {
      _lastWords = _lastWords + result.recognizedWords;
      _lastWords = _lastWords.trim();
      bool? isOn;
      String? switchName;
      print("speech recognition   ${result.recognizedWords}");
      print("last words else ifff  ${_lastWords.toString()}");
      setState(() {});
      print("confidence    ${result.confidence}");

      String as = _lastWords.substring(7, _lastWords.length);
      print("asssssss" + as);
      if (as.substring(as.length - 2, as.length) == "on") {
        isOn = true;
        switchName = as.substring(0, as.length - 3).toUpperCase();
        setState(() {});
        print("switchNameeeeee" + switchName);
      } else if (as.substring(as.length - 3, as.length) == "off") {
        isOn = false;
        switchName = as.substring(0, as.length - 4).toUpperCase();
        setState(() {});
        print("switchNameeeeee" + switchName);
      } else if (as.substring(as.length - 2, as.length) == "of") {
        isOn = false;
        switchName = as.substring(0, as.length - 3).toUpperCase();

        setState(() {});
        print("switchNameeeeee" + switchName);
      }
      setState(() {});

      for (int i = 0; i < _lightList.length; i++) {
        if (switchName == (_lightList[i].getName()).toUpperCase()) {
          print("switchNameList" + (_lightList[i].getName()).toUpperCase());
          isSwitch = true;

          if (isOn == false) {
            onSwitches(_lightList[i], switchName!);
          }

          if (isOn!) {
            onSwitches(_lightList[i], switchName!);
          }
        }
        setState(() {});
      }
      if (!isSwitch) {
        print("sceneeeeeeee" + _lastWords.substring(7, 14).toUpperCase());
        for (int i = 0; i < sceneItems.length; i++) {
          if (_lastWords.substring(7, 14).toUpperCase() ==
                  sceneItems[i].getName() ||
              _lastWords.substring(7, 12) == "Sen ${i + 1}") {
            HomePageScenesListState homePageScenesListState =
                HomePageScenesListState();
            homePageScenesListState.onScene(i);
          }
        }
      }
    }
    setState(() {
      isSwitch = false;
    });
  }

  void checkPermissionStatus() async {
    _permissionStatus = await Permission.locationWhenInUse.status;
    if (_permissionStatus.isGranted) {
      print("sucessfulley ==-grant");
    } else if (_permissionStatus.isDenied) {
      print("sucessfulley === cancle");
    } else if (_permissionStatus.isPermanentlyDenied) {
      print("sucessfulley == isPermanentlyDenied");
    }
  }

  Future<Widget?> checklocation() async {
    LocationPermissions().serviceStatus.listen((event) async {
      print("event===" + event.name.toString());
      if (event == Permission.location.serviceStatus.isEnabled) {
        print('Location ==== Enabled');
      } else {
        print('Location ==== Disable');
      }
    });
    return null;
  }

  Future<Widget?> checkBLE() async {
    FlutterBluePlus.instance.state.listen((state) {
      if (state == BluetoothState.off) {
        print("Bluetooth is offffffff=========");
      } else if (state == BluetoothState.on) {
        print("Bluetooth is on=========");
      }
    });
  }

  Future<void> checkInternet() async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    print("internet test========" + isConnected.toString());
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            print('interwifi connection is available.');
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            print('interwifi Data not.');
            internetConnection(context, height, width,
                "Please check your internet connection");
            break;
        }
      },
    );
  }

  Future<void> getPerfances() async {
    prefs = await SharedPreferences.getInstance();
  }

  void getSwitchScene() {
    for (int i = 0; i < 8; i++) {
      switch (i) {
        case 0:
          SceneItem sceneItem = SceneItem(
              i + 1,
              "SCENE 1",
              "assets/images/menuitem.png",
              Scene1,
              "10",
              "30",
              Timer(const Duration(milliseconds: 0), () => {}),
              false,
              0);
          setState(() {
            sceneItems.add(sceneItem);
          });
          break;
        case 1:
          SceneItem sceneItem = SceneItem(
              i + 1,
              "SCENE 2",
              "assets/images/menuitem.png",
              Scene2,
              "10",
              "30",
              Timer(const Duration(milliseconds: 0), () => {}),
              false,
              0);
          setState(() {
            sceneItems.add(sceneItem);
          });
          break;
        case 2:
          SceneItem sceneItem = SceneItem(
              i + 1,
              "SCENE 3",
              "assets/images/menuitem.png",
              Scene3,
              "10",
              "30",
              Timer(const Duration(milliseconds: 0), () => {}),
              false,
              0);
          setState(() {
            sceneItems.add(sceneItem);
          });
          break;
        case 3:
          SceneItem sceneItem = SceneItem(
              i + 1,
              "SCENE 4",
              "assets/images/menuitem.png",
              Scene4,
              "10",
              "30",
              Timer(const Duration(milliseconds: 0), () => {}),
              false,
              0);
          setState(() {
            sceneItems.add(sceneItem);
          });
          break;
        case 4:
          SceneItem sceneItem = SceneItem(
              i + 1,
              "SCENE 5",
              "assets/images/menuitem.png",
              Scene5,
              "10",
              "30",
              Timer(const Duration(milliseconds: 0), () => {}),
              false,
              0);
          setState(() {
            sceneItems.add(sceneItem);
          });
          break;
        case 5:
          SceneItem sceneItem = SceneItem(
              i + 1,
              "SCENE 6",
              "assets/images/menuitem.png",
              Scene6,
              "10",
              "30",
              Timer(const Duration(milliseconds: 0), () => {}),
              false,
              0);
          setState(() {
            sceneItems.add(sceneItem);
          });
          break;
        case 6:
          SceneItem sceneItem = SceneItem(
              i + 1,
              "SCENE 7",
              "assets/images/menuitem.png",
              Scene7,
              "10",
              "30",
              Timer(const Duration(milliseconds: 0), () => {}),
              false,
              0);
          setState(() {
            sceneItems.add(sceneItem);
          });
          break;
        case 7:
          SceneItem sceneItem = SceneItem(
              i + 1,
              "SCENE 8",
              "assets/images/menuitem.png",
              Scene8,
              "10",
              "30",
              Timer(const Duration(milliseconds: 0), () => {}),
              false,
              0);
          setState(() {
            sceneItems.add(sceneItem);
          });
          break;
      }
    }
  }

  Future<void> getswitchData() async {
    ResponseDeviceSwitch? responseDeviceSwitch =
        await viewModelHome.deviceList();
    if (responseDeviceSwitch!.value!.meta!.code == 1) {
      print("inside If");
      setState(() {
        deviceListViewModel = responseDeviceSwitch.value!.deviceListViewModel;
      });
      print("==================================*****");
      print(responseDeviceSwitch.toJson().toString());

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? deviceSwitch = await prefs.getString('device_switch');
      print("device Switch" + deviceSwitch.toString());

      if (deviceSwitch == null) {
        // Encode and store data in SharedPreferences
        final String encodedData =
            DeviceListViewModel.encode(deviceListViewModel!);
        await prefs.setString('device_switch', encodedData);

        // Fetch and decode data
        final String? deviceSwitch = await prefs.getString('device_switch');
        setState(() {
          deviceListViewModelLocal = DeviceListViewModel.decode(deviceSwitch!);
        });
      } else {
        final String? deviceSwitch = await prefs.getString('device_switch');
        setState(() {
          deviceListViewModelLocal = DeviceListViewModel.decode(deviceSwitch!);
        });
      }
    }
    ResponseListSwitch? responseListSwitch =
        await viewModelHome.switchListAllType();

    if (responseListSwitch!.value!.meta!.code == 1) {
      print("inside If");
      setState(() {
        _switchViewModel = responseListSwitch.value!.switchViewModel;
      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? switchList = await prefs.getString('switch_type');
      print("switch_type" + switchList.toString());

      if (switchList == null) {
        // Encode and store data in SharedPreferences
        final String encodedData = SwitchViewModel.encode(_switchViewModel!);

        await prefs.setString('switch_type', encodedData);

        // Fetch and decode data
        final String? deviceSwitch = await prefs.getString('switch_type');
        setState(() {
          _switchViewModelLocal = SwitchViewModel.decode(deviceSwitch!);
        });

        print(_switchViewModel!.length.toString());
      } else {
        final String? switchList = await prefs.getString('switch_type');
        setState(() {
          _switchViewModelLocal = SwitchViewModel.decode(switchList);
        });
      }
    }
  }

  void processPairDevice() async {
    try {
      startNextDeviceProcess = false;
      print('Length of Device : ' + udevices.length.toString());
      print("the pairing method is start");
      for (var i = 0; i < udevices.length; i++) {
        print('step 1');
        await provisionDevice(udevices.elementAt(i));
        print('step 2');
        int count = 0;
        const int durations = 20;
        while (!startNextDeviceProcess) {
          await Future.delayed(const Duration(milliseconds: durations), () {});
          if (count * durations > 30000) {
            startNextDeviceProcess = true;
          }
          count = count + 1;
        }

        print("Time checking 4 : " + DateTime.now().toString());
        if (i + 1 == udevices.length) {
        } else {
          try {
            await bleMeshManager.disconnect();
          } catch (eeee) {}
        }

        //setMeshData();
        print('step 31');
        if (i + 1 == udevices.length) {
        } else {
          print('step 3');
        }
        print('step 4');
      }
    } finally {
      //setMeshData();
      udevices.clear();
    }
  }

  void startPairDevice() async {
    await scanUnprovisionned();
    print("Method is called ");
    await Future.delayed(const Duration(milliseconds: 2000), processPairDevice);
    //
  }

  Future<void> provisionDevice(DiscoveredDevice device) async {
    // if (isScanning) {
    //   await _stopScan();
    // }
    // if (isProvisioning) {
    //   return;
    // }
    // isProvisioning = true;
    print("Time checking 1 : " + DateTime.now().toString());
    try {
      String deviceUUID;

      if (Platform.isAndroid) {
        deviceUUID = _serviceData[device.id].toString();
      } else if (Platform.isIOS) {
        deviceUUID = device.id.toString();
      } else {
        throw UnimplementedError(
            'device uuid on platform : ${Platform.operatingSystem}');
      }

      bleMeshManager.disconnect();

      print('Device ID : ' + deviceUUID);
      final provisioningEvent = ProvisioningEvent();

      final provisionedMeshNodeF = widget.nordicNrfMesh
          .provisioning(
            widget.nordicNrfMesh.meshManagerApi,
            bleMeshManager,
            device,
            deviceUUID,
            events: provisioningEvent,
          )
          .timeout(const Duration(minutes: 1));

      unawaited(provisionedMeshNodeF.then((node) async {
        print("Time checking 2 : " + DateTime.now().toString());
        companyIdentifire = null;
        productIdentifire = null;
        versionIdentifire = null;

        node.productIdentifier.then((value) => {productIdentifire = value});
        node.versionIdentifier.then((value) => {versionIdentifire = value});

        print('Provisionning succeed, redirecting to control tab...');
        doNodeProvisionedWithConnect(node, device);
      }).catchError((ee) async {
        print('Provisionning failed : ' + ee.toString());
        await scanUnprovisionned();
        startNextDeviceProcess = true;
      }));
    } catch (e) {
      debugPrint('$e');
      startNextDeviceProcess = true;
    } finally {
      isProvisioning = false;
    }
  }

  Future<void> doNodeProvisionedWithConnect(
      ProvisionedMeshNode node, DiscoveredDevice device) async {
    print("inside the donot method **********************************");
    try {
      companyIdentifire = null;
      productIdentifire = null;
      versionIdentifire = null;

      //  node.companyIdentifier.then((value) => {
      //    companyIdentifire=value
      // });
      node.productIdentifier.then((value) => {productIdentifire = value});
      node.versionIdentifier.then((value) => {versionIdentifire = value});

      print("Time checking 5 : " + DateTime.now().toString());

      bleMeshManager.callbacks = DoozProvisionedBleMeshManagerCallbacks(
          widget.nordicNrfMesh.meshManagerApi, bleMeshManager);
      //
      //   await bleMeshManager.connect(device);

      print('step 11');
      final elements = await node.elements;

      for (final element in elements) {
        print('step 12');
        for (final model in element.models) {
          print('step 13');
          if (model.key == 4098) {
            print('step 14');
            if (model.boundAppKey.isEmpty) {
              print('step 15');
              if (element == elements.first && model == element.models.first) {
                continue;
              }

              print('step 16');
              final unicast = await node.unicastAddress;
              await widget.nordicNrfMesh.meshManagerApi.sendConfigModelAppBind(
                unicast,
                element.address,
                model.modelId,
              );

              print('step 17');

              print("Device Manufacturing Data : " +
                  device.manufacturerData.toString());

              if (!isDeviceAdded(element.address.toString())) {
                debugPrint(
                    ' productIdentifire ' + productIdentifire.toString());
                await getDeviceIdType(productIdentifire.toString(),
                    element.address.toString(), Room1ID, element);
              }

              print('element.address ' + element.address.toString());

              await widget.nordicNrfMesh.meshManagerApi
                  .sendGenericLevelSet(element.address, 16191)
                  .timeout(const Duration(seconds: 2));

              print('step 18');

              try {
                List<GroupData> gdata = await widget
                    .nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;

                await widget.nordicNrfMesh.meshManagerApi
                    .sendConfigModelSubscriptionAdd(
                        element.address, gdata[1].address, model.modelId)
                    .timeout(const Duration(seconds: 10));
                print('step 21');
              } catch (eee) {}

              try {
                print('step 18');
                await widget.nordicNrfMesh.meshManagerApi
                    .sendConfigModelPublicationSet(
                        element.address, 65535, model.modelId)
                    .timeout(const Duration(seconds: 20));
                print('step 20');
              } catch (eee) {}

              try {
                List<GroupData> gdata = await widget
                    .nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;

                await widget.nordicNrfMesh.meshManagerApi
                    .sendConfigModelSubscriptionAdd(
                        element.address, gdata[0].address, model.modelId)
                    .timeout(const Duration(seconds: 1));
                print('step 21');
              } catch (eee) {}

              // widget.nordicNrfMesh.meshManagerApi
              //     .sendConfigModelSubscriptionAdd(
              //     element.address, gdata[0].address, model.modelId);
              // print('step 22');
            } else {
              print('step 19');
              if (!isDeviceAdded(element.address.toString())) {
                debugPrint(
                    ' productIdentifire ' + productIdentifire.toString());
                await getDeviceIdType(productIdentifire.toString(),
                    element.address.toString(), Room1ID, element);
              }
              print('step 23');
              widget.nordicNrfMesh.meshManagerApi.sendConfigModelPublicationSet(
                  element.address, 65535, model.modelId);

              List<GroupData> gdata = await widget
                  .nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;

              print('step 24');
              widget.nordicNrfMesh.meshManagerApi
                  .sendConfigModelSubscriptionAdd(
                      element.address, gdata[1].address, model.modelId);

              print('step 25');
              widget.nordicNrfMesh.meshManagerApi
                  .sendConfigModelSubscriptionAdd(
                      element.address, gdata[0].address, model.modelId);

              print('step 26');
            }
          }
        }
      }
      //startNextDeviceProcess = true;
      print("Time checking 3 : " + DateTime.now().toString());
    } catch (ee) {
      startNextDeviceProcess = true;
    } finally {
      //startNextDeviceProcess = true;
    }
  }

  Future<void> setEnableElement(String cmacID) async {
    for (LightItem lightItem in _lightList) {
      if (lightItem.cmacId == cmacID) {
        lightItem.setSelectd(true);
      }
    }

    for (FanItem fanItem in _fanList) {
      if (fanItem.cmacId == cmacID) {
        fanItem.setSelectd(true);
      }
    }
  }

  Future<void> setMeshData() async {
    final meshNetworkJson =
        await widget.nordicNrfMesh.meshManagerApi.exportMeshNetwork();
    print('meshNetworkJson : ' + meshNetworkJson.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('MeshJsonData', meshNetworkJson.toString());
    print("meshjson" + meshNetworkJson!);
  }

  void checkPermissionStatus1() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        debugPrint('Location Denied once');
      }
    }
  }

  List<ProvisionedMeshNode> _nodes = [];
  List<GroupData> _groups = [];
  //
  // Future<void> getMeshData() async  {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? json = prefs.getString('MeshJsonData');
  //   print('meshNetworkJson : ' + json.toString());
  //   if(json != null && json.isNotEmpty) {
  //     await widget.nordicNrfMesh.meshManagerApi.importMeshNetworkJson(json);
  //     await widget.nordicNrfMesh.meshManagerApi.loadMeshNetwork();
  //     widget.nordicNrfMesh.meshManagerApi.meshNetwork!.nodes.then((value) => setState(() => _nodes = value));
  //     widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups.then((value) => setState(() => _groups = value));
  //
  //     List<GroupData> gdata = await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;
  //
  //     if(gdata.isEmpty){
  //       widget.nordicNrfMesh.meshManagerApi.meshNetwork!.addGroupWithName('HOMEGROUPS');
  //       widget.nordicNrfMesh.meshManagerApi.meshNetwork!.addGroupWithName(Room1ID);
  //     }
  //
  //     await _scanProvisionned();
  //     await  connectWithBLEMeshAll();
  //     await  _scanUnprovisionned();
  //   }
  //   else{
  //     await widget.nordicNrfMesh.meshManagerApi.loadMeshNetwork();
  //     widget.nordicNrfMesh.meshManagerApi.meshNetwork!.nodes.then((value) => setState(() => _nodes = value));
  //     widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups.then((value) => setState(() => _groups = value));
  //     await _scanUnprovisionned();
  //     //await _scanProvisionned();
  //     List<GroupData> gdata = await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;
  //
  //     if(gdata.isEmpty){
  //       widget.nordicNrfMesh.meshManagerApi.meshNetwork!.addGroupWithName('HOMEGROUPS');
  //       widget.nordicNrfMesh.meshManagerApi.meshNetwork!.addGroupWithName(Room1ID);
  //     }
  //   }
  //
  //
  // }
  String? networkId = "";
  Future<void> getMeshData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('MeshJsonData');
    print('meshNetworkJson : ' + json.toString());
    if (json != null && json.isNotEmpty) {
      await widget.nordicNrfMesh.meshManagerApi.importMeshNetworkJson(json);
      await widget.nordicNrfMesh.meshManagerApi.loadMeshNetwork();
      widget.nordicNrfMesh.meshManagerApi.meshNetwork!.nodes
          .then((value) => setState(() => _nodes = value));
      widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups
          .then((value) => setState(() => _groups = value));

      List<GroupData> gdata =
          await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;

      if (gdata.isEmpty) {
        widget.nordicNrfMesh.meshManagerApi.meshNetwork!
            .addGroupWithName('HOMEGROUPS');
        widget.nordicNrfMesh.meshManagerApi.meshNetwork!
            .addGroupWithName(Room1ID);
      }

      await _scanProvisionned();
      await connectWithBLEMeshAll();
      await scanUnprovisionned();

      widget.nordicNrfMesh.meshManagerApi.meshNetwork!.getNetKey(0).then(
          (value) => {networkId = hex.encode(value!.netKeyBytes).toString()});
    } else {
      await widget.nordicNrfMesh.meshManagerApi.loadMeshNetwork();
      widget.nordicNrfMesh.meshManagerApi.meshNetwork!.nodes
          .then((value) => setState(() => _nodes = value));
      widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups
          .then((value) => setState(() => _groups = value));
      await scanUnprovisionned();
      //await _scanProvisionned();
      List<GroupData> gdata =
          await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups;

      widget.nordicNrfMesh.meshManagerApi.meshNetwork!.getNetKey(0).then(
          (value) => {networkId = hex.encode(value!.netKeyBytes).toString()});

      if (gdata.isEmpty) {
        widget.nordicNrfMesh.meshManagerApi.meshNetwork!
            .addGroupWithName('HOMEGROUPS');
        widget.nordicNrfMesh.meshManagerApi.meshNetwork!
            .addGroupWithName(Room1ID);
      }
    }
  }

  // Future<void> getMeshData() async  {
  //
  //     await widget.nordicNrfMesh.meshManagerApi.loadMeshNetwork();
  //     widget.nordicNrfMesh.meshManagerApi.meshNetwork!.nodes.then((value) => setState(() => _nodes = value));
  //     widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups.then((value) => setState(() => _groups = value));
  //     await _scanUnprovisionned();
  //     //await _scanProvisionned();
  //     List<GroupData> gdata = await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;
  //
  //     if(gdata.isEmpty){
  //       widget.nordicNrfMesh.meshManagerApi.meshNetwork!.addGroupWithName('HOMEGROUPS');
  //       widget.nordicNrfMesh.meshManagerApi.meshNetwork!.addGroupWithName(Room1ID);
  //     }
  //
  // }

  Future<void> scanUnprovisionned() async {
    _serviceData.clear();

    udevices.clear();
    await checkAndAskPermissions();
    _scanSubscription =
        widget.nordicNrfMesh.scanForUnprovisionedNodes().listen((device) async {
      if (udevices.every((d) => d.id != device.id)) {
        final deviceUuid = Uuid.parse(widget.nordicNrfMesh.meshManagerApi
            .getDeviceUuid(device.serviceData[meshProvisioningUuid]!.toList()));

        debugPrint('deviceUuid: $deviceUuid');
        _serviceData[device.id] = deviceUuid;
        udevices.add(device);
        //setState(() {});
      }
    });

    isScanning = true;

    return Future.delayed(const Duration(seconds: 2), _stopScan);
  }

  Future<void> _stopScan() async {
    await _scanSubscription?.cancel();
    isScanning = false;
    if (mounted) {
      // setState(() {});
    }
  }

  Future<NetworkKey?> getNetworkKey() {
    return widget.nordicNrfMesh.meshManagerApi.meshNetwork!.getNetKey(0);
  }


  Future<void> exportBLEMesh() async {
    _meshNetwork != null
        ? () async {
            final meshNetworkJson =
                await widget.nordicNrfMesh.meshManagerApi.exportMeshNetwork();
            debugPrint(meshNetworkJson);
          }
        : null;
  }

  Future<void> resetBLEMesh() async {
    _meshNetwork != null
        ? widget.nordicNrfMesh.meshManagerApi.resetMeshNetwork
        : null;
  }

  Future<void> getNodesOfNetwork() async {
    _meshNetwork!.nodes.then((value) => setState(() => {
          debugPrint(value.toString())
          //_nodes = value
          // Get list of Nodes
        }));
  }

  Future<void> getProvisioners() async {
    _meshNetwork != null
        ? () async {
            var provs = await _meshNetwork!.provisioners;
            print('# of provs : ${provs.length}');
            for (var value in provs) {
              print('$value');
            }
          }
        : null;
  }

  Future<void> connectWithBLEMeshAll() async {
    try {
      print("1001 : " + DateTime.now().toString());

      // await bleMeshManager.disconnect();
      //
      bleMeshManager.callbacks = DoozProvisionedBleMeshManagerCallbacks(
          widget.nordicNrfMesh.meshManagerApi, bleMeshManager);

      print("1003");
      if (_pdevices != null && _pdevices.length > 0) {
        await bleMeshManager.connect(_pdevices.elementAt(0));

        isBLEDeviceConnected = true;
      }
      print("1004");

      debugPrint('node length ${_nodes.length}');

      for (final node in _nodes) {
        debugPrint('node ' + node.toString());
        companyIdentifire = null;
        productIdentifire = null;
        versionIdentifire = null;

        node.productIdentifier.then((value) => {productIdentifire = value});
        node.versionIdentifier.then((value) => {versionIdentifire = value});

        doNodeProvisioned(node);
      }

      print('End : ' + DateTime.now().toString());
    } catch (e) {
    } finally {
      // await setMeshData();
    }
  }

  bool isDeviceAdded(String CMID) {
    for (LightItem item in _lightList) {
      print(
          "===================light discs ================================================");
      print(_lightList);
      if (item.cmacId == CMID) {
        return true;
      }
    }

    for (FanItem item in _fanList) {
      if (item.cmacId == CMID) {
        return true;
      }
    }
    return false;
  }

  Future<void> doNodeProvisioned(ProvisionedMeshNode node) async {
    try {
      print('step 11');
      final elements = await node.elements;
      for (final element in elements) {
        print('step 12');
        for (final model in element.models) {
          print('step 13');
          if (model.key == 4098) {
            print('step 14');
            if (model.boundAppKey.isEmpty) {
              print('step 15');
              if (element == elements.first && model == element.models.first) {
                continue;
              }

              print('step 16');
              final unicast = await node.unicastAddress;
              await widget.nordicNrfMesh.meshManagerApi.sendConfigModelAppBind(
                unicast,
                element.address,
                model.modelId,
              );

              print('step 17');
              if (!isDeviceAdded(element.address.toString())) {
                debugPrint(
                    ' productIdentifire ' + productIdentifire.toString());
                await getDeviceIdType(productIdentifire.toString(),
                    element.address.toString(), Room1ID, element);
                setEnableElement(element.address.toString());
              }

              // print('step 19');
              //
              // widget.nordicNrfMesh.meshManagerApi
              //     .sendConfigModelPublicationSet(
              //     element.address, 65535, model.modelId);

              // print('step 20');
              // List<GroupData> gdata = await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;
              //
              // widget.nordicNrfMesh.meshManagerApi
              //     .sendConfigModelSubscriptionAdd(
              //     element.address, gdata[1].address, model.modelId);
              //
              //
              // print('step 21');
              //
              // widget.nordicNrfMesh.meshManagerApi
              //     .sendConfigModelSubscriptionAdd(
              //     element.address, gdata[0].address, model.modelId);
              //
              // print('step 18');
            } else {
              print('step 19');
              if (!isDeviceAdded(element.address.toString())) {
                debugPrint(
                    ' productIdentifire ' + productIdentifire.toString());
                await getDeviceIdType(productIdentifire.toString(),
                    element.address.toString(), Room1ID, element);
                setEnableElement(element.address.toString());
                widget.nordicNrfMesh.meshManagerApi
                    .sendGenericLevelSet(element.address, 24415)
                    .timeout(const Duration(seconds: 2));
              }
            }
          }
        }
      }
    } catch (ee) {
    } finally {
      startNextDeviceProcess = true;
    }
  }

  String? getSwitchType(int? switchId) {
    for (int i = 0; i <= _switchViewModelLocal!.length; i++) {
      if (_switchViewModelLocal![i].id == switchId) {
        return _switchViewModelLocal![i].prifix;
      }
    }
  }

  String? getSwitchImage(int? switchId) {
    for (int i = 0; i <= _switchViewModelLocal!.length; i++) {
      if (_switchViewModelLocal![i].id == switchId) {
        switch (_switchViewModelLocal![i].prifix) {
          case "S":
            return switchUnSelectedImage;
            break;
          case "F":
            print("F is selected");
            return "assets/images/fan_off.png";
            break;
          case "FR8":
            print("FR8 is selected");
            return "assets/images/fan_off.png";
            break;
        }
      }
    }
  }

  Future<void> getDeviceIdType(
      String six, String cmid, String _roomID, ElementData element) async {
    //_lightList.clear();
    // _fanList.clear();
    print("Ankita 1" + _roomID);

    for (int i = 0; i < deviceListViewModelLocal!.length; i++) {
      if (deviceListViewModelLocal![i].id == int.parse(six)) {
        for (int j = 0;
            j < deviceListViewModelLocal![i].deviceSwitches!.length;
            j++) {
          switch (j) {
            case 0:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              //_deviceSwitchInfo.add(deviceSwitchInfo);
              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL1,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    fan1,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                print("inside else");
                FanItem fanItem = FanItem(
                    j + 1,
                    cmid,
                    "FAN${j + 1}",
                    switchImage!,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    8,
                    0,
                    _scrollController1,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element);
                print("fan item===== " + fanItem.toString());
                setState(() {
                  _fanList.add(fanItem);
                });
              }
              break;
            case 1:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              //_deviceSwitchInfo.add(deviceSwitchInfo);
              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL2,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);

                setState(() {
                  _lightList.add(lightItem);
                });
              } else {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    fan2,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                print("inside else");
                FanItem fanItem = FanItem(
                    j + 1,
                    cmid,
                    "FAN${j + 1}",
                    switchImage!,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    8,
                    0,
                    _scrollController1,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element);

                setState(() {
                  _fanList.add(fanItem);
                });
              }
              break;
            case 2:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              //_deviceSwitchInfo.add(deviceSwitchInfo);
              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL3,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                  print("Lightitem========" + _lightList[1].toString());
                });
              } else {}
              break;
            case 3:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              // _deviceSwitchInfo.add(deviceSwitchInfo);
              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL4,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 4:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              // _deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL5,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 5:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              //_deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL6,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 6:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              //_deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL7,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 7:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              //  _deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL8,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}

              break;
            case 8:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              // _deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL9,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 9:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              // _deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL10,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 10:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              // _deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL11,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 11:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              // _deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL12,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 12:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              //  _deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL13,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 13:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              //_deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL14,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;
            case 14:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL15,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              // _deviceSwitchInfo.add(deviceSwitchInfo);
              break;
            case 15:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL16,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              // _deviceSwitchInfo.add(deviceSwitchInfo);
              break;
            case 16:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL17,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              //  _deviceSwitchInfo.add(deviceSwitchInfo);
              break;

            case 17:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              // _deviceSwitchInfo.add(deviceSwitchInfo);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL18,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              break;

            case 18:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL19,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              // _deviceSwitchInfo.add(deviceSwitchInfo);
              break;
            case 19:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL20,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              //  _deviceSwitchInfo.add(deviceSwitchInfo);
              break;
            case 20:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL21,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              //_deviceSwitchInfo.add(deviceSwitchInfo);
              break;
            case 21:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL22,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              //_deviceSwitchInfo.add(deviceSwitchInfo);
              break;
            case 22:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL23,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              //   _deviceSwitchInfo.add(deviceSwitchInfo);
              break;
            case 23:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL24,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              //_deviceSwitchInfo.add(deviceSwitchInfo);
              break;
            case 24:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL25,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              // _deviceSwitchInfo.add(deviceSwitchInfo);
              break;
            case 25:
              String? prefix = getSwitchType(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);
              String? switchImage = getSwitchImage(
                  deviceListViewModelLocal![i].deviceSwitches![j].switchId);

              if (prefix == "S") {
                DeviceSwitchInfo deviceSwitchInfo = DeviceSwitchInfo(
                    cmid,
                    six,
                    deviceListViewModelLocal![i]
                        .deviceSwitches![j]
                        .switchId
                        .toString(),
                    prefix,
                    lightL26,
                    on,
                    off,
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    "00",
                    false);
                LightItem lightItem = LightItem(
                    j + 1,
                    cmid,
                    prefix! + (j + 1).toString(),
                    switchImage!,
                    false,
                    false,
                    false,
                    false,
                    deviceSwitchInfo,
                    _roomID,
                    Timer(const Duration(milliseconds: 0), () => {}),
                    false,
                    0,
                    element,
                    FocusNode(),
                    false);
                setState(() {
                  _lightList.add(lightItem);
                });
              } else {}
              //_deviceSwitchInfo.add(deviceSwitchInfo);
              break;
          }
        }
      }
    }
  }

  Future<void> _scanProvisionned() async {
    setState(() {
      _pdevices.clear();
    });
    await checkAndAskPermissions();
    _scanSubscription =
        widget.nordicNrfMesh.scanForProxy().listen((device) async {
      if (_pdevices.every((d) => d.id != device.id)) {
        setState(() {
          _pdevices.add(device);
        });
      }
    });
    setState(() {
      isScanning = true;
    });
    return Future.delayed(const Duration(seconds: 10), _stopScanPro);
  }

  Future<void> checkAndAskPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 31) {
        // location
        await Permission.locationWhenInUse.request();
        await Permission.locationAlways.request();
        // bluetooth
        await Permission.bluetooth.request();
      } else {
        // bluetooth for Android 12 and up
        await Permission.bluetoothScan.request();
        await Permission.bluetoothConnect.request();
      }
    } else {
      // bluetooth for iOS 13 and up
      await Permission.bluetooth.request();
    }
  }

  Future<void> _stopScanPro() async {
    await _scanSubscription?.cancel();
    isScanning = false;
    if (mounted) {
      setState(() {});
    }
  }

  String getCurrentStatusFromCmdNew(String commandCode, int index) {
    String returnValue = "";
    switch (index) {
      case 1:
        returnValue = commandCode.substring(0, 1);
        break;
      case 2:
        returnValue = commandCode.substring(1, 2);
        break;
      case 3:
        returnValue = commandCode.substring(2, 3);
        break;
      case 4:
        returnValue = commandCode.substring(3, 4);
        break;
      case 5:
        returnValue = commandCode.substring(4, 5);
        break;
      case 6:
        returnValue = commandCode.substring(5, 6);
        break;
      case 7:
        returnValue = commandCode.substring(6, 7);
        break;
      case 8:
        returnValue = commandCode.substring(7, 8);
        break;
      case 9:
        returnValue = commandCode.substring(8, 9);
        break;
      case 10:
        returnValue = commandCode.substring(9, 10);
        break;
      case 11:
        returnValue = commandCode.substring(10, 11);
        break;
      case 12:
        returnValue = commandCode.substring(11, 12);
        break;
      case 13:
        returnValue = commandCode.substring(12, 13);
        break;
      case 14:
        returnValue = commandCode.substring(13, 14);
        break;
      case 15:
        returnValue = commandCode.substring(14, 15);
        break;
      case 16:
        returnValue = commandCode.substring(15, 16);
        break;
      case 17:
        returnValue = commandCode.substring(16, 17);
        break;
      case 18:
        returnValue = commandCode.substring(17, 18);
        break;
    }
    return returnValue;
  }

  String getCurrentStatusFromCmd(String commandCode, int index) {
    String returnValue = "";
    switch (index) {
      case 1:
        returnValue = commandCode.replaceAll(' ', '').substring(20, 22);
        break;
      case 2:
        returnValue = commandCode.replaceAll(' ', '').substring(22, 24);
        break;
      case 3:
        returnValue = commandCode.replaceAll(' ', '').substring(24, 26);
        break;
      case 4:
        returnValue = commandCode.replaceAll(' ', '').substring(26, 28);
        break;
      case 5:
        returnValue = commandCode.replaceAll(' ', '').substring(28, 30);
        break;
      case 6:
        returnValue = commandCode.replaceAll(' ', '').substring(30, 32);
        break;
      case 7:
        returnValue = commandCode.replaceAll(' ', '').substring(32, 34);
        break;
      case 8:
        returnValue = commandCode.replaceAll(' ', '').substring(34, 36);
        break;
      case 9:
        returnValue = commandCode.replaceAll(' ', '').substring(36, 38);
        break;
      case 10:
        returnValue = commandCode.replaceAll(' ', '').substring(38, 40);
        break;
      case 11:
        returnValue = commandCode.replaceAll(' ', '').substring(40, 42);
        break;
      case 12:
        returnValue = commandCode.replaceAll(' ', '').substring(42, 44);
        break;
      case 13:
        returnValue = commandCode.replaceAll(' ', '').substring(44, 46);
        break;
      case 14:
        returnValue = commandCode.replaceAll(' ', '').substring(46, 48);
        break;
      case 15:
        returnValue = commandCode.replaceAll(' ', '').substring(48, 50);
        break;
      case 16:
        returnValue = commandCode.replaceAll(' ', '').substring(50, 52);
        break;
      case 17:
        returnValue = commandCode.replaceAll(' ', '').substring(52, 54);
        break;
      case 18:
        returnValue = commandCode.replaceAll(' ', '').substring(54, 56);
        break;
    }
    return returnValue;
  }

  String getCurrentStatusFromCmdFanNew(String commandCode) {
    String returnValue = "";
    switch (commandCode.substring(1, 4)) {
      case "000":
        returnValue = "01";
        break;
      case "001":
        returnValue = "02";
        break;
      case "010":
        returnValue = "03";
        break;
      case "011":
        returnValue = "04";
        break;
      case "100":
        returnValue = "05";
        break;
      case "101":
        returnValue = "06";
        break;
      case "110":
        returnValue = "07";
        break;
      case "111":
        returnValue = "08";
        break;
    }
    return returnValue;
  }

  String getCurrentStatusFromCmdFan(String commandCode) {
    String returnValue = "";
    // switch (index) {
    //   case 1:
    //     returnValue = commandCode.replaceAll(' ', '').substring(6, 8);
    //     break;
    //   case 2:
    returnValue = commandCode.replaceAll(' ', '').substring(8, 10);
    //   break;
    // case 3:
    //   returnValue = commandCode.replaceAll(' ', '').substring(8, 12);
    //   break;
    // case 4:
    //   returnValue = commandCode.replaceAll(' ', '').substring(26, 28);
    //   break;
    // case 5:
    //   returnValue = commandCode.replaceAll(' ', '').substring(28, 30);
    //   break;
    // case 6:
    //   returnValue = commandCode.replaceAll(' ', '').substring(30, 32);
    //   break;
    // case 7:
    //   returnValue = commandCode.replaceAll(' ', '').substring(32, 34);
    //   break;
    // case 8:
    //   returnValue = commandCode.replaceAll(' ', '').substring(34, 36);
    //   break;
    // case 9:
    //   returnValue = commandCode.replaceAll(' ', '').substring(36, 38);
    //   break;
    // case 10:
    //   returnValue = commandCode.replaceAll(' ', '').substring(38, 40);
    //   break;
    // case 11:
    //   returnValue = commandCode.replaceAll(' ', '').substring(40, 42);
    //   break;
    // case 12:
    //   returnValue = commandCode.replaceAll(' ', '').substring(42, 44);
    //   break;
    // case 13:
    //   returnValue = commandCode.replaceAll(' ', '').substring(44, 46);
    //   break;
    // case 14:
    //   returnValue = commandCode.replaceAll(' ', '').substring(46, 48);
    //   break;
    // case 15:
    //   returnValue = commandCode.replaceAll(' ', '').substring(48, 50);
    //   break;
    // case 16:
    //   returnValue = commandCode.replaceAll(' ', '').substring(50, 52);
    //   break;
    // case 17:
    //   returnValue = commandCode.replaceAll(' ', '').substring(52, 54);
    //   break;
    // case 18:
    //   returnValue = commandCode.replaceAll(' ', '').substring(54, 56);
    //   break;
    // }
    return returnValue;
  }

  getData() async {
    deviceToken = await LocalStorageService.getToken();
    applicationId = await LocalStorageService.getAppId();
    appUserId = await LocalStorageService.getUserId();

    print(deviceToken);
    print(applicationId);
    print(appUserId);

    RequestPlacesWithOwnerPermissions requestPlacesWithOwnerPermissions =
        RequestPlacesWithOwnerPermissions(
            applicationId: applicationId, appuserId: appUserId);
    placesWithOwnerPermissionsVM
        .getPlacesWithOwnerPermissions(requestPlacesWithOwnerPermissions);
  }

  Future<void> callCommandsNew(
      String CMID, String fourthByte, String commandCode) async {
    print('CMID ' + CMID);
    print('fourthByte $fourthByte');

    print("3001");
    if (fourthByte == "5F") {
      print("FF Performed");
      setState(() {
        indicatorRoom1.setSelectd(false);
        indicatorRoom2.setSelectd(false);
        _indicatorList[0].setSelectd(false);
      });
    } else if (fourthByte == "D2") {
      print("D2 D2 Performed");
      setState(() {
        _indicatorList[1].setSelectd(false);
      });
    } else if (fourthByte == "0D") {
      print("All ON Performed");
      setState(() {
        indicatorAllON.setSelectd(false);
      });
    } else if (fourthByte == "0C") {
      print("All OFF Performed");
      setState(() {
        indicatorAllOF.setSelectd(false);
      });
    } else if (fourthByte == "0F") {
      print("Master Off Performed");
      setState(() {
        indicatorAllMasterOff.setSelectd(false);
      });
    }

    for (int i = 0; i < sceneItems.length; i++) {
      if (sceneItems[i].command == fourthByte) {
        setState(() {
          sceneItems[i].setSelectd(false);
        });
      }
    }

    // LightItem? state;
    // for (int i = 0; i < _lightList.length; i++) {
    //   if (_lightList[i].element.address.toString() == CMID) {
    //     String status =
    //             getCurrentStatusFromCmdNew(commandCode, _lightList[i].cmIndex);
    //     if(status=="1"){
    //       state=_lightList[i];
    //     }
    //
    //   }
    // }
    // if(state!.getImage()==switchSelectedImage){
    //   state.setImage(switchUnSelectedImage);
    // }
    // else if(state.getImage()==switchUnSelectedImage){
    //   state.setImage(switchSelectedImage);
    // }
    // setState(() {
    //
    // });
    for (int i = 0; i < _lightList.length; i++) {
      print("data   " + _lightList[i].cmIndex.toString());
      if (_lightList[i].element.address.toString() == CMID) {
        String status =
            getCurrentStatusFromCmdNew(commandCode, _lightList[i].cmIndex);

        if (status == "1") {
          print(
              "inside iffffffff   $status   ${_lightList[i].cmIndex.toString()}   ${_lightList[i].deviceSwitchInfo}");

          _lightList[i].deviceSwitchInfo.ccOn = "10";
          _lightList[i].deviceSwitchInfo.status = true;
          if (light == _lightList[i].getName()) {
            print("inside iffffff iff");
            _lightList[i].setImage(switchSelectedImage);
          } else if (light == null) {
            print("inside iffffff iff");
            _lightList[i].setImage(switchSelectedImage);
          } else {
            _lightList[i].setImage(switchSelectedImage);
          }
          _lightList[i].isSelectedindicator = false;
        } else if (status == "0") {
          print(
              "inside else ifffffff  $status    ${_lightList[i].cmIndex.toString()}");

          _lightList[i].deviceSwitchInfo.ccOff = "20";
          _lightList[i].deviceSwitchInfo.status = false;
          if (light == _lightList[i].getName()) {
            print("inside else iffffff iff");
            _lightList[i].setImage(switchUnSelectedImage);
          } else if (light == null) {
            print("inside else iffffff iff");
            _lightList[i].setImage(switchUnSelectedImage);
          } else {
            _lightList[i].setImage(switchUnSelectedImage);
          }
          _lightList[i].isSelectedindicator = false;
        }
      }
    }

    if (fourthByte == "29" || fourthByte == "5F") {
      //fanItem.deviceSwitchInfo.status
      for (int i = 0; i < _fanList.length; i++) {
        if (_fanList[i].cmacId == CMID) {
          print("inside if");
          String status = getCurrentStatusFromCmdFanNew(commandCode);
          print("Status" + status.toString());

          bool currentStatus = false;

          print(
              "fanItem.deviceSwitchInfo.status  ${_fanList[i].deviceSwitchInfo.status}");

          if (commandCode.substring(0, 1) == "1") {
            print("inside if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOn = "10";
              _fanList[i].selectedIndex = 0;
              _fanList[i].deviceSwitchInfo.status = true;

              _fanList[i].setImage(fanSelectedImage);
              currentStatus = true;
              print("Status is On ");
            });
          }

          if (commandCode.substring(0, 1) == "0") {
            print("inside else if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOff = "20";
              _fanList[i].selectedIndex = 0;
              _fanList[i].deviceSwitchInfo.status = false;
              _fanList[i].setImage(fanUnSelectedImage);
              currentStatus = false;

              print("Status is Off ");
            });
          }

          if (status == "01") {
            print("inside if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOn = "10";
              _fanList[i].selectedIndex = 0;
              _fanList[i].deviceSwitchInfo.status = currentStatus;
              //_fanList[i].setImage(fanSelectedImage);
            });
          } else if (status == "02") {
            print("inside if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOn = "10";
              _fanList[i].selectedIndex = 1;
              _fanList[i].deviceSwitchInfo.status = currentStatus;
              //_fanList[i].setImage(fanSelectedImage);
            });
          } else if (status == "03") {
            print("inside if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOn = "10";
              _fanList[i].selectedIndex = 2;
              _fanList[i].deviceSwitchInfo.status = currentStatus;
              // _fanList[i].setImage(fanSelectedImage);
            });
          } else if (status == "04") {
            print("inside if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOn = "10";
              _fanList[i].selectedIndex = 3;
              _fanList[i].deviceSwitchInfo.status = currentStatus;
              // _fanList[i].setImage(fanSelectedImage);
            });
          } else if (status == "05") {
            print("inside if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOn = "10";
              _fanList[i].selectedIndex = 4;
              _fanList[i].deviceSwitchInfo.status = currentStatus;
              // _fanList[i].setImage(fanSelectedImage);
            });
          } else if (status == "06") {
            print("inside if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOn = "10";
              _fanList[i].selectedIndex = 5;
              _fanList[i].deviceSwitchInfo.status = currentStatus;
              //  _fanList[i].setImage(fanSelectedImage);
            });
          } else if (status == "07") {
            print("inside if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOn = "10";
              _fanList[i].selectedIndex = 6;
              _fanList[i].deviceSwitchInfo.status = currentStatus;
              //  _fanList[i].setImage(fanSelectedImage);
            });
          } else if (status == "08") {
            print("inside if" + status);
            setState(() {
              _fanList[i].deviceSwitchInfo.ccOn = "10";
              _fanList[i].selectedIndex = 7;
              _fanList[i].deviceSwitchInfo.status = currentStatus;
              // _fanList[i].setImage(fanSelectedImage);
            });
          }
        }
      }
    }
  }

  // } else {
  //   print("elseeeeeeeeeee");
  //   for (int i = 0; i < _lightList.length; i++) {
  //     if (_lightList[i].getName() == light) {
  //       if (_lightList[i].getImage() == switchSelectedImage) {
  //         print("else if if");
  //
  //         _lightList[i].deviceSwitchInfo.ccOff = "20";
  //         _lightList[i].deviceSwitchInfo.status = false;
  //         _lightList[i].setImage(switchUnSelectedImage);
  //         _lightList[i].isSelectedindicator = false;
  //         _lightList[i].deviceSwitchInfo.ccOn = "10";
  //         _lightList[i].deviceSwitchInfo.status = true;
  //
  //
  //
  //
  //       } else {
  //         _lightList[i].setImage(switchSelectedImage);
  //         _lightList[i].deviceSwitchInfo.ccOn = "10";
  //         _lightList[i].deviceSwitchInfo.status = true;
  //         _lightList[i].isSelectedindicator = false;
  //       }
  //     } else {}
  //   }
  // }
  void connect() async {
    client = MqttServerClient.withPort('mqtt.easyhomeautomation.co.in',
        'A88D9AB4-3252-4B2E-B40D-ACA4D0EB67CB', 51883);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;

    final connMessage = MqttConnectMessage()
        .authenticateAs('easyhomeautomation', 'p1HxNp4j')
        .withWillTopic('ESP_DevID_1CB629F7C630')
        .withWillMessage('My Will message')
        .withClientIdentifier('A88D9AB4-3252-4B2E-B40D-ACA4D0EB67CB')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
    try {
      await client.connect('easyhomeautomation', 'p1HxNp4j');
      var d = await client
          .connect('easyhomeautomation', 'p1HxNp4j')
          .then((value) => value);
      print("respodata========" + d.toString());
    } catch (e) {
      print("respodataerror========" + e.toString());
      client.disconnect();
    }

    client.subscribe(
        'efd370fc-7701-48c7-8046-d58ecf2a88bc/RESPONSE', MqttQos.exactlyOnce);

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      print(c.first.payload);
      final recMess = c[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print(
          'Received message:$payload from topic: ${recMess.payload.message}>');
    });
  }

  void onConnected() {
    print('Connected');
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    final bool isVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    if (!isVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
//     if(ak){

//     ak=false;}
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: context.resources.color.colorBlack,
      resizeToAvoidBottomInset: true,
      drawer: Container(
        width: getWidth(width, width / 4),
        margin: EdgeInsets.only(top: getHeight(height, 20)),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/drawer_menu_bg.png"),
              fit: BoxFit.fill),
        ),
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: HomePageDrawer(width, height, _scaffoldKey),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(children: [
            Expanded(
                child: SizedBox(
                    height: height,
                    width: width,
                    child: Stack(children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // if (isExpandPair1 == true) {
                              //   isExpandPair1 = false;
                              //   extendHeight = 469;
                              // } else {
                              //   isExpandPair1 = true;
                              //   extendHeight = 302;
                              // }

                              addDeviceCalled = false;

                              if (listController.hasClients) {
                                listController.animateTo(
                                  0,
                                  duration: const Duration(
                                      milliseconds: animatedDuration),
                                  curve: Curves.fastOutSlowIn,
                                );
                              }
                              if (isExpandPairTop == true) {
                                isExpandPairTop = false;
                                extendHeight = 469;
                                if (topTimer != null) {
                                  if (topTimer!.isActive) {
                                    topTimer!.cancel();
                                  }
                                }
                              } else {
                                isExpandPairTop = true;
                                isExpandPairBottom = false;
                                extendHeight = 413 - 27;

                                if (bottomTimer != null) {
                                  if (bottomTimer!.isActive) {
                                    bottomTimer!.cancel();
                                  }
                                }

                                topTimer =
                                    Timer(const Duration(seconds: 4), () {
                                  setState(() {
                                    isExpandPairTop = false;
                                    extendHeight = 469;
                                  });
                                });
                              }
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: getWidth(width, width),
                            height:
                                getHeight(height, isExpandPairTop ? 287 : 231),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: getY(
                            height,
                            isExpandPairTop
                                ? 287
                                : isExpandPairBottom
                                    ? 231
                                    : 231),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isExpandPairTop || isExpandPairBottom) {
                                isExpandPairTop = false;
                                isExpandPairBottom = false;
                                extendHeight = 469;

                                if (topTimer != null) {
                                  if (topTimer!.isActive) {
                                    topTimer!.cancel();
                                  }
                                }

                                if (bottomTimer != null) {
                                  if (bottomTimer!.isActive) {
                                    bottomTimer!.cancel();
                                  }
                                }
                              }
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: getWidth(width, width),
                            height: getHeight(height, extendHeight),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: getY(height, isExpandPairBottom ? 588 : 700),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // if (isExpandPair1 == true) {
                              //   isExpandPair1 = false;
                              //   extendHeight = 469;
                              // } else {
                              //   isExpandPair1 = true;
                              //   extendHeight = 302;
                              // }

                              addDeviceCalled = false;

                              if (listController.hasClients) {
                                listController.animateTo(
                                  0,
                                  duration: const Duration(
                                      milliseconds: animatedDuration),
                                  curve: Curves.fastOutSlowIn,
                                );
                              }
                              if (isExpandPairBottom == true) {
                                isExpandPairBottom = false;
                                extendHeight = 469;
                                if (bottomTimer != null) {
                                  if (bottomTimer!.isActive) {
                                    bottomTimer!.cancel();
                                  }
                                }
                              } else {
                                isExpandPairBottom = true;
                                isExpandPairTop = false;
                                extendHeight = 388;

                                if (topTimer != null) {
                                  if (topTimer!.isActive) {
                                    topTimer!.cancel();
                                  }
                                }

                                startBottomTimer();
                              }
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: getWidth(width, width),
                            height: getHeight(
                                height, isExpandPairBottom ? 219 : 108),
                          ),
                        ),
                      ),
                      addDeviceCalled
                          ? HomePagePairing(width, height, client, this, () {
                              setState(() {
                                addDeviceCalled = false;
                              });
                            })
                          : getPositionBody(context, height, width),
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Positioned(
                              top: getY(height, 56),
                              left: getX(width, 30),
                              child: GestureDetector(
                                  onTap: () {
                                    if (_scaffoldKey
                                        .currentState!.isDrawerOpen) {
                                      _scaffoldKey.currentState!
                                          .openEndDrawer();
                                    } else {
                                      _scaffoldKey.currentState!.openDrawer();
                                    }
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(unSelectedButtonImage,
                                          height: getHeight(
                                              height, dialogSwitchHeight),
                                          width: getWidth(
                                              width, dialogSwitchWidth),
                                          fit: BoxFit.fill),
                                      Image.asset(
                                        'assets/images/menu.png',
                                        height: getHeight(height, 10),
                                        width: getWidth(width, 25),
                                        fit: BoxFit.fill,
                                      ),
                                    ],
                                  ))),
                          Positioned(
                            top: getY(height, 68),
                            left: getX(width, (width / 2) - 40),
                            child: GestureDetector(
                              child: const Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color: textColor,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: getY(height, 17),
                            left: getX(width, (width / 2)),
                            child: GestureDetector(
                              child: const Icon(
                                Icons.arrow_drop_up,
                                size: 20,
                                color: textColor,
                              ),
                            ),
                          ),
                          Positioned(
                              right: getX(width, 30),
                              top: getY(height, 56),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(kRemotUnSelectedImage,
                                      height:
                                          getHeight(height, kRemotButtonHeight),
                                      width: getWidth(width, kRemotButtonWidth),
                                      fit: BoxFit.fill),
                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: RichText(
                                  //       text: TextSpan(children: [
                                  //         TextSpan(
                                  //           style: TextStyle(
                                  //               color: context
                                  //                   .resources.color
                                  //                   .colorWhite,
                                  //               fontWeight: FontWeight.w400,
                                  //               fontFamily: "Inter",
                                  //               fontStyle: FontStyle.normal,
                                  //               fontSize: getAdaptiveTextSize(
                                  //                   context, 26)),
                                  //           text: "K",
                                  //         ),
                                  //         TextSpan(
                                  //             style: TextStyle(
                                  //                 color: context
                                  //                     .resources.color
                                  //                     .colorWhite,
                                  //                 fontWeight: FontWeight.w400,
                                  //                 fontFamily: "Inter",
                                  //                 fontStyle: FontStyle.normal,
                                  //                 fontSize: getAdaptiveTextSize(
                                  //                     context, 20)),
                                  //             text: "REMOT")
                                  //       ])),
                                  // ),
                                ],
                              )),
                          getPositionFirstRow(height, width),
                          HomePageScenesList(
                              width, height, scenesVM, isExpandPairTop, () {
                            setState(() {
                              masterOFFImage = unSelectedButtonImage;
                              allONImage = unSelectedButtonImage;
                              allOFFImage = unSelectedButtonImage;
                            });
                          }, () {
                            disableTextFields();
                          }),
                          getPositionThirdRow(height, width),
                          getPositionTopDivider(height, width),
                          if (!addDeviceCalled)
                            getPositionTopArrow(height, width),
                          if (!addDeviceCalled)
                            getPositionDownArrow(height, width),
                          if (!addDeviceCalled)
                            getPositionLeftArrow(height, width),
                          if (!addDeviceCalled)
                            getPositionRightArrow(height, width),
                          getPositionBottomDivider(height, width),
                          HomePageRoomsList(width, height, roomsVM, scenesVM,
                              isExpandPairBottom, () {
                            disableTextFields();
                          }, ""),
                          HomePagePlacesLayout(
                              width,
                              height,
                              placesWithOwnerPermissionsVM,
                              roomsVM,
                              isExpandPairBottom),
                          getPositionSecondLastRow(height, width),
                          getPositionLastRow(height, width),
                        ],
                      ),
                    ])))
          ]),
        ),
      ),
    );
  }

  void startBottomTimer() {
    bottomTimer = Timer(const Duration(seconds: 4), () {
      bool isKeyBoardVisible =
          KeyboardVisibilityProvider.isKeyboardVisible(context);
      if (!isKeyBoardVisible && !renameDialogOpened) {
        setState(() {
          isExpandPairBottom = false;
          extendHeight = 469;
        });
      } else {
        startBottomTimer();
      }
    });
  }

  Widget? internetConnection(
      BuildContext context, double height, double width, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Align(
            alignment: const Alignment(0, 0.7),
            child: Container(
              width: getWidth(width, renameDialogWidth),
              height: 190,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(14.86390495300293)),
                border: Border.all(
                    color: homePageDividerColor, width: 1.0617074966430664),
                image: const DecorationImage(
                    image: AssetImage(alertDialogBg), fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          //fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                          fontSize: getAdaptiveTextSize(context, 12.0)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 50),
                    child: DialogCenterButton("RESTART", optionsButtonWidth,
                        optionsButtonHeight, optionsButtonTextSize, (selected) {
                      Restart.restartApp();
                    }),
                  )
                ],
              ),
            ),
          );
        });
  }

  FocusNode switchFocusNode = FocusNode();
  String getLastCommandSend(LightItem lightItem) {
    setState(() {});
    if (lightItem.deviceSwitchInfo.status == false) {
      return "${lightItem.deviceSwitchInfo.ccOpp!} ${lightItem.deviceSwitchInfo.ccOn!} ${lightItem.deviceSwitchInfo.deviceId!}";
    } else {
      return "${lightItem.deviceSwitchInfo.ccOpp!} ${lightItem.deviceSwitchInfo.ccOff!} ${lightItem.deviceSwitchInfo.deviceId!}";
    }
  }

  String getLastCommandSendFAN(FanItem lightItem) {
    return "${lightItem.deviceSwitchInfo.ccOpp!}" +
        "0" +
        "${lightItem.selectedIndex} ${lightItem.deviceSwitchInfo.deviceId!}";
  }

  Future<void> sendCommandCMID(
      LightItem lightItem,
      FanItem fanItem,
      bool isItFan,
      SceneItem sceneItem,
      bool isScene,
      bool isAllOF,
      bool isAllON,
      bool masterOff,
      bool isDePair,
      bool isStatus,
      bool isReg) async {
    if (isStatus) {
      sendCommandToDeviceNew("", lightItem, fanItem, isItFan, sceneItem,
          isScene, isAllOF, isAllON, masterOff, isDePair, isStatus, isReg);
    } else {
      print("Inside Status");
      if (!isItFan &&
          !isScene &&
          !isAllOF &&
          !isAllON &&
          !masterOff &&
          !isDePair &&
          !isReg) {
        sendCommandToDeviceNew(
            getLastCommandSend(lightItem),
            lightItem,
            fanItem,
            isItFan,
            sceneItem,
            isScene,
            isAllOF,
            isAllON,
            masterOff,
            isDePair,
            isStatus,
            isReg);
      } else if (isItFan &&
          !isScene &&
          !isAllOF &&
          !isAllON &&
          !masterOff &&
          !isDePair &&
          !isReg) {
        sendCommandToDeviceNew(
            getLastCommandSendFAN(fanItem),
            lightItem,
            fanItem,
            isItFan,
            sceneItem,
            isScene,
            isAllOF,
            isAllON,
            masterOff,
            isDePair,
            isStatus,
            isReg);
      } else if (!isItFan &&
          !isScene &&
          !isAllOF &&
          !isAllON &&
          !masterOff &&
          !isDePair &&
          isReg) {
        sendCommandToDeviceNew(
            getLastCommandSendFAN(fanItem),
            lightItem,
            fanItem,
            isItFan,
            sceneItem,
            isScene,
            isAllOF,
            isAllON,
            masterOff,
            isDePair,
            isStatus,
            isReg);
      } else if (!isItFan &&
          isScene &&
          !isAllOF &&
          !isAllON &&
          !masterOff &&
          !isDePair &&
          !isReg) {
        sendCommandToDeviceNew("", lightItem, fanItem, isItFan, sceneItem,
            isScene, isAllOF, isAllON, masterOff, isDePair, isStatus, isReg);
      } else if (!isItFan &&
          isScene &&
          isAllOF &&
          !isAllON &&
          !masterOff &&
          !isDePair &&
          !isReg) {
        sendCommandToDeviceNew("", lightItem, fanItem, isItFan, sceneItem,
            isScene, isAllOF, isAllON, masterOff, isDePair, isStatus, isReg);
      } else if (!isItFan &&
          isScene &&
          !isAllOF &&
          isAllON &&
          !masterOff &&
          !isDePair &&
          !isReg) {
        sendCommandToDeviceNew("", lightItem, fanItem, isItFan, sceneItem,
            isScene, isAllOF, isAllON, masterOff, isDePair, isStatus, isReg);
      } else if (!isItFan &&
          isScene &&
          !isAllOF &&
          isAllON &&
          masterOff &&
          !isDePair &&
          !isReg) {
        sendCommandToDeviceNew("", lightItem, fanItem, isItFan, sceneItem,
            isScene, isAllOF, isAllON, masterOff, isDePair, isStatus, isReg);
      } else {
        sendCommandToDeviceNew("", lightItem, fanItem, isItFan, sceneItem,
            isScene, isAllOF, isAllON, masterOff, isDePair, isStatus, isReg);
      }
    }
  }

  bool isCompleted = false;
  bool isA5Received = false;

  String sendCommandForgetStatus() {
    RequestCMID sendCommand = RequestCMID(
        aID: "ABCDEFGHIJKLMN",
        hMID: "ABC123DEF456GH78DEMO",
        mN: "+919191919191",
        cC: "55 02 0D FF FF AA",
        oPR: ["RMID", RoomID]);
    print(jsonEncode(sendCommand).toString());

    return jsonEncode(sendCommand);
  }

  int getIntFromHex(String first, String second) {
    int sendData = int.parse(first + second, radix: 16);
    print("Data Send To Device : " + sendData.toString());
    return sendData;
  }

  String dePairCommand() {
    RequestCMID sendCommand = RequestCMID(
        aID: "ABCDEFGHIJKLMN",
        hMID: "ABC123DEF456GH78DEMO",
        mN: "+919191919191",
        cC: "55 03 0D D2 D2 AA",
        oPR: ["HMID", "ABC123DEF456GH78DEMO"]);

    print(jsonEncode(sendCommand).toString());

    return jsonEncode(sendCommand);
  }

  String mqttSendJsonData(int strAddr, int strCmds) {
    RequestJsonCMD sendCommand = RequestJsonCMD(addr: strAddr, cmds: strCmds);
    print("Wifi Command Sent : " + jsonEncode(sendCommand).toString());
    return jsonEncode(sendCommand);
  }

  String mqttGetJsonData(String strJson) {
    ResponseJsonCMID receivedCommand =
        ResponseJsonCMID.fromJson(json.decode(strJson));
    print("Wifi Command Received : " + strJson);
    return jsonEncode(receivedCommand);
  }

  Future<bool> sendToDeviceNew(
      LightItem lightItem,
      FanItem fanItem,
      bool isItFan,
      SceneItem sceneItem,
      bool isScene,
      bool isAllOff,
      bool isAllOn,
      bool isMasteroff,
      bool isDePair,
      bool isStatus,
      bool isReg) async {
    try {
      if (isStatus) {
      } else {
        if (!isItFan &&
            !isScene &&
            !isAllOff &&
            !isAllOn &&
            !isMasteroff &&
            !isDePair &&
            !isReg) {
          print('Element Address of Send Command ' +
              lightItem.element.address.toString());

          if (lightItem.deviceSwitchInfo.status == false) {
            if (isBLEDeviceConnected) {
              GenericLevelStatusData returnData = await widget
                  .nordicNrfMesh.meshManagerApi
                  .sendGenericLevelSet(
                      lightItem.element.address,
                      getIntFromHex(lightItem.deviceSwitchInfo.ccOpp!,
                          lightItem.deviceSwitchInfo.ccOn!))
                  .timeout(const Duration(seconds: 2));

              print('return Data ' + returnData.toString());
            } else {
              int sendCmd = getIntFromHex(lightItem.deviceSwitchInfo.ccOpp!,
                  lightItem.deviceSwitchInfo.ccOn!);
              builder1.clear();
              builder1.addString(
                  mqttSendJsonData(lightItem.element.address, sendCmd)
                      .toString());
              client.publishMessage(
                  sendTopic, MqttQos.exactlyOnce, builder1.payload!);
            }
          } else {
            if (isBLEDeviceConnected) {
              GenericLevelStatusData returnData = await widget
                  .nordicNrfMesh.meshManagerApi
                  .sendGenericLevelSet(
                      lightItem.element.address,
                      getIntFromHex(lightItem.deviceSwitchInfo.ccOpp!,
                          lightItem.deviceSwitchInfo.ccOff!))
                  .timeout(const Duration(seconds: 2));

              print('return Data ' + returnData.toString());
            } else {
              int sendCmd = getIntFromHex(lightItem.deviceSwitchInfo.ccOpp!,
                  lightItem.deviceSwitchInfo.ccOff!);
              builder1.clear();
              builder1.addString(
                  mqttSendJsonData(lightItem.element.address, sendCmd)
                      .toString());
              client.publishMessage(
                  sendTopic, MqttQos.exactlyOnce, builder1.payload!);
            }
          }

          //sendONOFFGen(lightItem.element.address,!lightItem.deviceSwitchInfo.status!);
        } else if (isItFan &&
            !isScene &&
            !isAllOff &&
            !isAllOn &&
            !isMasteroff &&
            !isDePair &&
            !isReg) {
          print("fanItem.deviceSwitchInfo.status " +
              fanItem.deviceSwitchInfo.status.toString());
          if (fanItem.deviceSwitchInfo.status == false) {
            if (isBLEDeviceConnected) {
              await widget.nordicNrfMesh.meshManagerApi
                  .sendGenericLevelSet(
                      fanItem.element.address,
                      getIntFromHex(fanItem.deviceSwitchInfo.ccOpp!,
                          fanItem.deviceSwitchInfo.ccOn!))
                  .timeout(const Duration(seconds: 2));
            } else {
              int sendCmd = getIntFromHex(fanItem.deviceSwitchInfo.ccOpp!,
                  fanItem.deviceSwitchInfo.ccOn!);
              builder1.clear();
              builder1.addString(
                  mqttSendJsonData(fanItem.element.address, sendCmd)
                      .toString());
              client.publishMessage(
                  sendTopic, MqttQos.exactlyOnce, builder1.payload!);
            }
          } else {
            if (isBLEDeviceConnected) {
              await widget.nordicNrfMesh.meshManagerApi
                  .sendGenericLevelSet(
                      fanItem.element.address,
                      getIntFromHex(fanItem.deviceSwitchInfo.ccOpp!,
                          fanItem.deviceSwitchInfo.ccOff!))
                  .timeout(const Duration(seconds: 2));
            } else {
              int sendCmd = getIntFromHex(fanItem.deviceSwitchInfo.ccOpp!,
                  fanItem.deviceSwitchInfo.ccOff!);
              builder1.clear();
              builder1.addString(
                  mqttSendJsonData(fanItem.element.address, sendCmd)
                      .toString());
              client.publishMessage(
                  sendTopic, MqttQos.exactlyOnce, builder1.payload!);
            }
          }
        } else if (!isItFan &&
            !isScene &&
            !isAllOff &&
            !isAllOn &&
            !isMasteroff &&
            !isDePair &&
            isReg) {
          if (isBLEDeviceConnected) {
            await widget.nordicNrfMesh.meshManagerApi
                .sendGenericLevelSet(
                    fanItem.element.address,
                    getIntFromHex(fanItem.deviceSwitchInfo.ccOpp!,
                        "0" + (fanItem.selectedIndex + 1).toString()))
                .timeout(const Duration(seconds: 2));
          } else {
            int sendCmd = getIntFromHex(fanItem.deviceSwitchInfo.ccOpp!,
                "0" + (fanItem.selectedIndex + 1).toString());
            builder1.clear();
            builder1.addString(
                mqttSendJsonData(fanItem.element.address, sendCmd).toString());
            client.publishMessage(
                sendTopic, MqttQos.exactlyOnce, builder1.payload!);
          }
        } else if (!isItFan &&
            isScene &&
            !isAllOff &&
            !isAllOn &&
            !isMasteroff &&
            !isDePair &&
            !isReg) {
          List<GroupData> gdata =
              await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;
          if (isBLEDeviceConnected) {
            print('Group Data : ' + gdata.toString());
            await widget.nordicNrfMesh.meshManagerApi
                .sendGenericLevelSet(gdata[1].address,
                    getIntFromHex(sceneItem.command, sceneItem.commandOn))
                .timeout(const Duration(seconds: 2));
          } else {
            int sendCmd = getIntFromHex(sceneItem.command, sceneItem.commandOn);
            builder1.clear();
            builder1.addString(
                mqttSendJsonData(gdata[1].address, sendCmd).toString());
            client.publishMessage(
                sendTopic, MqttQos.exactlyOnce, builder1.payload!);
          }
        } else if (!isItFan &&
            !isScene &&
            isAllOff &&
            !isAllOn &&
            !isMasteroff &&
            !isDePair &&
            !isReg) {
          // await _device!.requestMtu(512);
          // List<BluetoothService> services = await _device!.discoverServices();
          // for (BluetoothService service in services) {
          //   print("Inside For Status");
          //   for (BluetoothCharacteristic characteristic
          //   in service.characteristics) {
          //     if (characteristic.properties.write) {
          //       print("Inside If Status");
          //       await characteristic.write(utf8.encode(sendCommandAllOFF()),
          //           withoutResponse: true);
          //       //await addIntoQueue(sendCommandAllOFF());
          //       print("Call 201");
          //       // }
          //
          //     }
          //   }
          // }
          //writeData(sendCommandAllOFF());
          //print('Element Address of Send Command ' + lightItem.element.address.toString());
          List<GroupData> gdata =
              await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;
          print('Group Data : $gdata');
          await widget.nordicNrfMesh.meshManagerApi
              .sendGenericLevelSet(gdata[1].address, getIntFromHex('0C', '20'))
              .timeout(const Duration(seconds: 2));
        } else if (!isItFan &&
            !isScene &&
            !isAllOff &&
            isAllOn &&
            !isMasteroff &&
            !isDePair &&
            !isReg) {
          // await _device!.requestMtu(512);
          // List<BluetoothService> services = await _device!.discoverServices();
          // for (BluetoothService service in services) {
          //   print("Inside For Status");
          //   for (BluetoothCharacteristic characteristic
          //   in service.characteristics) {
          //     if (characteristic.properties.write) {
          //       print("Inside If Status");
          //       await characteristic.write(utf8.encode(sendCommandForAllON()),
          //           withoutResponse: true);
          //       //await addIntoQueue(sendCommandForAllON());
          //       print("Call 201");
          //       // }
          //
          //     }
          //   }
          // }
          //writeData(sendCommandForAllON());
          //print('Element Address of Send Command ' + lightItem.element.address.toString());

          List<GroupData> gdata =
              await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups!;
          print('Group Data : ' + gdata.toString());
          await widget.nordicNrfMesh.meshManagerApi
              .sendGenericLevelSet(gdata[1].address, getIntFromHex('0D', '10'))
              .timeout(const Duration(seconds: 2));
        } else if (!isItFan &&
            !isScene &&
            !isAllOff &&
            !isAllOn &&
            isMasteroff &&
            !isDePair &&
            !isReg) {
          // await _device!.requestMtu(512);
          // List<BluetoothService> services = await _device!.discoverServices();
          // for (BluetoothService service in services) {
          //   print("Inside For Status");
          //   for (BluetoothCharacteristic characteristic
          //   in service.characteristics) {
          //     if (characteristic.properties.write) {
          //       print("Inside If Status");
          //       await characteristic.write(utf8.encode(sendCommandMasterOFF()),
          //           withoutResponse: true);
          //       //await addIntoQueue(sendCommandMasterOFF());
          //       print("Call 201");
          //       // }
          //
          //     }
          //   }
          // }
          //writeData(sendCommandMasterOFF());
          //print('Element Address of Send Command ' + lightItem.element.address.toString());
          List<GroupData> gdata =
              await widget.nordicNrfMesh.meshManagerApi.meshNetwork!.groups;
          print('Group Data : $gdata');
          await widget.nordicNrfMesh.meshManagerApi
              .sendGenericLevelSet(gdata[0].address, getIntFromHex('0F', '20'))
              .timeout(const Duration(seconds: 2));
        } else {
          print("inside else");
        }
      }
    } on PlatformException catch (e) {
      print(e.code.toString());
      if (e.code.toString().contains("connected first?")) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<void> sendCommandToDeviceNew(
      String lastCommandSent,
      LightItem lightItem,
      FanItem fanItem,
      bool isItFan,
      SceneItem sceneItem,
      bool isScene,
      bool isAllOFF,
      bool isAllON,
      bool isMasterOff,
      bool isDePair,
      bool isStatus,
      bool isReg) async {
    await sendToDeviceNew(lightItem, fanItem, isItFan, sceneItem, isScene,
        isAllOFF, isAllON, isMasterOff, isDePair, isStatus, isReg);
  }

  onSwitches(lightItem, String switchesName) async {
    setState(() {
      light = lightItem.getName();
      ex = true;
    });
    print("lightitemclick   ${lightItem.getName()}");
    Vibration.vibrate(duration: 100);
    sendCommandCMID(lightItem, FanItem.name(0), false, SceneItem.name(""),
        false, false, false, false, false, false, false);

    // setState(() {
    if (lightItem.isSelectedindicator == true) {
      lightItem.isSelectedindicator = false;
    } else {
      lightItem.isSelectedindicator = true;
    }
    lightItem.itemCount = 0;
    lightItem.time.cancel();
    // });

    lightItem.time =
        Timer.periodic(const Duration(milliseconds: 15), (Timer t) {
      // setState(() {
      lightItem.itemCount = (lightItem.itemCount + 1);
      // });
      if (lightItem.itemCount >= 100) {
        // setState(() {
        lightItem.time.cancel();
        lightItem.itemCount = 0;
        // });
      }
    });
  }

  Widget buildItem(
      LightItem lightItem, double height, double width, int position) {
    print("====================================");
    print(lightItem);
    TextEditingController editingController = TextEditingController();
    var foucs = new FocusNode();
    editingController.text = lightItem.getName();
    if (ak) {
      getButtonData(editingController);
    }
    print("textinfo===================" + editingController.text.toString());
    editingController.selection = TextSelection.fromPosition(
        TextPosition(offset: editingController.text.length));
    switchFocusNode = FocusNode();

    String oldLightName = "";
    if (position < 9) {
      oldLightName = "SW 0${position + 1}";
    } else {
      oldLightName = "SW ${position + 1}";
    }

    return GestureDetector(
        // onTapDown: (_) {
        onTap: () async {
          Vibration.vibrate(duration: 100);
          sendCommandCMID(lightItem, FanItem.name(0), false, SceneItem.name(""),
              false, false, false, false, false, false, false);

          setState(() {
            if (lightItem.isSelectedindicator == true) {
              lightItem.isSelectedindicator = false;
            } else {
              lightItem.isSelectedindicator = true;
            }
            lightItem.itemCount = 0;
            lightItem.time.cancel();
          });

          lightItem.time =
              Timer.periodic(const Duration(milliseconds: 15), (Timer t) {
            setState(() {
              lightItem.itemCount = (lightItem.itemCount + 1);
            });
            if (lightItem.itemCount >= 100) {
              setState(() {
                lightItem.time.cancel();
                lightItem.itemCount = 0;
              });
            }
          });
        },
        onLongPress: () {
          disableTextFields();
          Alignment alignment;
          if (position < 4) {
            alignment = const Alignment(0, 0);
          } else if (position < 8) {
            alignment = const Alignment(0, 0.25);
          } else if (position < 12) {
            alignment = const Alignment(0, 0.5);
          } else {
            alignment = const Alignment(0, 0.1);
          }
          renameDragDialog(context, 900, width, alignment, lightItem.getName(),
              () {
            setState(() {
              lightItem.setEditable(true);
              Future.delayed(const Duration(milliseconds: 100), () async {
                FocusManager.instance.primaryFocus
                    ?.requestFocus(lightItem.getFocusNode());
              });
            });
          }, () {
            Future.delayed(Duration.zero, () async {
              lightItem.setDragging(true);
              for (int i = 0; i < lightList.length; i++) {
                lightList[i].setDraggable(true);
              }
              setState(() {});
            });
          });
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: lightItem.getIsDragging()
                  ? BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10))
                  : const BoxDecoration(),
              child: Image.asset(
                  allONEnabled
                      ? switchSelectedImage
                      : allOFFEnabled
                          ? switchUnSelectedImage
                          : lightItem.getImage(),
                  height: getHeight(1200, dialogSwitchHeight),
                  width: getWidth(width, dialogSwitchWidth),
                  fit: BoxFit.fill),
            ),
            if (lightItem.getIsRenamed() && oldLightName != lightItem.getName())
              Container(
                  margin: const EdgeInsets.only(top: 6),
                  child: Text(oldLightName,
                      style: const TextStyle(
                          color: highLightColor,
                          //fontFamily: "Inter",
                          fontSize: homePageButtonTextSize,
                          fontWeight: FontWeight.bold))),
            Positioned.fill(
              top: lightItem.getIsRenamed() ? getY(height, 6) : 0,
              child: Material(
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    enableInteractiveSelection: false,
                    cursorColor: dialogTitleColor,
                    focusNode: lightItem.getFocusNode(),
                    autofocus: true,
                    controller: editingController,
                    enabled: lightItem.getEditable(),
                    onSubmitted: (text) {
                      submitSwitch(text, lightItem);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                        height: cursorHeight,
                        decoration: TextDecoration.none,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                        fontStyle: FontStyle.normal,
                        fontSize: getAdaptiveTextSize(
                            context, homePageButtonTextSize)),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(textFieldMaxLength),
                    ],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ));
    //   renameDragDialog(
    //       context, 600, width, alignment, lightItem.getName(), () {
    //     setState(() {
    //       lightItem.setRenamed(true);
    //
    //       Future.delayed(const Duration(milliseconds: 100), () async {
    //         FocusManager.instance.primaryFocus
    //             ?.requestFocus(lightItem.getFocusNode());
    //       });
    //     });
    //   }, () {
    //     Future.delayed(Duration.zero, () async {
    //       lightItem.setDragging(true);
    //       for (int i = 0; i < lightList.length; i++) {
    //         lightList[i].setDraggable(true);
    //       }
    //       setState(() {
    //
    //       });
    //     });
    //   });
    // },
    // child: Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Container(
    //       decoration: lightItem.getIsDragging()
    //           ? BoxDecoration(
    //           border: Border.all(width: 2),
    //           borderRadius: BorderRadius.circular(10))
    //           : const BoxDecoration(),
    //       child: Image.asset(
    //           allONEnabled
    //               ? switchSelectedImage
    //               : allOFFEnabled
    //               ? switchUnSelectedImage
    //               : lightItem.getImage(),
    //           height: getHeight(1200, dialogSwitchHeight),
    //           width: getWidth(width, dialogSwitchWidth),
    //           fit: BoxFit.fill),
    //     ),
    //     if (lightItem.getIsRenamed() && oldLightName != lightItem.getName())
    //       Container(
    //           margin: const EdgeInsets.only(top: 6),
    //           child: Text(oldLightName,
    //               style: const TextStyle(
    //                   color: highLightColor,
    //                   //fontFamily: "Inter",
    //                   fontSize: homePageButtonTextSize,
    //                   fontWeight: FontWeight.bold))),

    // Positioned.fill(
    //   top: lightItem.getIsRenamed() ? getY(height, 6) : 0,
    //   child: Material(
    //     color: Colors.transparent,
    //     child: Align(
    //       alignment: Alignment.center,
    //       child: TextField(
    //         enableInteractiveSelection: false,
    //         cursorColor: dialogTitleColor,
    //         focusNode: lightItem.getFocusNode(),
    //         autofocus: true,
    //         controller: editingController,
    //         enabled: lightItem.getEditable(),
    //         onSubmitted: (text) {
    //           setState(() {
    //             lightItem.setEditable(false);
    //           });
    //           if (text.isNotEmpty && text != lightItem.getName()) {
    //             setState(() {
    //               lightItem.setRenamed(true);
    //               lightItem.setName(text.toUpperCase());
    //             });
    //           }
    //         },
    //         decoration: const InputDecoration(
    //           border: InputBorder.none,
    //           isDense: true,
    //           contentPadding: EdgeInsets.zero,
    //         ),
    //         style: TextStyle(
    //             height: cursorHeight,
    //             decoration: TextDecoration.none,
    //             color: textColor,
    //             fontWeight: FontWeight.bold,
    //             //fontFamily: "Inter",
    //             fontStyle: FontStyle.normal,
    //             fontSize: getAdaptiveTextSize(
    //                 context, homePageButtonTextSize)),
    //         inputFormatters: [
    //           LengthLimitingTextInputFormatter(textFieldMaxLength),
    //         ],
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //   ),
    // ),
    //image height
    // Image.asset(lightItem.getImage(),
    //     height: getHeight(height, 85.64),
    //     width: getWidth(width, 74.09),
    //     fit: BoxFit.fill),

    // Positioned.fill(
    //   child: Align(
    //       alignment: Alignment.center,
    //       child: SquarePercentIndicatorWidget(
    //         height: getHeight(height, 83.64),
    //         width: getWidth(width, 70.09),
    //         startAngle: StartAngle.topLeft,
    //         reverse: lightItem.isSelectedindicator,
    //         progress: lightItem.itemCount / 100,
    //
    //         // reverse: true,
    //         // borderRadius: 12,
    //         shadowWidth: 0.1,
    //         progressWidth: 1,
    //         shadowColor: Colors.white,
    //         progressColor: Colors.white,
    //         child: Container(
    //           alignment: Alignment.center,
    //           child: Text(
    //               lightItem.getName(),
    //               style: TextStyle(
    //                   color: textColor,
    //                   fontWeight: FontWeight.w400,
    //                   fontFamily: "Inter",
    //                   fontStyle: FontStyle.normal,
    //                   fontSize: getAdaptiveTextSize(context, 10.3)),
    //               textAlign:
    //               TextAlign.center),
    //
    //         ),
    //       )),
    // ),
  }

  void submitSwitch(String text, lightItem) async {
    NetworkApiService apiService = NetworkApiService();
    UpdateRoomCmacSwitch request = UpdateRoomCmacSwitch(
        applicationId: "abc",
        updatedBy: await LocalStorageService.getAppId(),
        updatedDateTime:
            (DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'))
                .toString(),
        id: 0,
        switchDisplayName: text.toString(),
        roomCmacUpdateSwitchName: text.toString());
    await apiService.add(
        ApiEndPoints.UPDATE_ROOM_SWITCH_NAME, request, UpdateRoomCmacSwitch);
    print("submit" + text);
    setState(() {
      lightItem.setEditable(false);
    });
    if (text.isNotEmpty && text != lightItem.getName()) {
      setState(() {
        lightItem.setRenamed(true);
        lightItem.setName(text.toUpperCase());
      });
    }
    SharedPreferences renameButton = await SharedPreferences.getInstance();
    int a = lightItem.cmIndex;
    renameButton.setString(a.toString(), text);
  }

  Widget buildItem3A(LightItem lightItem, double height, double width) {
    return GestureDetector(
        onTap: () {
          Vibration.vibrate(duration: 100);
          // sendCommandCMID(lightItem);
          // setState(() {
          //   if (lightItem.getImage() == "assets/images/lightunselect.png") {
          //     lightItem.setImage("assets/images/lightselect.png");
          //     lightItem.setSelectd(true);
          //   } else {
          //     lightItem.setImage("assets/images/lightunselect.png");
          //     lightItem.setSelectd(false);
          //   }
          // });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(lightItem.getImage(),
                height: getHeight(height, 65.78),
                width: getWidth(width, 74.09),
                fit: BoxFit.fill),
            Positioned.fill(
              child: Align(
                  child: Text(lightItem.getName(),
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                          fontSize: getAdaptiveTextSize(context, 10.3)),
                      textAlign: TextAlign.center)),
            ),
          ],
        ));
  }

  //
  // Widget buildItem3A(LightItem lightItem, double height, double width,
  //     bool allONEnabled, bool allOFFEnabled) {
  //   TextEditingController editingController = TextEditingController();
  //   editingController.text = lightItem.getName();
  //   FocusNode focusNode = FocusNode();
  //
  //   return GestureDetector(
  //       onTap: () {
  //         Utils.vibrateSound();
  //         setState(() {
  //           if (lightItem.getImage() == "assets/images/light_amp_off.png") {
  //             lightItem.setImage("assets/images/light_amp_on.png");
  //             lightItem.setSelectd(true);
  //           } else {
  //             lightItem.setImage("assets/images/light_amp_off.png");
  //             lightItem.setSelectd(false);
  //           }
  //         });
  //       },
  //       onLongPress: () {
  //         disableTextFields();
  //         renameDialog(context, height, width, const Alignment(0, 0),
  //             lightItem.getName(), () {
  //           setState(() {
  //             lightItem.setEditable(true);
  //           });
  //         });
  //       },
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           Image.asset(lightItem.getImage(),
  //               height: getHeight(height, dialogSwitchHeightLarge),
  //               width: getWidth(width, dialogSwitchWidth),
  //               fit: BoxFit.fill),
  //           Positioned.fill(
  //             child: Align(
  //                 alignment: Alignment.center,
  //                 child: Material(
  //                   color: Colors.transparent,
  //                   child: TextField(
  //                     enableInteractiveSelection: false,
  //                     cursorColor: dialogTitleColor,
  //                     //focusNode: focusNode,
  //                     //autofocus: true,
  //                     controller: editingController,
  //                     enabled: lightItem.getEditable(),
  //                     onSubmitted: (text) {
  //                       if (text.isNotEmpty) {
  //                         setState(() {
  //                           lightItem.setName(text.toUpperCase());
  //                           lightItem.setEditable(false);
  //                         });
  //                       }
  //                     },
  //                     decoration:
  //                         const InputDecoration(border: InputBorder.none),
  //                     style: TextStyle(
  //                         height: cursorHeight,
  //                         decoration: TextDecoration.none,
  //                         color: textColor,
  //                         fontWeight: FontWeight.bold,
  //                         //fontFamily: "Inter",
  //                         fontStyle: FontStyle.normal,
  //                         fontSize: getAdaptiveTextSize(
  //                             context, homePageButtonTextSize)),
  //                     inputFormatters: [
  //                       LengthLimitingTextInputFormatter(textFieldMaxLength),
  //                     ],
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 )),
  //           ),
  //         ],
  //       ));
  // }

  void openDialog() {
    showGeneralDialog(
      context: context,
      //barrierColor: Colors.black38,
      barrierLabel: 'Label',
      barrierDismissible: true,
      pageBuilder: (_, __, ___) => const Center(
        child: Material(
          color: Colors.transparent,
          child: Text(
            'Dialog',
            style: TextStyle(color: Colors.black, fontSize: 40),
          ),
        ),
      ),
    );
  }

  Future<void> publish(String text, String topic) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(text.toString());

    print("clientPayloadBuilder 3  ${builder.payload}");
    if (client != null) {
      print("clientPayloadBuilder 4" + text.toString());
      client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
    } else {
      print("inside client");
    }
  }

  String masterOFFImage = unSelectedButtonImage;
  String allONImage = unSelectedButtonImage;
  String allOFFImage = unSelectedButtonImage;
  bool addDeviceCalled = false;

  Widget getPositionThirdRow(double height, double width) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: animatedDuration),
      top: getY(height, isExpandPairTop ? 233 : 178),
      left: getX(width, 30),
      child: SizedBox(
        height: getHeight(height, 38.55),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: [
            GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           PairingPage(_device, _services)),
                  // );
                  setState(() {
                    addDeviceCalled = true;
                  });
                },
                child: Stack(alignment: Alignment.center, children: [
                  Image.asset(unSelectedButtonImage,
                      height: getHeight(height, homePageListButtonHeight),
                      width: getWidth(width, homePageListButtonWidth),
                      fit: BoxFit.fill),
                  Align(
                      child: Text("ADD\nDEVICE",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              //fontFamily: "Inter",
                              fontStyle: FontStyle.normal,
                              fontSize: getAdaptiveTextSize(
                                  context, homePageButtonTextSize)),
                          textAlign: TextAlign.center))
                ])),
            SizedBox(
              width: getWidth(width, homePageItemHorizontalMargin),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(unSelectedButtonImage,
                    height: getHeight(height, homePageListButtonHeight),
                    width: getWidth(width, homePageListButtonWidth),
                    fit: BoxFit.fill),
                Positioned.fill(
                  child: Align(
                      child: Text("DEMO",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              //fontFamily: "Inter",
                              fontStyle: FontStyle.normal,
                              fontSize: getAdaptiveTextSize(
                                  context, homePageButtonTextSize)),
                          textAlign: TextAlign.center)),
                ),
              ],
            ),
            SizedBox(
              width: getWidth(width, homePageItemHorizontalMargin),
            ),
            InkWell(
              onTap: () {
                light = null;
                Vibration.vibrate(duration: 100);
                // sendONOFFGen(6,true);
                sendCommandCMID(
                    LightItem.name(0),
                    FanItem.name(0),
                    false,
                    SceneItem.name(""),
                    false,
                    false,
                    true,
                    false,
                    false,
                    false,
                    false);
                setState(() {
                  if (indicatorAllON.getSelected() == true) {
                    indicatorAllON.setSelectd(false);
                  } else {
                    indicatorAllON.setSelectd(true);
                  }
                  indicatorAllON.itemCount = 0;
                  indicatorAllON.time.cancel();
                });

                indicatorAllON.time =
                    Timer.periodic(const Duration(milliseconds: 15), (Timer t) {
                  setState(() {
                    indicatorAllON.itemCount = (indicatorAllON.itemCount + 1);
                  });
                  if (indicatorAllON.itemCount >= 100) {
                    setState(() {
                      indicatorAllON.time.cancel();
                      indicatorAllON.itemCount = 0;
                    });
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(allONImage,
                      height: getHeight(height, homePageListButtonHeight),
                      width: getWidth(width, homePageListButtonWidth),
                      fit: BoxFit.fill),
                  Positioned.fill(
                    child: Align(
                        child: Text("ALL ON",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                //fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                fontSize: getAdaptiveTextSize(
                                    context, homePageButtonTextSize)),
                            textAlign: TextAlign.center)),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: getWidth(width, homePageItemHorizontalMargin),
            ),
            InkWell(
              onTap: () {
                light = null;
                Vibration.vibrate(duration: 100);
                sendCommandCMID(
                    LightItem.name(0),
                    FanItem.name(0),
                    false,
                    SceneItem.name(""),
                    false,
                    true,
                    false,
                    false,
                    false,
                    false,
                    false);

                setState(() {
                  if (indicatorAllOF.getSelected() == true) {
                    indicatorAllOF.setSelectd(false);
                  } else {
                    indicatorAllOF.setSelectd(true);
                  }
                  indicatorAllOF.itemCount = 0;
                  indicatorAllOF.time.cancel();
                });

                indicatorAllOF.time =
                    Timer.periodic(const Duration(milliseconds: 15), (Timer t) {
                  setState(() {
                    indicatorAllOF.itemCount = (indicatorAllOF.itemCount + 1);
                  });
                  if (indicatorAllOF.itemCount >= 100) {
                    setState(() {
                      indicatorAllOF.time.cancel();
                      indicatorAllOF.itemCount = 0;
                    });
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(allOFFImage,
                      height: getHeight(height, homePageListButtonHeight),
                      width: getWidth(width, homePageListButtonWidth),
                      fit: BoxFit.fill),
                  Positioned.fill(
                    child: Align(
                        child: Text("ALL OFF",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                //fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                fontSize: getAdaptiveTextSize(
                                    context, homePageButtonTextSize)),
                            textAlign: TextAlign.center)),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: getWidth(width, homePageItemHorizontalMargin),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPositionFirstRow(double height, double width) {
    return Positioned(
      top: getY(height, 124),
      left: getX(width, 30),
      child: IgnorePointer(
        ignoring: !isExpandPairTop,
        child: AnimatedOpacity(
          opacity: isExpandPairTop ? 1.0 : 0.0,
          duration: isExpandPairTop
              ? Duration(milliseconds: (animatedDuration * 1.5).toInt())
              : const Duration(milliseconds: animatedDuration ~/ 2),
          child: SizedBox(
            height: getHeight(height, 38.55),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(unSelectedButtonImage,
                        height: getHeight(height, homePageListButtonHeight),
                        width: getWidth(width, homePageListButtonWidth),
                        fit: BoxFit.fill),
                    Positioned.fill(
                      child: Align(
                          child: Text("",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: "Inter",
                                  fontStyle: FontStyle.normal,
                                  fontSize: getAdaptiveTextSize(
                                      context, homePageButtonTextSize)),
                              textAlign: TextAlign.center)),
                    ),
                  ],
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/mic_off.png',
                        height: getHeight(height, homePageListButtonHeight),
                        width: getWidth(width, homePageListButtonWidth),
                        fit: BoxFit.fill),
                    // Positioned.fill(
                    //   child: Align(
                    //       child: Text("",
                    //           style: TextStyle(
                    //               color: const Color(0xffffffff),
                    //               fontWeight: FontWeight.w400,
                    //               fontFamily: "Inter",
                    //               fontStyle: FontStyle.normal,
                    //               fontSize: getAdaptiveTextSize(
                    //                   context, homePageButtonTextSize)),
                    //           textAlign: TextAlign.center)),
                    // ),
                  ],
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      masterOFFImage = selectedButtonImage;
                      allONImage = unSelectedButtonImage;
                      allOFFImage = unSelectedButtonImage;

                      allONEnabled = false;
                      allOFFEnabled = true;
                      scenesEnabled = false;
                    });
                    Future.delayed(const Duration(seconds: 3), () async {
                      setState(() {
                        masterOFFImage = unSelectedButtonImage;
                      });
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(masterOFFImage,
                          height: getHeight(height, homePageListButtonHeight),
                          width: getWidth(width, homePageListButtonWidth),
                          fit: BoxFit.fill),
                      Positioned.fill(
                        child: Align(
                            child: Text("MASTER\nOFF",
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "Inter",
                                    fontStyle: FontStyle.normal,
                                    fontSize: getAdaptiveTextSize(
                                        context, homePageButtonTextSize)),
                                textAlign: TextAlign.center)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/search_off.png',
                        height: getHeight(height, homePageListButtonHeight),
                        width: getWidth(width, homePageListButtonWidth),
                        fit: BoxFit.fill),
                    // Positioned.fill(
                    //   child: Align(
                    //       child: Text("",
                    //           style: TextStyle(
                    //               color: const Color(0xffffffff),
                    //               fontWeight: FontWeight.w400,
                    //               fontFamily: "Inter",
                    //               fontStyle: FontStyle.normal,
                    //               fontSize: getAdaptiveTextSize(
                    //                   context, homePageButtonTextSize)),
                    //           textAlign: TextAlign.center)),
                    // ),
                  ],
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPositionTopDivider(double height, double width) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: animatedDuration),
        left: 0,
        top: getY(height, isExpandPairTop ? 287 : 231),
        child: Container(
            width: getWidth(width, 414),
            height: 2.002,
            decoration: BoxDecoration(
                border: Border.all(
                    color: homePageDividerColor, width: 2.0024185180664062))));
  }

  Widget getPositionTopArrow(double height, double width) {
    return Positioned(
      right: getX(width, 11),
      top: getY(
          height,
          isExpandPairTop
              ? 309
              : isExpandPairBottom
                  ? 247
                  : 247),
      child: GestureDetector(
        onTap: () {
          // setState(() {
          //   if (isExpandPair1 == true) {
          //     isExpandPair1 = false;
          //     //extendheight = 430.18;
          //     extendheight = 469;
          //     top1 = 231;
          //     top2 = 220.34;
          //     //top3 = 420.20;
          //     top3 = 650;
          //     //top4 = 370.07;
          //     top4 = 420.07;
          //     //top5 = 370.07;
          //     top5 = 420.07;
          //     top6 = 268;
          //   } else {
          //     isExpandPair1 = true;
          //     extendheight = 302;
          //     top = 233;
          //     top1 = 287;
          //     top2 = 283.34;
          //     //top3 = 520.20;
          //     top3 = 650;
          //     top4 = 470.07;
          //     top5 = 470.07;
          //     top6 = 268;
          //   }
          // });
        },
        child: const Icon(
          Icons.arrow_drop_up,
          size: 20,
          color: textColor,
        ),
      ),
    );
  }

  Widget getPositionDownArrow(double height, double width) {
    return Positioned(
      // top: getY(height, top3) +
      //     getNextFenControlPosition(lightList.length, 53.64, 35),
      top: getY(height, isExpandPairTop || isExpandPairBottom ? 566 : 669),
      right: getX(width, 11),
      child: GestureDetector(
        child: const Icon(
          Icons.arrow_drop_down,
          size: 20,
          color: textColor,
        ),
      ),
    );
  }

  Widget getPositionLeftArrow(double height, double width) {
    return Positioned(
      left: getX(width, 11),
      top:
          getY(height, ((isExpandPairTop ? 287 : 231) + extendHeight / 2) - 11),
      child: GestureDetector(
        onTap: () {
          _currentFocusedIndex--;
          if (_currentFocusedIndex < 0) {
            _currentFocusedIndex = items.length - 1;
          }

          controller.scrollToIndex(_currentFocusedIndex,
              preferPosition: AutoScrollPosition.begin);

          setState(() {});
        },
        child: const Icon(
          Icons.arrow_left,
          size: 20,
          color: textColor,
        ),
      ),
    );
  }

  Widget getPositionRightArrow(double height, double width) {
    return Positioned(
      right: getX(width, 11),
      top:
          getY(height, ((isExpandPairTop ? 287 : 231) + extendHeight / 2) - 11),
      child: GestureDetector(
        onTap: () {
          _currentFocusedIndex--;
          if (_currentFocusedIndex < 0) {
            _currentFocusedIndex = items.length - 1;
          }

          controller.scrollToIndex(_currentFocusedIndex,
              preferPosition: AutoScrollPosition.begin);

          setState(() {});
        },
        child: const Icon(
          Icons.arrow_right,
          size: 20,
          color: textColor,
        ),
      ),
    );
  }

  Widget getPositionBottomDivider(double height, double width) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: animatedDuration),
        left: 0,
        top: getY(height, !isExpandPairBottom ? 700 : 588),
        child: Container(
            width: getWidth(width, 414),
            height: 2.002,
            decoration: BoxDecoration(
                border: Border.all(
                    color: homePageDividerColor, width: 2.0024185180664062))));
  }

  TextEditingController homeController = TextEditingController(text: "HOME");
  FocusNode homeFocusNode = FocusNode();
  bool homeEditable = false;

  TextEditingController myRemoteController =
      TextEditingController(text: "MY REMOTE");
  FocusNode myRemoteFocusNode = FocusNode();
  bool myRemoteEditable = false;
  Future<void> getInfo() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString("name").toString() != "null") {
      homeController.text = prefs.getString("name").toString();
    }
  }

  Widget getPositionSecondLastRow(double height, double width) {
    getInfo();
    homeController.selection = TextSelection.fromPosition(
        TextPosition(offset: homeController.text.length));
    myRemoteController.selection = TextSelection.fromPosition(
        TextPosition(offset: myRemoteController.text.length));

    return Positioned(
      top: getY(height, 664),
      left: getX(width, 30),
      child: IgnorePointer(
        ignoring: !isExpandPairBottom,
        child: AnimatedOpacity(
          opacity: isExpandPairBottom ? 1.0 : 0.0,
          duration: isExpandPairBottom
              ? Duration(milliseconds: (animatedDuration * 1.5).toInt())
              : const Duration(milliseconds: animatedDuration ~/ 2),
          child: SizedBox(
            height: getHeight(height, 38.55),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: [
                GestureDetector(
                  onTap: () {
                    Utils.vibrateSound();
                    setState(() {
                      isExpandPairBottom = false;
                      extendHeight = 469;

                      if (topTimer != null) {
                        if (topTimer!.isActive) {
                          topTimer!.cancel();
                        }
                      }

                      if (bottomTimer != null) {
                        if (bottomTimer!.isActive) {
                          bottomTimer!.cancel();
                        }
                      }

                      myRemoteEnabled = true;
                      tvEnabled = false;
                      acEnabled = false;
                      stbEnabled = false;
                    });
                    pageController.jumpToPage(4);
                  },
                  onLongPress: () {
                    renameDialogOpened = true;
                    disableTextFields();
                    setState(() {
                      renameDialog(context, height, width,
                          const Alignment(0, 0.35), "MY REMOTE", () {
                        setState(() {
                          myRemoteEditable = true;

                          Future.delayed(const Duration(milliseconds: 100),
                              () async {
                            FocusManager.instance.primaryFocus
                                ?.requestFocus(myRemoteFocusNode);
                          });
                        });
                      });
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                          myRemoteEnabled
                              ? selectedButtonImage
                              : unSelectedButtonImage,
                          height: getHeight(height, homePageListButtonHeight),
                          width: getWidth(width, homePageListButtonWidth),
                          fit: BoxFit.fill),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            cursorColor: dialogTitleColor,
                            focusNode: myRemoteFocusNode,
                            //autofocus: true,
                            controller: myRemoteController,
                            enabled: myRemoteEditable,
                            onSubmitted: (text) {
                              renameDialogOpened = false;
                              if (text.isNotEmpty) {
                                setState(() {
                                  myRemoteController.text = text.toUpperCase();
                                  myRemoteEditable = false;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(
                                height: cursorHeight,
                                decoration: TextDecoration.none,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                //fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                fontSize: getAdaptiveTextSize(
                                    context, homePageButtonTextSize)),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  textFieldMaxLength),
                            ],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
                GestureDetector(
                  onTap: () {
                    homeListOptions(context, height, width);
                  },
                  onLongPress: () {
                    renameDialogOpened = true;
                    disableTextFields();
                    renameDialog(context, height, width,
                        const Alignment(0, 0.35), "HOME", () {
                      setState(() {
                        homeEditable = true;

                        Future.delayed(const Duration(milliseconds: 100),
                            () async {
                          FocusManager.instance.primaryFocus
                              ?.requestFocus(homeFocusNode);
                        });
                      });
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(unSelectedButtonImage,
                          height: getHeight(height, homePageListButtonHeight),
                          width: getWidth(width, homePageListButtonWidth),
                          fit: BoxFit.fill),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            cursorColor: dialogTitleColor,
                            focusNode: homeFocusNode,
                            //autofocus: true,
                            controller: homeController,
                            enabled: homeEditable,
                            onSubmitted: (text) {
                              renameDialogOpened = false;
                              if (text.isNotEmpty) {
                                setState(() {
                                  homeController.text = text.toUpperCase();
                                  homeEditable = false;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(
                                height: cursorHeight,
                                decoration: TextDecoration.none,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                //fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                fontSize: getAdaptiveTextSize(
                                    context, homePageButtonTextSize)),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  textFieldMaxLength),
                            ],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(unSelectedButtonImage,
                        height: getHeight(height, homePageListButtonHeight),
                        width: getWidth(width, homePageListButtonWidth),
                        fit: BoxFit.fill),
                    Positioned.fill(
                      child: Align(
                          child: Text("WIFI\nDEVICES",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: "Inter",
                                  fontStyle: FontStyle.normal,
                                  fontSize: getAdaptiveTextSize(
                                      context, homePageButtonTextSize)),
                              textAlign: TextAlign.center)),
                    ),
                  ],
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                        tvEnabled || acEnabled || stbEnabled
                            ? selectedButtonImage
                            : unSelectedButtonImage,
                        height: getHeight(height, homePageListButtonHeight),
                        width: getWidth(width, homePageListButtonWidth),
                        fit: BoxFit.fill),
                    Positioned.fill(
                      child: Align(
                          child: Text("IR\nDevices",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: "Inter",
                                  fontStyle: FontStyle.normal,
                                  fontSize: getAdaptiveTextSize(
                                      context, homePageButtonTextSize)),
                              textAlign: TextAlign.center)),
                    ),
                  ],
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void homeListOptions(
    BuildContext context,
    double height,
    double width,
  ) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Align(
            alignment: const Alignment(0, 0.57),
            child: Container(
              width: getWidth(width, 290.0),
              height: getHeight(height, 120.0),
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(14.86390495300293)),
                border: Border.all(
                    color: homePageDividerColor, width: 1.0617074966430664),
                // boxShadow: const [
                //   BoxShadow(
                //       color: Color(0x40000000),
                //       offset: Offset(5.308538436889648, 5.308538436889648),
                //       blurRadius: 6.370244979858398,
                //       spreadRadius: 0)
                // ],
                //color: const Color(0xff484949)
                image: const DecorationImage(
                    image: AssetImage(alertDialogBg), fit: BoxFit.fill),
              ),

              child: Stack(
                children: [
                  DialogTitle(20.57, 31.85, "SELECT PLACE", 12.0, "Roboto"),
                  DialogCloseButton(15, 27, () {
                    Navigator.pop(context);
                  }),
                  Positioned(
                    top: getHeight(height, 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _currentFocusedIndex--;
                            // if (_currentFocusedIndex < 0) {
                            //   _currentFocusedIndex = itemsPlaces.length - 1;
                            // }
                            //
                            // controllerPlace.scrollToIndex(
                            //     _currentFocusedIndex,
                            //     preferPosition: AutoScrollPosition.begin);
                            //
                            // setState(() {});
                          },
                          child: const Icon(
                            Icons.arrow_left,
                            size: 20,
                            color: arrowColor,
                          ),
                        ),
                        SizedBox(
                          width: getWidth(width, 245.0),
                          height: getHeight(height, 38.55),
                          child: HomePageSelectPlaceList(width, height),
                        ),
                        GestureDetector(
                          onTap: () {
                            // _currentFocusedIndex--;
                            // if (_currentFocusedIndex < 0) {
                            //   _currentFocusedIndex = itemsPlaces.length - 1;
                            // }
                            // controllerPlace.scrollToIndex(
                            //     _currentFocusedIndex,
                            //     preferPosition: AutoScrollPosition.begin);
                            //
                            // setState(() {});
                          },
                          child: const Icon(
                            Icons.arrow_right,
                            size: 20,
                            color: arrowColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool myRemoteEnabled = false;
  bool tvEnabled = false;
  bool acEnabled = false;
  bool stbEnabled = false;

  bool tvEditable = false;
  bool acEditable = false;
  bool stbEditable = false;

  TextEditingController tvController = TextEditingController(text: "TV");
  FocusNode tvFocusNode = FocusNode();

  TextEditingController acController = TextEditingController(text: "AC");
  FocusNode acFocusNode = FocusNode();

  TextEditingController stbController = TextEditingController(text: "STB");
  FocusNode stbFocusNode = FocusNode();

  Widget getPositionLastRow(double height, double width) {
    tvController.selection = TextSelection.fromPosition(
        TextPosition(offset: tvController.text.length));
    acController.selection = TextSelection.fromPosition(
        TextPosition(offset: acController.text.length));
    stbController.selection = TextSelection.fromPosition(
        TextPosition(offset: stbController.text.length));
    return Positioned(
      top: getY(height, 718),
      left: getX(width, 30),
      child: IgnorePointer(
        ignoring: !isExpandPairBottom,
        child: AnimatedOpacity(
          opacity: isExpandPairBottom ? 1.0 : 0.0,
          duration: isExpandPairBottom
              ? Duration(milliseconds: (animatedDuration * 1.5).toInt())
              : const Duration(milliseconds: animatedDuration ~/ 2),
          child: SizedBox(
            height: getHeight(height, 38.55),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: [
                GestureDetector(
                  onTap: () {
                    // SwitchesDialog(context,widget.width );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(unSelectedButtonImage,
                          height: getHeight(height, homePageListButtonHeight),
                          width: getWidth(width, homePageListButtonWidth),
                          fit: BoxFit.fill),
                      Positioned.fill(
                        child: Align(
                            child: Text("SWITCHES",
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "Inter",
                                    fontStyle: FontStyle.normal,
                                    fontSize: getAdaptiveTextSize(
                                        context, homePageButtonTextSize)),
                                textAlign: TextAlign.center)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
                GestureDetector(
                  onTap: () {
                    Utils.vibrateSound();
                    setState(() {
                      isExpandPairBottom = false;
                      extendHeight = 469;

                      if (topTimer != null) {
                        if (topTimer!.isActive) {
                          topTimer!.cancel();
                        }
                      }

                      if (bottomTimer != null) {
                        if (bottomTimer!.isActive) {
                          bottomTimer!.cancel();
                        }
                      }

                      myRemoteEnabled = false;
                      tvEnabled = true;
                      acEnabled = false;
                      stbEnabled = false;
                    });
                    pageController.jumpToPage(1);
                  },
                  onLongPress: () {
                    renameDialogOpened = true;
                    disableTextFields();
                    renameDialog(
                        context, height, width, const Alignment(0, 0.35), "TV",
                        () {
                      setState(() {
                        tvEditable = true;

                        Future.delayed(const Duration(milliseconds: 100),
                            () async {
                          FocusManager.instance.primaryFocus
                              ?.requestFocus(tvFocusNode);
                        });
                      });
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                          tvEnabled
                              ? selectedButtonImage
                              : unSelectedButtonImage,
                          height: getHeight(height, homePageListButtonHeight),
                          width: getWidth(width, homePageListButtonWidth),
                          fit: BoxFit.fill),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            cursorColor: dialogTitleColor,
                            focusNode: tvFocusNode,
                            //autofocus: true,
                            controller: tvController,
                            enabled: tvEditable,
                            onSubmitted: (text) {
                              renameDialogOpened = false;
                              if (text.isNotEmpty) {
                                setState(() {
                                  tvController.text = text.toUpperCase();
                                  tvEditable = false;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(
                                height: cursorHeight,
                                decoration: TextDecoration.none,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                //fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                fontSize: getAdaptiveTextSize(
                                    context, homePageButtonTextSize)),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  textFieldMaxLength),
                            ],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
                GestureDetector(
                  onTap: () {
                    Utils.vibrateSound();
                    setState(() {
                      isExpandPairBottom = false;
                      extendHeight = 469;

                      if (topTimer != null) {
                        if (topTimer!.isActive) {
                          topTimer!.cancel();
                        }
                      }

                      if (bottomTimer != null) {
                        if (bottomTimer!.isActive) {
                          bottomTimer!.cancel();
                        }
                      }

                      myRemoteEnabled = false;
                      tvEnabled = false;
                      acEnabled = true;
                      stbEnabled = false;
                    });
                    pageController.jumpToPage(2);
                  },
                  onLongPress: () {
                    renameDialogOpened = true;
                    disableTextFields();
                    renameDialog(
                        context, height, width, const Alignment(0, 0.35), "AC",
                        () {
                      setState(() {
                        acEditable = true;

                        Future.delayed(const Duration(milliseconds: 100),
                            () async {
                          FocusManager.instance.primaryFocus
                              ?.requestFocus(acFocusNode);
                        });
                      });
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                          acEnabled
                              ? selectedButtonImage
                              : unSelectedButtonImage,
                          height: getHeight(height, homePageListButtonHeight),
                          width: getWidth(width, homePageListButtonWidth),
                          fit: BoxFit.fill),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            cursorColor: dialogTitleColor,
                            focusNode: acFocusNode,
                            //autofocus: true,
                            controller: acController,
                            enabled: acEditable,
                            onSubmitted: (text) {
                              renameDialogOpened = false;
                              if (text.isNotEmpty) {
                                setState(() {
                                  acController.text = text.toUpperCase();
                                  acEditable = false;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(
                                height: cursorHeight,
                                decoration: TextDecoration.none,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                //fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                fontSize: getAdaptiveTextSize(
                                    context, homePageButtonTextSize)),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  textFieldMaxLength),
                            ],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
                GestureDetector(
                  onTap: () {
                    Utils.vibrateSound();
                    setState(() {
                      isExpandPairBottom = false;
                      extendHeight = 469;

                      if (topTimer != null) {
                        if (topTimer!.isActive) {
                          topTimer!.cancel();
                        }
                      }

                      if (bottomTimer != null) {
                        if (bottomTimer!.isActive) {
                          bottomTimer!.cancel();
                        }
                      }

                      myRemoteEnabled = false;
                      tvEnabled = false;
                      acEnabled = false;
                      stbEnabled = true;
                    });
                    pageController.jumpToPage(3);
                  },
                  onLongPress: () {
                    renameDialogOpened = true;
                    disableTextFields();
                    renameDialog(
                        context, height, width, const Alignment(0, 0.35), "STB",
                        () {
                      setState(() {
                        stbEditable = true;

                        Future.delayed(const Duration(milliseconds: 100),
                            () async {
                          FocusManager.instance.primaryFocus
                              ?.requestFocus(stbFocusNode);
                        });
                      });
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                          stbEnabled
                              ? selectedButtonImage
                              : unSelectedButtonImage,
                          height: getHeight(height, homePageListButtonHeight),
                          width: getWidth(width, homePageListButtonWidth),
                          fit: BoxFit.fill),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            cursorColor: dialogTitleColor,
                            focusNode: stbFocusNode,
                            //autofocus: true,
                            controller: stbController,
                            enabled: stbEditable,
                            onSubmitted: (text) {
                              renameDialogOpened = false;
                              if (text.isNotEmpty) {
                                setState(() {
                                  stbController.text = text.toUpperCase();
                                  stbEditable = false;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(
                                height: cursorHeight,
                                decoration: TextDecoration.none,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                fontSize: getAdaptiveTextSize(
                                    context, homePageButtonTextSize)),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  textFieldMaxLength),
                            ],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getWidth(width, homePageItemHorizontalMargin),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // bool isFan1Selected = false;
  // bool isFan2Selected = false;

  LoopPageController pageController = LoopPageController();

  // TextEditingController fan1Controller = TextEditingController(text: "FAN 1");
  // FocusNode fan1FocusNode = FocusNode();
  // bool fan1Editable = false;
//  bool fan1Renamed = false;

  TextEditingController fan2Controller = TextEditingController(text: "FAN 2");
  FocusNode fan2FocusNode = FocusNode();
  bool fan2Editable = false;
  bool fan2Renamed = false;

  bool isDeviceAddedLight() {
    for (LightItem item in _lightList) {
      if (item.roomID == RoomID) {
        return true;
      }
    }
    return false;
  }

  Widget getPositionBody(BuildContext context, double height, double width) {
    // print(_fanList);
    // print("=========================================================");
    print(_lightList.length.toString());
    double fanVerticalPosition = getNextFanControlPosition(
        _lightList.isNotEmpty
            ? isDeviceAddedLight() == true
                ? _lightList.length
                : 0
            : 0,
        66,
        getHeight(height, 35));
    return Positioned(
      top: getY(height, top6),
      left: getX(width, 32.54),
      right: getX(width, 32.54),
      child: SizedBox(
        width: getWidth(width, width),
        height: getHeight(height, extendheight - 20),
        child: PageView.builder(
            // controller: _controller,
            physics: const BouncingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, i) => Stack(
                  children: [
                    ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        children: [
                          SizedBox(
                              width: getWidth(width, width),
                              //height: getHeight(height, 700),
                              height:
                                  fanVerticalPosition + getHeight(height, 100),
                              child: Stack(
                                children: [
                                  _lightList.isNotEmpty
                                      ? SizedBox(
                                          // width: getWidth(
                                          //     width, width - 32.54 - 32.54),
                                          width: getWidth(width, width),
                                          //height: getHeight(height, 290),
                                          child: GridView.builder(
                                            // padding: const EdgeInsets.only(
                                            //     top: 10.18),
                                            itemCount: _lightList.length,

                                            physics:
                                                const ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            // scrollDirection:
                                            //     Axis.vertical,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing:
                                                  getWidth(width, 12),
                                              mainAxisSpacing:
                                                  getHeight(height, 30),
                                              childAspectRatio:
                                                  width / (height / 3.2),
                                            ),

                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              print(
                                                  "List RoomId Main1    ${_lightList[index].roomID}");
                                              print(
                                                  "List Main Main1      $RoomID");
                                              if (_lightList[index].roomID ==
                                                  RoomID) {
                                                // print("List RoomId if"+_lightList[index].roomID);
                                                // print("List Main if"+RoomID);
                                                if (_lightList[index]
                                                        .getSelected() ==
                                                    true) {
                                                  return buildItem(
                                                      _lightList[index],
                                                      width,
                                                      height,
                                                      index);
                                                } else {
                                                  return const SizedBox
                                                      .shrink();
                                                }
                                              } else {
                                                // print("List RoomId else"+_lightList[index].roomID);
                                                // print("List Main else"+RoomID);
                                                return const SizedBox.shrink();
                                              }
                                            },
                                          ))
                                      : Container(),
                                  Positioned(
                                    top: fanVerticalPosition,
                                    //       left: getX(width, 95.99 - 32.54),
                                    left: getX(width, 31.63 - 32.54),
                                    child: SizedBox(
                                      width: getWidth(width, width),
                                      height: getHeight(height, height),
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 300,
                                                childAspectRatio: 3 / 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 20),
                                        itemCount: _fanList.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (_fanList[index].getSelected() ==
                                              true) {
                                            return Visibility(
                                                visible:
                                                    RoomID == _fanList[i].roomID
                                                        ? true
                                                        : false,
                                                child: InkWell(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                      InkWell(
                                                        onLongPress: () {
                                                          Vibration.vibrate(
                                                              duration: 100);
                                                          //sendCommandCMIDFAN(_fanList[i]);

                                                          sendCommandCMID(
                                                              LightItem.name(0),
                                                              _fanList[i],
                                                              true,
                                                              SceneItem.name(
                                                                  ""),
                                                              false,
                                                              false,
                                                              false,
                                                              false,
                                                              false,
                                                              false,
                                                              false);
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              children: [
                                                                Image.asset(
                                                                    _fanList[i]
                                                                        .getImage(),
                                                                    height: getHeight(
                                                                        height,
                                                                        kRemotButtonHeight),
                                                                    width: getWidth(
                                                                        width,
                                                                        kRemotButtonWidth),
                                                                    fit: BoxFit
                                                                        .fill),
                                                                Positioned(
                                                                  top: getY(
                                                                      height,
                                                                      2),
                                                                  child:
                                                                      SizedBox(
                                                                    width: getWidth(
                                                                        width,
                                                                        kRemotButtonWidth),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          width: getWidth(
                                                                              width,
                                                                              kRemotButtonWidth / 2),
                                                                          child:
                                                                              TextField(
                                                                            cursorColor:
                                                                                dialogTitleColor,
                                                                            focusNode:
                                                                                fan1FocusNode,
                                                                            autofocus:
                                                                                true,
                                                                            controller:
                                                                                fan1Controller,
                                                                            enabled:
                                                                                fan1Editable,
                                                                            onSubmitted:
                                                                                (text) {
                                                                              setState(() {
                                                                                fan1Editable = false;
                                                                              });

                                                                              if (text.isNotEmpty && text != "FAN 1") {
                                                                                setState(() {
                                                                                  fan1Controller.text = text.toUpperCase();
                                                                                  fan1Renamed = true;
                                                                                });
                                                                              }
                                                                            },
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              border: InputBorder.none,
                                                                              isDense: true,
                                                                              contentPadding: EdgeInsets.zero,
                                                                            ),
                                                                            style: TextStyle(
                                                                                height: cursorHeight,
                                                                                decoration: TextDecoration.none,
                                                                                color: textColor,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: "Inter",
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: getAdaptiveTextSize(context, homePageButtonTextSize)),
                                                                            inputFormatters: [
                                                                              LengthLimitingTextInputFormatter(textFieldMaxLength),
                                                                            ],
                                                                            textAlign: fan1Renamed
                                                                                ? TextAlign.right
                                                                                : TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        if (fan1Renamed &&
                                                                            fan1Controller.text !=
                                                                                "FAN 1")
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: getY(height, 1.5)),
                                                                            width:
                                                                                getWidth(width, kRemotButtonWidth / 2),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.topCenter,
                                                                              child: Text(
                                                                                "FAN 1",
                                                                                style: TextStyle(decoration: TextDecoration.none, color: highLightColor, fontWeight: FontWeight.bold, fontFamily: "Inter", fontStyle: FontStyle.normal, fontSize: getAdaptiveTextSize(context, homePageButtonTextSize)),
                                                                              ),
                                                                            ),
                                                                          )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: getY(
                                                                      height,
                                                                      19),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color:
                                                                          homePageDividerColor,
                                                                    ),
                                                                    width: getWidth(
                                                                        width,
                                                                        fanContainerWidth),
                                                                    height: getHeight(
                                                                        height,
                                                                        fanContainerHeight),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                  ),
                                                                ),
                                                                Positioned.fill(
                                                                    left: getX(
                                                                        width,
                                                                        5),
                                                                    right: getX(
                                                                        width,
                                                                        5),
                                                                    top: getY(
                                                                        height,
                                                                        10),
                                                                    child: RotatedBox(
                                                                        quarterTurns: -1,
                                                                        child: ListWheelScrollView.useDelegate(
                                                                          physics:
                                                                              const FixedExtentScrollPhysics(),
                                                                          offAxisFraction:
                                                                              fanOffFraction,
                                                                          magnification:
                                                                              2.0,
                                                                          onSelectedItemChanged:
                                                                              (x) {
                                                                            setState(() {
                                                                              _fanList[i].selectedIndex = x;
                                                                            });

                                                                            sendCommandCMID(
                                                                                LightItem.name(0),
                                                                                _fanList[i],
                                                                                false,
                                                                                SceneItem.name(""),
                                                                                false,
                                                                                false,
                                                                                false,
                                                                                false,
                                                                                false,
                                                                                false,
                                                                                true);
                                                                            //sendCommandCMIDFAN(_fanList[i]);
                                                                          },
                                                                          controller:
                                                                              FixedExtentScrollController(initialItem: selected1),
                                                                          itemExtent: getWidth(
                                                                              width,
                                                                              itemWidth1),
                                                                          childDelegate:
                                                                              ListWheelChildLoopingListDelegate(
                                                                            children: List.generate(
                                                                                itemCount,
                                                                                (x) => RotatedBox(
                                                                                    quarterTurns: 1,
                                                                                    child: AnimatedContainer(
                                                                                        decoration: const BoxDecoration(),
                                                                                        duration: const Duration(milliseconds: 400),
                                                                                        width: x == selected1 ? getWidth(width, fanButtonSelectedWidth) : getWidth(width, fanButtonUnSelectedWidth),
                                                                                        height: x == selected1 ? getHeight(height, fanButtonSelectedHeight) : getHeight(height, fanButtonUnSelectedHeight),
                                                                                        alignment: Alignment.center,
                                                                                        child: Text(
                                                                                          (x + 1).toString(),
                                                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: x == selected1 ? getAdaptiveTextSize(context, fanButtonSelectedTextSize) : getAdaptiveTextSize(context, fanButtonUnSelectedTextSize)),
                                                                                        )))),
                                                                          ),
                                                                        ))),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ])));
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        },
                                        // controller: controller,
                                      ),
                                    ),
                                  )
                                  // Positioned(
                                  //   // top: getY(height, 490.20) +
                                  //   //     getNextFenControlPosition(
                                  //   //         lightList.length, 53.64, 35),
                                  //   top: fanVerticalPosition +
                                  //       getHeight(height, 20),
                                  //   left: getX(width, 217.33 - 38.54),
                                  //   child: Stack(
                                  //       alignment: Alignment.topCenter,
                                  //       children: [
                                  //         Image.asset(
                                  //             'assets/images/fan_off.png',
                                  //             height: getHeight(height, 53.64),
                                  //             width: getWidth(width, 167.49),
                                  //             fit: BoxFit.fill),
                                  //         Positioned.fill(
                                  //             left: getX(width, 5),
                                  //             right: getX(width, 5),
                                  //             child: RotatedBox(
                                  //                 quarterTurns: -1,
                                  //                 child: ListWheelScrollView(
                                  //                   magnification: 2.0,
                                  //                   onSelectedItemChanged: (x) {
                                  //                     setState(() {
                                  //                       selected = x;
                                  //                     });
                                  //                   },
                                  //                   controller:
                                  //                       _scrollController,
                                  //                   itemExtent: getWidth(
                                  //                       width, itemWidth),
                                  //                   children: List.generate(
                                  //                       itemCount,
                                  //                       (x) => RotatedBox(
                                  //                           quarterTurns: 1,
                                  //                           child: Container(
                                  //                             margin: EdgeInsets.only(
                                  //                                 top: getHeight(
                                  //                                     height,
                                  //                                     5),
                                  //                                 bottom:
                                  //                                     getHeight(
                                  //                                         height,
                                  //                                         5)),
                                  //                             child:
                                  //                                 AnimatedContainer(
                                  //                                     decoration: x == selected
                                  //                                         ? const BoxDecoration(
                                  //                                             image: DecorationImage(
                                  //                                                 image: AssetImage(
                                  //                                                     'assets/images/fanbackground.png'),
                                  //                                                 fit: BoxFit
                                  //                                                     .cover,
                                  //                                                 scale:
                                  //                                                     1))
                                  //                                         : const BoxDecoration(),
                                  //                                     duration: const Duration(
                                  //                                         milliseconds:
                                  //                                             400),
                                  //                                     width: x == selected
                                  //                                         ? getWidth(
                                  //                                             width,
                                  //                                             60)
                                  //                                         : getWidth(
                                  //                                             width,
                                  //                                             50),
                                  //                                     height: x ==
                                  //                                             selected
                                  //                                         ? getHeight(
                                  //                                             height,
                                  //                                             60)
                                  //                                         : getHeight(
                                  //                                             height,
                                  //                                             50),
                                  //                                     alignment:
                                  //                                         Alignment.center,
                                  //
                                  //                                     //color: Colors.white,
                                  //                                     // decoration: BoxDecoration(
                                  //                                     //     color: x == selected ? Colors.red : Colors.grey,
                                  //                                     //     ),
                                  //                                     child: Text(
                                  //                                       (x + 1)
                                  //                                           .toString(),
                                  //                                       style: TextStyle(
                                  //                                           color: Colors
                                  //                                               .white,
                                  //                                           fontSize: x == selected
                                  //                                               ? getAdaptiveTextSize(context, 18)
                                  //                                               : getAdaptiveTextSize(context, 12)),
                                  //                                     )),
                                  //                           ))),
                                  //                 ))),
                                  //       ]),
                                  // ),
                                ],
                              )),
                        ])
                  ],
                )),
      ),
    );
  }

  void renameDialog(BuildContext context, double height, double width,
      Alignment alignment, String title, Function renameCallback) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Align(
            alignment: alignment,
            child: Container(
              width: getWidth(width, renameDialogWidth),
              height: getHeight(height, renameDialogHeight),
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(14.86390495300293)),
                border: Border.all(
                    color: homePageDividerColor, width: 1.0617074966430664),
                image: const DecorationImage(
                    image: AssetImage(alertDialogBg), fit: BoxFit.fill),
              ),
//color: Colors.white,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                        fontStyle: FontStyle.normal,
                        fontSize: getAdaptiveTextSize(context, 12.0)),
                  ),
                  DialogCenterButton("RENAME", optionsButtonWidth,
                      optionsButtonHeight, optionsButtonTextSize, (selected) {
                    Navigator.pop(context);
                    renameCallback();
                  }),
                ],
              ),
            ),
          );
        }).then((value) {
      renameDialogOpened = false;
    });
  }

  void renameDragDialog(
      BuildContext context,
      double height,
      double width,
      Alignment alignment,
      String title,
      Function renameCallback,
      Function dragCallback) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Align(
            alignment: alignment,
            child: Container(
              width: getWidth(width, renameDialogWidth),
              height: getHeight(height, renameDialogHeight + 15),
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(14.86390495300293)),
                border: Border.all(
                    color: homePageDividerColor, width: 1.0617074966430664),
                image: const DecorationImage(
                    image: AssetImage(alertDialogBg), fit: BoxFit.fill),
              ),
//color: Colors.white,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                        fontStyle: FontStyle.normal,
                        fontSize: getAdaptiveTextSize(context, 12.0)),
                  ),
                  DialogCenterButton("RENAME", optionsButtonWidth,
                      optionsButtonHeight, optionsButtonTextSize, (selected) {
                    Navigator.pop(context);
                    renameCallback();
                  }),
                  DialogCenterButton("DRAG", optionsButtonWidth,
                      optionsButtonHeight, optionsButtonTextSize, (selected) {
                    Navigator.pop(context);
                    dragCallback();
                  }),
                ],
              ),
            ),
          );
        }).then((value) {
      renameDialogOpened = false;
    });
  }

  void disableTextFields() {
    setState(() {
      for (var getScene in HomePageScenesListState.sceneList) {
        getScene.isEditable = false;
      }

      for (var getSwitch in lightList) {
        getSwitch.setEditable(false);
      }

      fan1Editable = false;
      fan2Editable = false;

      for (var getRoom in HomePageRoomsListState.roomList) {
        getRoom.isEditable = false;
      }

      myRemoteEditable = false;
      homeEditable = false;
      tvEditable = false;
      acEditable = false;
      stbEditable = false;
    });
  }
}

class Item extends StatelessWidget {
  final String itemName;
  final bool selectedItem;
  final VoidCallback navigationHandler;

  const Item(this.itemName, this.selectedItem, this.navigationHandler,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      width: 10,
      child: TextButton(
        onPressed: navigationHandler,
        child: Text(
          itemName,
          style: selectedItem
              ? Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 14,
                  )
              : Theme.of(context).textTheme.headline6?.copyWith(
                    color: const Color(0xff707070),
                    fontSize: 14,
                  ),
        ),
      ),
    );
  }
}

getadaptiveTextSize(BuildContext context, dynamic value) {
  // 720 is medium screen height
  return (value / 720) * MediaQuery.of(context).size.height;
}

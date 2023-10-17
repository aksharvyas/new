import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kremot/global/storage.dart';
import 'package:kremot/models/app_model.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/res/AppContextExtension.dart';
import 'package:kremot/res/AppDimensions.dart';
import 'package:kremot/utils/Constants.dart';
import 'package:kremot/view/ForgotPasswordPage.dart';
import 'package:kremot/view/HomePage.dart';
import 'package:kremot/view/LoginPage.dart';
import 'package:kremot/view/PairingPage.dart';
import 'package:kremot/view/PrivacyPolicy.dart';
import 'package:kremot/view/RegistrationPage.dart';
import 'package:kremot/view/VerifyOtpPage.dart';
import 'package:kremot/view/widgets/widget.dart';

import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: ChangeNotifierProvider<AppModel>(
          create: (_) => AppModel(),
          child: Builder(builder: (context) {
            return MaterialApp(debugShowCheckedModeBanner: false,
              title: 'KRemot',
              theme: ThemeData(
                primarySwatch: context.resources.color.colorPrimary,
              ),
              home: const SplashScreen(),
            );
          })),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();



    startTimer();

    print("TOLOCAL Time"+  setDateTimeLocal(
        "2023-01-12 06:54:33.000","HH:MM dd MMMM, yyyy"));
    //startTimer();
  }

  startTimer() async {
    Timer(const Duration(milliseconds: 500), gotoNextPage);
  }

  String setDateTimeLocal(String toUtc,String formate1) {

    DateTime dateTime1 = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2023-01-12 06:54:33.000",true).toLocal();

    return DateFormat("HH:mm dd MMMM, yyyy").format(dateTime1);


  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print("WIDTH: " + width.toString());
    print("HEIGHT: " + height.toString());
    return Scaffold(
        backgroundColor: context.resources.color.colorBlack,
        body: Center(
          child: BlinkWidget(
            children: <Widget>[
              Center(
                child: Container(
                    height: getHeight(height, kRemotButtonHeight),
                    width: getWidth(width, kRemotButtonWidth),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        scale: 2.5,
                        image: AssetImage(kRemotUnSelectedImage),
                      ),
                    ),
                    child: Center(
                    //   child: Text(context.resources.strings.appTitle,
                    //       style: TextStyle(
                    //           color: textColor,
                    //           fontWeight: FontWeight.w400,
                    //           fontFamily: "Inter",
                    //           fontStyle: FontStyle.normal,
                    //           fontSize: 25.0),
                    //       textAlign: TextAlign.center),
                     )
                ),
              ),
              Center(
                child: Container(
                  height: getHeight(height, kRemotButtonHeight),
                  width: getWidth(width, kRemotButtonWidth),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      scale: 2.5,
                      image: AssetImage(kRemotSelectedImage),
                    ),
                  ),
                  child: Center(
                      //   child: Text(context.resources.strings.appTitle,
                      //       style: TextStyle(
                      //           color: textColor,
                      //           fontWeight: FontWeight.w400,
                      //           fontFamily: "Inter",
                      //           fontStyle: FontStyle.normal,
                      //           fontSize: 25.0),
                      //       textAlign: TextAlign.center),
                      // )
                      ),
                ),
              ),
            ],
          ),
        ));
  }
  late final NordicNrfMesh nordicNrfMesh = NordicNrfMesh();
  void gotoNextPage() async {
    // ignore: use_build_context_synchronously
    var isFirstTime = await LocalStorageService.getToken();
    if (isFirstTime != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(nordicNrfMesh)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );

    // String? token = await LocalStorageService.getInstance()!.getString(LocalStorageService.PREF_TOKEN);
    // if(token != null){
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) =>  const HomePage()),
    //   );
    // } else{
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) =>  const LoginPage()),
    //   );
    // }
  }
}

class BlinkWidget extends StatefulWidget {
  final List<Widget>? children;
  final int interval;

  const BlinkWidget({super.key, @required this.children, this.interval = 500});

  @override
  State<BlinkWidget> createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<BlinkWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  int _currentWidget = 0;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: widget.interval), vsync: this);

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (++_currentWidget == widget.children!.length) {
            _currentWidget = 0;
          }
        });

        _controller!.forward(from: 0.0);
      }
    });

    _controller!.forward();
  }

  @override
  dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.children![_currentWidget],
    );
  }
}

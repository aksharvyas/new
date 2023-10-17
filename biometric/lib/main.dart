import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final LocalAuthentication auth;
  bool supportState = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((value) {
      setState(() {
        supportState = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !supportState
          ? Center(
              child: Text("Biometric is not support in this Device"),
            )
          : Center(
              child: ElevatedButton(
                  child: Text("Authenticate"),
                  onPressed: () {
                    getAvailableBiometric();
                  }),
            ),
    );
  }

  Future<void> getAvailableBiometric() async {
    List<BiometricType> availableBiometric =
        await auth.getAvailableBiometrics();
    print("available biometric  ${availableBiometric}");
    try {

      bool authenticated = await auth.authenticate(

        localizedReason: "Biometric by biometric app",

        stickyAuth: true,
        // options: AuthenticationOptions(
        // options: AuthenticationOptions(
        //   biometricOnly: true,
        //   stickyAuth: true,
        // ),
        // androidAuthStrings: AndroidAuthMessages(
        //     goToSettingsButton: '',
        //     biometricHint: 'Verify biometric',
        //     biometricSuccess: 'success',
        //     signInTitle: 'Biometric authenticate required!',
        //     cancelButton: 'Cancel')
        // authMessages: [
        //   AndroidAuthMessages(
        //       goToSettingsButton: '',
        //       biometricHint: 'Verify biometric',
        //
        //
        //
        //
        //
        //       biometricSuccess: 'success',
        //       signInTitle: 'Biometric authenticate required!',
        //       cancelButton: 'Cancel')
        // ]
      );
      print("authenticate" + authenticated.toString());
    } on Exception catch (e) {
      print("ex" + e.toString());
    }
  }
}

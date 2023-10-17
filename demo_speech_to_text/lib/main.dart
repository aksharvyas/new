import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to Text Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpeechToTextPage(),
    );
  }
}

class SpeechToTextPage extends StatefulWidget {
  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the microphone button and start speaking';

  @override
  void initState() {
    super.initState();
    _speech=stt.SpeechToText();


  }

  void _listen() async {

    //  bool hasPermission = await _getMicrophonePermission();
    //  print("permiss"+hasPermission.toString());
    //  if (!hasPermission) {
    // print("permission"+hasPermission.toString()+" permission is not graned");
    //  }

    if (!_isListening) {
      setState(() {
        _isListening = true;
      });
      bool available = await _speech.initialize( onStatus: (status) {
        print("status"+status.toString());
      }, onError: (errorNotification) {
        print("errorNotification"+errorNotification.errorMsg);
      }, );
      print("available"+available.toString());
      if(available){
        await _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );}
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }

  // Future<bool> _getMicrophonePermission() async {
  //   var status = await Permission.microphone.request();
  //   print("status"+status.isGranted.toString());
  //   return  true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text),
            SizedBox(height: 20),
            FloatingActionButton(
              onPressed: (){
                _listen();
              },
              child: Icon(_isListening ? Icons.stop : Icons.mic),
            ),
          ],
        ),
      ),
    );
  }
}
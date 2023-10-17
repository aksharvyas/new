import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  bool isMicOn=false;
  RxString _lastWords = ''.obs;

  @override
  void initState() {
    super.initState();

     _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(finalTimeout: Duration(hours: 1),);
  _startListening();
    // setState(() {});
    // _startListening();
    // setState(() {});
  }

  void _startListening() async {


    await _speechToText.listen(onResult: _onSpeechResult,listenFor: Duration(hours: 1));
    setState(() {});
         _speechToText.isNotListening ? _startListening() : _startListening();
    }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    bool okremote =false;
    if(!okremote){
      setState(() {
        _lastWords.value="";
      });
     }
      if(result.recognizedWords=="ok kremot" || result.recognizedWords=="okay kremote" || result.recognizedWords=="ok kremote"){
        setState(() {
          _lastWords.value=result.recognizedWords;
        });

        okremote=true;
      }
      if(okremote){
        setState(() {
          _lastWords.value ="${_lastWords.value} ${result.recognizedWords}";
        });
      }
    print("speech recognition"+result.recognizedWords.toString());
    print("last words   ${_lastWords.value}");
    print("confidence"+result.confidence.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Speech Demo'),
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ],
        ),
      ),
      body:

         SizedBox(width: double.infinity,

           child: Column(
mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Recognized words:',
                  style: TextStyle(fontSize: 20.0),
                ),
               SizedBox(
                 height: 20,
               ),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 25),
                 child: Container(
               decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                 border: Border.all(color: Colors.blue,width: 2.5)
               ),
                       width: double.infinity,
                       height: 400,
                     child: Padding(
                       padding: EdgeInsets.all(12.0),
                       child: SingleChildScrollView(
                         reverse: true,
                           physics: BouncingScrollPhysics(),
                           child: Obx(() => SelectableText(_lastWords.value,style: TextStyle(fontSize: 35),
                           ))),
                     )),
               ),

                // Add more content here if needed to make the column taller
                // This extra content will enable scrolling when it exceeds the available height.
              ],
            ),
         ),




      // floatingActionButton: AvatarGlow(
      //   endRadius: 50,
      //   glowColor: Colors.blue,
      //   showTwoGlows: true,
      //   repeat: true,
      //   curve: decelerateEasing,
      //   duration: Duration(milliseconds: 600),
      //   animate: _speechToText.isListening?true:false,
      //   child: FloatingActionButton(
      //     onPressed:() {
      //       isMicOn=!isMicOn;
      //       isMicOn ? _stopListening : _startListening();
      //     },
      //
      //
      //
      //     // If not yet listening for speech start, otherwise stop
      //
      //     tooltip: 'Listen',
      //     child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

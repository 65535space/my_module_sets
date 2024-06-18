import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice Guidance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts = FlutterTts();
  bool isVoiceOn = false;
  late Map<String, String> selectedVoice;

  @override
  void initState() {
    super.initState();
    _setVoiceParameters();
  }

  Future _setVoiceParameters() async {
    // ピッチとスピードの設定
    await flutterTts.setPitch(1.0); // 0.5から2.0の範囲
    await flutterTts.setSpeechRate(0.5); // 0.0から1.0の範囲

    // 利用可能なボイスリストを取得
    List<dynamic> voices = await flutterTts.getVoices;
    if (voices.isNotEmpty) {
      setState(() {
        selectedVoice = Map<String, String>.from(voices[0]); // 最初のボイスを選択
      });
      await flutterTts.setVoice(selectedVoice);
    }
  }

  Future _speak(String text) async {
    if (isVoiceOn) {
      await flutterTts.setVoice(selectedVoice);
      await flutterTts.speak(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Voice Guidance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '音声案内のON/OFF',
              style: TextStyle(fontSize: 24),
            ),
            Switch(
              value: isVoiceOn,
              onChanged: (value) {
                setState(() {
                  isVoiceOn = value;
                });
                _speak('音声案内が${isVoiceOn ? 'オン' : 'オフ'}になりました');
              },
            ),
            ElevatedButton(
              onPressed: () {
                _speak('こんにちは、これは音声案内のデモです');
              },
              child: const Text('音声案内を実行'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widget/drawer_menu.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'dart:math';
import 'dart:async';

class PlayPage extends StatefulWidget {
  PlayPage({Key key, this.title, this.level}) : super(Key: key);

  final String title;
  final String level;

  @override
  State<StatefulWidget> createState() => _PlayPage();
}

const String basic = 'basic';
const String advanced = 'advanced';

const List<String> baseThemeList = [
  '生麦生米生卵',
  '隣の客はよく柿食う客だ',
  'バスガス爆発',
  '裏庭には二羽ニワトリがいる',
  '赤パジャマ黄パジャマ青パジャマ',
  '赤巻紙青巻紙黄巻紙',
  '老若男女',
  '旅客機の旅客'
];

const List<String> advancedThemeList = [
  'アンドロメダだぞ',
  '肩固かったから買った肩たたき機',
  '打者走者勝者走者一掃',
  '専売特許許可局',
  '新設診察室視察',
  '著作者手術中',
  '除雪車除雪作業中',
  '貨客船の旅客と旅客機の旅客',
  '骨粗鬆症訴訟勝訴'
];

const languages = const [
  const Language('Japanese', 'ja_JA'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class _PlayPage extends State<PlayPage> with SingleTickerProviderStateMixin {
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  int _hp = 5;
  String _image = '';
  Language selectedLang = languages.first;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activateSpeechRecognizer();
    setTongueTwister(widget.level);
    if (widget.level == basic) {
      _image = 'image/kaiju.png';
      _hp = 5;
    }
    if (widget.level == advanced) {
      _image = 'image/fantasy_mahojin_syoukan.png';
      _hp = 7;
    }
  }

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer...');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate('ja_JA').then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () => _themeText != '終了！！'
                    ? setTongueTwister(widget.level)
                    : null,
                child: Container(
                  child: _themeText != '終了！！' ? Icon(Icons.autorenew) : null,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    _themmwText,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'HP:',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                _hp.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Container(
            height: 280,
            child: Center(
              child: Image.asset(_image),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            width: 300,
            color: Colors.grey.shade200,
            child: Text(transcription),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton(
                onPressed: _speechRecognitionAvailable && !_isListening
                    ? () => start()
                    : null,
                label: _isListening ? 'Listening...' : '詠唱開始',
              ),
              _buildButton(
                onPressed: _isListening ? () => clear() : null,
                label: 'やり直し',
              ),
              _buildButton(
                onPressed: () {
                  attack();
                },
                label: '攻撃',
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/home");
        },
        child: Text('ホーム'),
      ),
    );
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => new Padding(
          padding: new EdgeInsets.all(12.0),
          child: new ElevatedButton(
            onPressed: onPressed,
            child: new Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );

  void start()

}

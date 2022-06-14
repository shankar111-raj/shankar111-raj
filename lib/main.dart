import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:languageproject/l10n/l10n.dart';
import 'package:languageproject/newPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale language = Locale('en');
  changeLanguage(Locale newLocale) async {
    setState(() {
      language = newLocale;
    });
  }

  @override
  void initState() {
    super.initState();
    getLanguage();
  }

  getLanguage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String languageName = _pref.getString("language") ?? "";
    if (languageName == "english") {
      setState(() {
        language = Locale('en');
      });
    }else if(languageName == "nepali"){
      setState(() {
        language = Locale('ne');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: language,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text("hello"),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  MyApp.of(context)!.changeLanguage(Locale('ne'));
                  SharedPreferences _pref =
                      await SharedPreferences.getInstance();
                  _pref.setString("language", "nepali");
                },
                child: Text("nepali")),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                 showCallkitIncoming("458495849");
                },
                child: Text("english"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NewScreen()));
        },
        child: Icon(Icons.golf_course),
      ),
    );
  }
}


Future<void> showCallkitIncoming(String uuid) async {
  var params = <String, dynamic>{
    'id': uuid,
    'nameCaller': 'gfdsgsdfg',
    'appName': 'Callkit',
    'avatar': 'https://i.pravatar.cc/100',
    'handle': 'sfdgsdfgsd',
    'type': 0,
    'duration': 30000,
    'textAccept': 'Accept',
    'textDecline': 'Decline',
    'textMissedCall': 'Missed call',
    'textCallback': 'Call back',
    'extra': <String, dynamic>{'userId': '1a2b3c4d'},
    'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
    'android': <String, dynamic>{
      'isCustomNotification': true,
      'isShowLogo': false,
      'isShowCallback': false,
      'ringtonePath': 'system_ringtone_default',
      'backgroundColor': '#0955fa',
      'background': 'https://i.pravatar.cc/500',
      'actionColor': '#4CAF50'
    },
    'ios': <String, dynamic>{
      'iconName': 'CallKitLogo',
      'handleType': '',
      'supportsVideo': true,
      'maximumCallGroups': 2,
      'maximumCallsPerCallGroup': 1,
      'audioSessionMode': 'default',
      'audioSessionActive': true,
      'audioSessionPreferredSampleRate': 44100.0,
      'audioSessionPreferredIOBufferDuration': 0.005,
      'supportsDTMF': true,
      'supportsHolding': true,
      'supportsGrouping': false,
      'supportsUngrouping': false,
      'ringtonePath': 'system_ringtone_default'
    }
  };
  await FlutterCallkitIncoming.showCallkitIncoming(params);
}
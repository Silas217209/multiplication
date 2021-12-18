import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:multiplication/screens/auswertung.dart';
import 'package:multiplication/screens/math_test.dart';
import 'package:multiplication/screens/testen.dart';
import 'package:multiplication/screens/einstellungen/einstellunen.dart';
import 'package:multiplication/utils/variablen.dart';
import 'package:multiplication/screens/privacy_policy.dart';
import 'package:multiplication/screens/statistiken/errors.dart';
import 'package:multiplication/screens/statistiken/time.dart';

List titles = [
  translation.home,
  translation.zeit,
  translation.statistikenlabel
];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox("wert");
  await Hive.openBox("time");
  await Hive.openBox("settings");

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
    .then((_){
      runApp(MyApp());
    }
  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiplication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        '/home': (context) => MyHomePage(),
        '/test': (context) => Tests(),
        '/math_test': (context) => MathTest(),
        '/auswertung': (context) => Auswertung(),
        '/einstellungen': (context) => Einstellungen(),
        '/privacy': (context) => PrivacyPolicy()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top]);
    var appBar = AppBar(
      leading: null,
      title: Center(
        child: AnimatedSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(
              opacity: animation,
              child: child,
          ),
          duration: Duration(milliseconds: 300),
          child: Text(
            titles[currentIndex],
            key: ValueKey<String>(titles[currentIndex]),
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, '/einstellungen'),
            icon: Icon(Icons.settings)
        )
      ],
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: appBar,
        body: PageView(
          children: [
            Tests(),
            Time(),
            Statistiken()
          ],
          onPageChanged: (page) {
            setState(() {
              countdown = '';
              currentIndex = page;
            });
          },
          controller: _pageController,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabTapped,
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: translation.home
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: translation.zeit
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: translation.statistikenlabel
            ),
          ],
        ),
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }
}
import 'package:flutter/material.dart';
import 'package:multiplication/utils/variablen.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class MathTest extends StatefulWidget {
  @override
  _MathTestState createState() => _MathTestState();
}

int anzahl = 10;
var ergebnis = '';
List ergebnisliste = [];
late bool right;
late bool isempty;


class _MathTestState extends State<MathTest> {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      leading: Container(),
      title: Text(translation.statistikenlabel),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: appBar,
          body: Align(
              alignment: Alignment(0.0, 1.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$anzahl',
                              style: TextStyle(fontSize: height / 40)),
                          Text(translation.falsch(falsch.toString()),
                              style: TextStyle(fontSize: height / 40)),
                        ],
                      ),
                    ),
                    Container(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              translation.aufgabe(
                                  testfirst.toString(),
                                  testsecond.toString(), ergebnis.toString()),
                              style: TextStyle(
                                fontSize: 40.0,
                                color: textcolor,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.9, 0.0),
                            child: Icon(checkicon, color: iconcolor, size: 50),
                          ),
                        ],
                      ),
                    ),
                    Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          counterButton(7),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005),
                          counterButton(8),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005),
                          counterButton(9),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.005),
                      Row(
                        children: <Widget>[
                          counterButton(4),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005),
                          counterButton(5),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005),
                          counterButton(6),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.005),
                      Row(
                        children: <Widget>[
                          counterButton(1),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005),
                          counterButton(2),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005),
                          counterButton(3),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.005),
                      Row(
                        children: <Widget>[
                          counterButton(0),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005),
                          Expanded(
                            child: Hero(
                              tag: "losgehts",
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *.09,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (ergebnisliste.isNotEmpty) {
                                          ergebnisliste.removeLast();
                                        }
                                        ergebnis = ergebnisliste.join();
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                                    ),
                                    child: Icon(
                                      Icons.backspace_rounded,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *.09,
                              child: TextButton(
                                onPressed: () => onok(),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                                ),
                                child: Text('OK',
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: MediaQuery.of(context).size.width / 15
                                  )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ]
                )
              )
            ),
    );
  }

  Widget counterButton(buttonText) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height *.09,
        child: TextButton(
          onPressed: () {
            if (ergebnisliste.length <= 5) {
              setState(() {
                ergebnisliste.add(buttonText);
                ergebnis = ergebnisliste.join();
              });
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
          ),
          child: Text(
            buttonText.toString(),
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: MediaQuery.of(context).size.width / 15,
            ),
          ),
        ),
      ),
    );
  }

  onok() async {
    right = ergebnis == '' ? false : testfirst * testsecond == int.parse(ergebnis);
    isempty = ergebnis == '' ? true : false;
    wertbox = Hive.box("wert");
    if(right && anzahl != 1) {
      setState(() {
        anzahl--;
        iconcolor = Colors.lightGreen[700];
        checkicon = Icons.check_circle;
        testaufgabenliste.add(testfirst);
        ergebnisliste.clear();
        textcolor = Colors.grey;
        ergebnis = '';
        testfirst = random.nextInt(10) + 1;
        testsecond = testliste[random.nextInt(testliste.length)];
        while (testaufgabenliste.contains(testfirst)) {
          testfirst = random.nextInt(10) + 1;
          testsecond = testliste[random.nextInt(testliste.length)];
        }
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        String keyr = '$testfirst x $testsecond r';
        if (wertbox.containsKey(keyr)) {
          int? value = wertbox.get(keyr) + 1;
          wertbox.put(keyr, value);
        } else {
          int value = 1;
          wertbox.put(keyr, value);
        }
        setState(() {
          textcolor = Colors.black;
          iconcolor = null;
          checkicon = null;
          textcolor = Colors.black;
        });
      });
    } else if(right) {
      setState(() {
        testaufgabenliste.clear();
        s.stop();
      });
      var stars = ((10 - falsch) / 2) < 0 ? 0 : ((10 - falsch) / 2);
      var time = (s.elapsedMilliseconds / 1000);
      List values = [stars, time, '${DateFormat('d.MM H:m').format(DateTime.now())}'];
      setState(() {
        current_time = '${time.toStringAsFixed(1)}';
        s.reset();
      });
      timebox.put((time * 1000000).round(), values);
      Navigator.pushNamed(context, '/auswertung');
    } else if (!right && !isempty) {
      setState(() {
        ergebnis = '';
        ergebnisliste.clear();
        iconcolor = Colors.red[900];
        checkicon = Icons.cancel;
        textcolor = Colors.red[900];
        falsch++;
      });
      String keyf = '$testfirst x $testsecond f';
      if (wertbox.containsKey(keyf)) {
        int? value = wertbox.get(keyf) + 1;
        wertbox.put(keyf, value);
      } else {
        int value = 1;
        wertbox.put(keyf, value);
      }
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:multiplication/utils/variablen.dart';

class CustomTextButton extends StatelessWidget {
  final text;
  final onPressed;
  final width;

  const CustomTextButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height / 100,
        ),
        SizedBox(
          height: height / 15,
          width: width,
          child: TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(180),
                ))),
            child: Text(text,
                style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: MediaQuery.of(context).size.width / 25)),
          ),
        ),
        SizedBox(
          height: height / 300,
        ),
      ],
    );
  }
}

class ChooseTest extends StatefulWidget {
  final int reihe;

  ChooseTest({Key? key, required this.reihe}) : super(key: key);

  @override
  _ChooseTestState createState() => _ChooseTestState(reihe);
}

class _ChooseTestState extends State<ChooseTest> {
  final int reihe;
  late bool checkboxvalue = testliste.contains(reihe) ? true : false;

  _ChooseTestState(this.reihe);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onoperationpressed(),
          child: Container(
            height: height / 15,
            child: SizedBox(
              height: height / 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    value: checkboxvalue,
                    onChanged: (value) => onoperationpressed(),
                  ),
                  Text(translation.einmaleinsmit(reihe.toString()),
                      style: TextStyle(fontSize: height / 35)),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: height / 200,
        )
      ],
    );
  }

  onoperationpressed() {
    setState(() {
      if (testliste.contains(reihe)) {
        testliste.remove(reihe);
        checkboxvalue = false;
      } else {
        testliste.add(reihe);
        checkboxvalue = true;
      }
    });
  }
}

class StatistikElement extends StatefulWidget {
  final int firstmultiplicator;
  final int secondmultiplicator;
  final String result;

  const StatistikElement(
      {Key? key,
      required this.result,
      required this.firstmultiplicator,
      required this.secondmultiplicator})
      : super(key: key);

  @override
  _StatistikElementState createState() => _StatistikElementState();
}

class _StatistikElementState extends State<StatistikElement> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMyDialog(
          widget.firstmultiplicator,
          widget.secondmultiplicator,
          getcolor(widget.firstmultiplicator, widget.secondmultiplicator)),
      child: Container(
        child: Center(child: Text(widget.result)),
        decoration: BoxDecoration(
          color:
              getcolor(widget.firstmultiplicator, widget.secondmultiplicator),
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

  Color? getcolor(int firstmultiplicator, int secondmultiplicator) {
    double value;
    wertbox = Hive.box("wert");
    var keyf = '$firstmultiplicator x $secondmultiplicator f';
    var keyr = '$firstmultiplicator x $secondmultiplicator r';
    if (wertbox.containsKey(keyf) && wertbox.containsKey(keyr)) {
      int right = wertbox.get(keyr);
      int notright = wertbox.get(keyf);
      value = 100 / (right + notright) * right;
      if (value < 50) {
        return Colors.deepOrange[700];
      } else if (value >= 80) {
        return Colors.lightGreenAccent[700];
      } else if (value >= 50) {
        return Colors.yellowAccent;
      }
    } else if (wertbox.containsKey(keyr)) {
      return Colors.lightGreenAccent[700];
    } else if (wertbox.containsKey(keyf)) {
      return Colors.deepOrange[700];
    } else {
      return Colors.blue[50];
    }
  }

  Future<void> _showMyDialog(int first, int second, Color? color) async {
    if (color == Colors.blue[50]) {
      return null;
    } else {
      return showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    translation.dialogaufgabe(
                        widget.firstmultiplicator, widget.secondmultiplicator),
                    style: TextStyle(fontSize: 40)),
                SizedBox(
                  height: height / 4,
                  child: RatingBarIndicator(
                    rating: getpercentage(widget.firstmultiplicator,
                            widget.secondmultiplicator) *
                        5,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 45.0,
                    direction: Axis.horizontal,
                  ),
                ),
                Text(translation.anzahl_richtig_falsch(
                    getright(
                        widget.firstmultiplicator, widget.secondmultiplicator),
                    getwrong(widget.firstmultiplicator,
                        widget.secondmultiplicator))),
              ],
            ));
          });
    }
  }

  double getpercentage(int firstmultiplicator, int secondmultiplicator) {
    var keyf = '$firstmultiplicator x $secondmultiplicator f';
    var keyr = '$firstmultiplicator x $secondmultiplicator r';
    if (wertbox.containsKey(keyf) && wertbox.containsKey(keyr)) {
      int right = wertbox.get(keyr);
      int notright = wertbox.get(keyf);
      double value = 100 / (right + notright) * right;
      return value / 100;
    } else if (wertbox.containsKey(keyf)) {
      double value = 0.0;
      return value;
    } else {
      double value = 1.0;
      return value;
    }
  }

  getright(int firstmultiplicator, int secondmultiplicator) {
    var keyr = '$firstmultiplicator x $secondmultiplicator r';
    int? value = wertbox.get(keyr);
    if (wertbox.containsKey(keyr)) {
      if (value == 1) {
        return translation.getrightsingular(wertbox.get(keyr).toString());
      } else {
        return translation.getrightplural(wertbox.get(keyr).toString());
      }
    } else {
      return translation.ifzeroright;
    }
  }

  getwrong(int firstmultiplicator, int secondmultiplicator) {
    var keyf = '$firstmultiplicator x $secondmultiplicator f';
    var value = wertbox.get(keyf);
    if (wertbox.containsKey(keyf)) {
      if (value == 1) {
        return translation.getwrongsingular(wertbox.get(keyf).toString());
      } else {
        return translation.getwrongplural(wertbox.get(keyf).toString());
      }
    } else {
      return translation.ifzerowrong;
    }
  }
}

Widget staticbloc(String number) {
  return Container(
    child: Center(child: Text(number)),
    decoration: BoxDecoration(
      color: Colors.blue[200],
      borderRadius: BorderRadius.circular(50.0),
    ),
  );
}

Future<void> showMyDialog(
    BuildContext context, String title, String text, ifyes) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(translation.Nein),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(translation.Ja),
            onPressed: ifyes,
          ),
        ],
      );
    },
  );
}

dynamic resetstatistics(BuildContext context) {
  return showMyDialog(context, translation.Statistiken_loschen_title,
      translation.Statistiken_loschen_body, () {
    wertbox.clear();
    Navigator.pop(context);
  });
}

class MeanStar extends StatefulWidget {
  MeanStar({Key? key}) : super(key: key);

  @override
  _MeanStarState createState() => _MeanStarState();
}

class _MeanStarState extends State<MeanStar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: RatingBarIndicator(
        rating: getmean(wertbox),
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 50,
        direction: Axis.horizontal,
      ),
    );
  }

  double getmean(wertbox) {
    List<int> ten = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    List<double> data = [];
    Map values = wertbox.toMap();
    if (values.isNotEmpty) {
      for (int i in ten) {
        for (int j in ten) {
          var keyr = '$i x $j r';
          var keyf = '$i x $j f';
          if (values.containsKey(keyr) && values.containsKey(keyf)) {
            double value = 100 / (values[keyr] + values[keyf]) * values[keyr];
            setState(() {
              data.add(value);
            });
          } else if (wertbox.containsKey(keyr)) {
            double value = 100;
            setState(() {
              data.add(value);
            });
          } else if (wertbox.containsKey(keyf)) {
            double value = 0;
            setState(() {
              data.add(value);
            });
          }
        }
      }
      double sum = data.fold(0, (previous, current) => current + previous);
      return (sum / data.length) / 100 * 5;
    } else {
      return 0;
    }
  }
}

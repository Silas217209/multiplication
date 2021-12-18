import 'package:flutter/material.dart';
import 'package:multiplication/utils/variablen.dart';
import 'package:multiplication/utils/widgets.dart';
import 'package:multiplication/screens/math_test.dart';

class Tests extends StatefulWidget {
  Tests({Key? key}) : super(key: key);

  @override
  _TestsState createState() => _TestsState();
}


class _TestsState extends State<Tests> {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(translation.statistikenlabel),
      actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, '/einstellungen'),
            icon: Icon(Icons.settings)
        )
      ],
    );
    height = MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top:0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ChooseTest(reihe: 1,),
                  ChooseTest(reihe: 2,),
                  ChooseTest(reihe: 3,),
                  ChooseTest(reihe: 4,),
                  ChooseTest(reihe: 5,),
                  ChooseTest(reihe: 6,),
                  ChooseTest(reihe: 7,),
                  ChooseTest(reihe: 8,),
                  ChooseTest(reihe: 9,),
                  ChooseTest(reihe: 10,),
                ]
              ),
              Hero(
                tag: "losgehts",
                child: CustomTextButton(
                  width: MediaQuery.of(context).size.width * 0.7,
                  text: '${translation.Los_gehts} $countdown',
                  onPressed: () async{
                    if(countdown == '') {
                      if (testliste.isNotEmpty) {
                        setState(() {
                          countdown = 3;
                        });
                        await Future.delayed(
                            const Duration(seconds: 1), () async {
                          setState(() {
                            countdown = 2;
                          });
                          await Future.delayed(
                              const Duration(seconds: 1), () async {
                            setState(() {
                              countdown = 1;
                            });
                            await Future.delayed(
                                const Duration(seconds: 1), () {
                              setState(() {
                                countdown = '';
                              });
                              Navigator.pushNamed(context, '/math_test');
                              setState(() {
                                anzahl = 10;
                                falsch = 0;
                                textcolor = Colors.black;
                                ergebnisliste.clear();
                                ergebnis = '';
                                testfirst = random.nextInt(10) + 1;
                                testsecond = testliste[random.nextInt(testliste.length)];
                                s.start();
                              });
                            });
                          });
                        });
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: height / 90)
            ],
          ),
      ),
    );
  }
}
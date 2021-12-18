import 'package:flutter/material.dart';
import 'package:multiplication/utils/variablen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Time extends StatefulWidget {

  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
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
    List timeBox = timebox.keys.toList()..sort()..reversed;
    return Container(
      child: timeBox.isNotEmpty ? ListView.builder(
        itemCount: timeBox.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(
                height: height/80
              ),
              Container(
                width: MediaQuery.of(context).size.width *0.85,
                child:  Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '${timebox.get(timeBox[index])[2]}',
                    style: TextStyle(
                      fontSize: height / 48,
                      color: Colors.green,
                      fontWeight: FontWeight.w500
                    )
                  ),
                )
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.green[100],

                ),
                width: MediaQuery.of(context).size.width *0.95,
                height: height / 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text('${timebox.get(timeBox[index])[1].toStringAsFixed(1)} s')
                    ),

                    RatingBarIndicator(
                      rating: timebox.get(timeBox[index])[0],
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    )
                  ],
                )
              ),
            ],
          );
        },
      ) : Center(child: Text(translation.nichts)),
    );
  }
}
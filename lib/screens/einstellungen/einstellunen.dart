import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multiplication/utils/variablen.dart';
import 'package:multiplication/utils/widgets.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class Einstellungen extends StatefulWidget {

  @override
  _EinstellungenState createState() => _EinstellungenState();
}

class _EinstellungenState extends State<Einstellungen> {
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
    title: Text(translation.einstellungenlabel),
    );
    height = MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SettingsList(
        sections: [
          SettingsSection(
            title: translation.about,
            tiles: [
              SettingsTile(
                title: 'about',
                onPressed: (BuildContext context) {
                  showAboutDialog(
                    context: context,
                    applicationIcon: SizedBox(
                      height: height / 15,
                      width: height/ 15,
                      child: Image.asset('assets/images/multiplication_logo.png')
                    ),
                    applicationName: translation.appbar,
                    applicationVersion: '1.1.0',
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: translation.apptext,
                              style: TextStyle(color: Colors.black)
                            ),
                            TextSpan(
                              text: 'https://github.com/Silas217209/Multiplication.git',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = () async{
                                const url = 'https://github.com/Silas217209/Multiplication.git';
                                if(await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  print('cant open $url');
                                }
                              }
                            ),
                            TextSpan(
                              text: '\n \n ${translation.privacy}',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = () async{
                                Navigator.pushNamed(context, '/privacy');
                              }
                            ),
                          ]
                        )
                      )
                    ]
                  );
                }
              )
            ],
          ),
          SettingsSection(
            title: translation.statistikenlabel,
            tiles: [
              SettingsTile(
                title: translation.Statistiken_text_einstellungen,
                leading: Icon(Icons.bar_chart_rounded),
                onPressed: (BuildContext context) {
                  showMyDialog(
                    context,
                    translation.Statistiken_loschen_title,
                    translation.Statistiken_loschen_body,
                    () {
                      wertbox.clear();
                      Navigator.pop(context);
                    }
                  );
                }
              ),
              SettingsTile(
                title: translation.Statistiken_zeit_text_einstellungen,
                leading: Icon(Icons.timer),
                onPressed: (BuildContext context) {
                  showMyDialog(
                    context,
                    translation.Statistiken_zeit_loschen_title,
                    translation.Statistiken_zeit_loschen_body,
                    () {
                      timebox.clear();
                      Navigator.pop(context);
                    }
                  );
                }
              ),
            ],
          )
        ],
      ),
    );
  }
}
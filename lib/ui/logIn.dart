import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:walkability/util/components.dart';
import 'package:walkability/ui/mapScreen/map.dart';
import 'package:walkability/util/background.dart';
import 'package:walkability/ui/initialSettings/settingStart.dart';
import 'package:walkability/util/localization.dart';
import 'package:walkability/util/requests.dart';

class LogIn extends StatefulWidget {
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<ScaffoldState> logInKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  var _iconFeedback = List<Icon>.filled(2, null);
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _validation = '';

  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Background(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/walky.svg',
                          width: MediaQuery.of(context).size.width * 0.13,
                        ),
                      ),
                    ),
                    WalkForm(
                      controller: _username,
                      keyboardType: TextInputType.text,
                      text: WalkLocalizations.of(context)
                          .translate('LogInFORMMAIL'),
                      icon: _iconFeedback[0],
                    ),
                    WalkForm(
                      controller: _password,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      text: WalkLocalizations.of(context)
                          .translate('LogInFORMPASS'),
                      icon: _iconFeedback[1],
                    ),
                    WalkText(
                      text: _validation,
                      size: 12,
                      color: Color(0xFF8A12B1),
                    ),
                    GestureDetector(
                      child: Center(
                        child: WalkText(
                          text: WalkLocalizations.of(context)
                              .translate('LogInACT1'),
                          weight: FontWeight.w400,
                          size: 12,
                          color: Color(0xFF20CE88),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/recovery',
                          arguments: logInKey,
                        );
                      },
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: WalkButton(
                          text: WalkLocalizations.of(context)
                              .translate('LogInBUTTON'),
                          onPressed: () async {
                            showConnectivity(context);
                            var response = await authLog(_username, _password);
                            if (response != null) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      response ? MapScreen() : SettingStart(),
                                ),
                                (route) => false,
                              );
                            } else {
                              setState(() => _iconFeedback[0] = cross);
                              setState(() => _iconFeedback[1] = cross);
                              setState(() => _validation =
                                  WalkLocalizations.of(context)
                                      .translate('LogInVAL'));
                            }
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Center(
                          child: WalkText(
                            text: WalkLocalizations.of(context)
                                .translate('LogInACT2'),
                            weight: FontWeight.w400,
                            color: Color(0xFF20CE88),
                          ),
                        ),
                      ),
                      onTap: () {
                        showConnectivity(context);
                        Navigator.of(context).pushNamed(
                          '/signUp',
                          arguments: logInKey,
                        );
                      },
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/walk21.svg',
                      ),
                    ),
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        {
                          var version = '';
                          if (snapshot.data != null) {
                            version = snapshot.data.version;
                          }
                          return Center(
                            child: WalkText(
                              text: WalkLocalizations.of(context)
                                      .translate('LogInVERSION') +
                                  ': $version',
                              weight: FontWeight.w400,
                              size: 12,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

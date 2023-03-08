import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:walkability/ui/pwdRecovery/recoveryFeedback.dart';
import 'package:walkability/util/background.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/util/localization.dart';
import 'package:walkability/util/requests.dart';

class Recovery extends StatefulWidget {
  Recovery({
    Key key,
    this.recoveryKey,
  }) : super(key: key);
  _RecoveryState createState() => _RecoveryState();
  final GlobalKey<ScaffoldState> recoveryKey;
}

class _RecoveryState extends State<Recovery> {
  final _formKey = GlobalKey<FormState>();
  var _iconFeedback = null;
  String _validation = "";
  TextEditingController _username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/password.svg',
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: WalkText(
                            text: WalkLocalizations.of(context)
                                .translate('pwdRecoverySTARTtitle'),
                            size: 21,
                            weight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: WalkText(
                            text: WalkLocalizations.of(context)
                                .translate('pwdRecoverySTARTtext'),
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ),
                        WalkForm(
                          controller: _username,
                          keyboardType: TextInputType.text,
                          text: WalkLocalizations.of(context)
                              .translate('pwdRecoverySTARTform'),
                          icon: _iconFeedback,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Center(
                            child: WalkText(
                              weight: FontWeight.bold,
                              text: _validation,
                              size: 14,
                              color: Color(0xFF8A12B1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: WalkButton(
                          text: WalkLocalizations.of(context)
                              .translate('pwdRecoverySTARTbutton'),
                          onPressed: () async {
                            var response = json
                                .decode(await passwordRecovery(_username.text));
                            print(response['code']);

                            if (response['code'] != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecoveryFeedback(
                                      state: response['code'] == 200),
                                ),
                              );
                            } else {
                              print("entra");
                              setState(
                                () => {
                                  _iconFeedback = cross,
                                  _validation = WalkLocalizations.of(context)
                                      .translate('pwdRecoverySTARTval')
                                },
                              );
                            }
                          },
                        ),
                      ),
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

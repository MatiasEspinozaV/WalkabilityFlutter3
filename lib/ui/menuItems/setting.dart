import 'package:flutter/material.dart';

import 'package:walkability/util/components.dart';
import 'package:walkability/util/localization.dart';
import 'package:walkability/util/requests.dart';

class Setting extends StatefulWidget {
  Setting(this.userContext);
  final userContext;
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  double _gender = -1;
  double _ability = -1;
  double _age = -1;
  List<String> gender = ['man', 'woman', 'other'];
  List<String> ability = ['able', 'impaired', 'assisted'];
  List<String> age = ['child', 'teenager', 'adult', 'elderly'];
  Widget build(BuildContext context) {
    if (_gender * _ability * _age < 0) {
      _gender = gender
          .indexWhere((state) => state == widget.userContext['gender'])
          .toDouble();
      _ability = ability
          .indexWhere((state) => state == widget.userContext['ability'])
          .toDouble();
      _age = age
          .indexWhere((state) => state == widget.userContext['age'])
          .toDouble();
    }
    List<String> genderLabel = [
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextGENDERman'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextGENDERwoman'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextGENDERother'),
    ];
    List<String> abilityLabel = [
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextABILITYable'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextABILITYimpaired'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextABILITYassisted'),
    ];
    List<String> ageLabel = [
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextAGEchild'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextAGEteenager'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextAGEadult'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMuserContextAGEelderly'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: WalkText(
            text:
                WalkLocalizations.of(context).translate('mapScreenMENUname2')),
        backgroundColor: Color(0xFF001968),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WalkText(
              text: WalkLocalizations.of(context)
                  .translate('initialSettingSETTINGFORMuserContextGENDERtitle'),
              color: Color(0xFF001968),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.07),
              child: WalkSlider(
                min: 0.0,
                max: 2.0,
                labels: genderLabel,
                value: _gender,
                onChanged: (dynamic newValue) {
                  setState(
                    () {
                      _gender = newValue;
                    },
                  );
                },
              ),
            ),
            WalkText(
              text: WalkLocalizations.of(context).translate(
                  'initialSettingSETTINGFORMuserContextABILITYtitle'),
              color: Color(0xFF001968),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.07),
              child: WalkSlider(
                min: 0.0,
                max: 2.0,
                labels: abilityLabel,
                value: _ability,
                onChanged: (dynamic newValue) {
                  setState(
                    () {
                      _ability = newValue;
                    },
                  );
                },
              ),
            ),
            WalkText(
              text: WalkLocalizations.of(context)
                  .translate('initialSettingSETTINGFORMuserContextAGEtitle'),
              color: Color(0xFF001968),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: WalkSlider(
                min: 0.0,
                max: 3.0,
                labels: ageLabel,
                value: _age,
                onChanged: (dynamic newValue) {
                  setState(
                    () {
                      _age = newValue;
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 1.15,
              child: WalkButton(
                onPressed: () async {
                  showConnectivity(context);
                  await createUserContext(
                    gender[_gender.round()],
                    ability[_ability.round()],
                    age[_age.round()],
                  );
                  Navigator.pop(context);
                },
                text: WalkLocalizations.of(context)
                    .translate('initialSettingSETTINGFORMbutton'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

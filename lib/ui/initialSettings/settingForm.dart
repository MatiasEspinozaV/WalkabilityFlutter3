import 'package:flutter/material.dart';

import 'package:walkability/util/localization.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/util/background.dart';
import 'package:walkability/ui/initialSettings/settingFeedback.dart';
import 'package:walkability/util/requests.dart';

class SettingForm extends StatefulWidget {
  SettingForm({
    Key key,
  }) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  var _firstform = 0;
  // User Context
  double _gender = 0.0;
  List<String> gender = ['man', 'woman', 'other'];
  double _ability = 0;
  List<String> ability = ['able', 'impaired', 'assisted'];
  double _age = 0;
  List<String> age = ['child', 'teenager', 'adult', 'elderly'];

  // Walk Context
  double _decision = 0;
  List<String> decision = ['necessity', 'choice'];
  double _purpose = 0;
  List<String> purpose = ['transport', 'leisure'];
  double _groupSize = 0;
  List<String> groupSize = ['alone', 'with_a_dependent', 'group'];
  double _familiarity = 0;
  List<String> familiarity = ['local', 'visitor'];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04,
                    right: 25,
                    left: 25,
                  ),
                  child: WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('initialSettingSETTINGFORMtitle'),
                    size: 24,
                  ),
                ),
                Stack(
                  children: [
                    _walkContext(),
                    _firstform == 0 ? _userContext() : Container(),
                  ],
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.15,
                    child: WalkButton(
                      onPressed: () async {
                        showConnectivity(context);
                        setState(() => _firstform += 1);
                        if (_firstform > 1) {
                          await createWalkContext(
                              decision[_decision.round()],
                              purpose[_purpose.round()],
                              groupSize[_groupSize.round()],
                              familiarity[_familiarity.round()],
                              null,
                              null);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingFeedback(),
                            ),
                            (route) => false,
                          );
                        } else {
                          await createUserContext(
                            gender[_gender.round()],
                            ability[_ability.round()],
                            age[_age.round()],
                          );
                        }
                      },
                      text: WalkLocalizations.of(context)
                          .translate('initialSettingSETTINGFORMbutton'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userContext() {
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
        left: 20,
        right: 20,
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  margin: EdgeInsets.only(right: 4),
                  height: 8,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFF20CE88),
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                SizedBox(width: 8),
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  margin: EdgeInsets.only(right: 4),
                  height: 8,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFFC4C4C4),
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _walkContext() {
    List<String> decisionLabel = [
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMwalkContextDECISIONnecessity'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMwalkContextDECISIONchoice')
    ];
    List<String> purposeLabel = [
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMwalkContextPURPOSEtransport'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMwalkContextPURPOSEleisure')
    ];
    List<String> groupSizeLabel = [
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMwalkContextGROUPSIZEalone'),
      WalkLocalizations.of(context).translate(
          'initialSettingSETTINGFORMwalkContextGROUPSIZElwithDependent'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMwalkContextGROUPSIZEgroup')
    ];
    List<String> familiarityLabel = [
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMwalkContextFAMILIARITYlocal'),
      WalkLocalizations.of(context)
          .translate('initialSettingSETTINGFORMwalkContextFAMILIARITYvisitor')
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WalkText(
              text: WalkLocalizations.of(context).translate(
                  'initialSettingSETTINGFORMwalkContextDECISIONtitle'),
              color: Color(0xFF001968),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03),
              child: WalkSlider(
                min: 0.0,
                max: 1.0,
                labels: decisionLabel,
                value: _decision,
                onChanged: (dynamic newValue) {
                  setState(
                    () {
                      _decision = newValue;
                    },
                  );
                },
              ),
            ),
            WalkText(
              text: WalkLocalizations.of(context).translate(
                  'initialSettingSETTINGFORMwalkContextPURPOSEtitle'),
              color: Color(0xFF001968),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03),
              child: WalkSlider(
                min: 0.0,
                max: 1.0,
                labels: purposeLabel,
                value: _purpose,
                onChanged: (dynamic newValue) {
                  setState(
                    () {
                      _purpose = newValue;
                    },
                  );
                },
              ),
            ),
            WalkText(
              text: WalkLocalizations.of(context).translate(
                  'initialSettingSETTINGFORMwalkContextGROUPSIZEtitle'),
              color: Color(0xFF001968),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03),
              child: WalkSlider(
                min: 0.0,
                max: 2.0,
                labels: groupSizeLabel,
                value: _groupSize,
                onChanged: (dynamic newValue) {
                  setState(
                    () {
                      _groupSize = newValue;
                    },
                  );
                },
              ),
            ),
            WalkText(
              text: WalkLocalizations.of(context).translate(
                  'initialSettingSETTINGFORMwalkContextFAMILIARITYtitle'),
              color: Color(0xFF001968),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03),
              child: WalkSlider(
                min: 0.0,
                max: 1.0,
                labels: familiarityLabel,
                value: _familiarity,
                onChanged: (dynamic newValue) {
                  setState(
                    () {
                      _familiarity = newValue;
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  margin: EdgeInsets.only(right: 4),
                  height: 8,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFF20CE88),
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                SizedBox(width: 8),
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  margin: EdgeInsets.only(right: 4),
                  height: 8,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFF20CE88),
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

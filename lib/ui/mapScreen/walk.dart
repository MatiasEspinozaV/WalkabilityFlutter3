import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/util/localization.dart';
import 'package:walkability/util/requests.dart';
import 'package:walkability/providers/walkInfo.dart';

class Walk extends StatefulWidget {
  Walk({
    Key key,
  }) : super(key: key);

  @override
  _WalkState createState() => _WalkState();

  static showWalkContext(BuildContext context) async {
    return _WalkState()._showWalkContext(context);
  }
}

class _WalkState extends State<Walk> {
  List<String> decision = ['necessity', 'choice'];
  List<String> purpose = ['transport', 'leisure'];
  List<String> groupSize = ['alone', 'with_a_dependent', 'group'];
  List<String> familiarity = ['local', 'visitor'];
  bool isLoading = false;

  Future<void> _showWalkContext(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        List<String> decisionLabel = [
          WalkLocalizations.of(context).translate(
              'initialSettingSETTINGFORMwalkContextDECISIONnecessity'),
          WalkLocalizations.of(context)
              .translate('initialSettingSETTINGFORMwalkContextDECISIONchoice'),
        ];
        List<String> purposeLabel = [
          WalkLocalizations.of(context).translate(
              'initialSettingSETTINGFORMwalkContextPURPOSEtransport'),
          WalkLocalizations.of(context)
              .translate('initialSettingSETTINGFORMwalkContextPURPOSEleisure'),
        ];
        List<String> groupSizeLabel = [
          WalkLocalizations.of(context)
              .translate('initialSettingSETTINGFORMwalkContextGROUPSIZEalone'),
          WalkLocalizations.of(context).translate(
              'initialSettingSETTINGFORMwalkContextGROUPSIZElwithDependent'),
          WalkLocalizations.of(context)
              .translate('initialSettingSETTINGFORMwalkContextGROUPSIZEgroup'),
        ];
        List<String> familiarityLabel = [
          WalkLocalizations.of(context).translate(
              'initialSettingSETTINGFORMwalkContextFAMILIARITYlocal'),
          WalkLocalizations.of(context).translate(
              'initialSettingSETTINGFORMwalkContextFAMILIARITYvisitor'),
        ];
        final walkInfo = Provider.of<WalkInfo>(context);
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                children: <Widget>[
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    content: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      height: MediaQuery.of(context).size.height / 1.8,
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
                              padding: EdgeInsets.only(bottom: 30.0),
                              child: WalkSlider(
                                min: 0.0,
                                max: 1.0,
                                labels: decisionLabel,
                                value: walkInfo.decision,
                                onChanged: (dynamic newValue) {
                                  setState(
                                    () {
                                      walkInfo.decision = newValue;
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
                              padding: EdgeInsets.only(bottom: 30.0),
                              child: WalkSlider(
                                min: 0.0,
                                max: 1.0,
                                labels: purposeLabel,
                                value: walkInfo.purpose,
                                onChanged: (dynamic newValue) {
                                  setState(
                                    () {
                                      walkInfo.purpose = newValue;
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
                              padding: EdgeInsets.only(bottom: 30.0),
                              child: WalkSlider(
                                min: 0.0,
                                max: 2.0,
                                labels: groupSizeLabel,
                                value: walkInfo.groupSize,
                                onChanged: (dynamic newValue) {
                                  setState(
                                    () {
                                      walkInfo.groupSize = newValue;
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
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: WalkSlider(
                                min: 0.0,
                                max: 1.0,
                                labels: familiarityLabel,
                                value: walkInfo.familiarity,
                                onChanged: (dynamic newValue) {
                                  setState(
                                    () {
                                      walkInfo.familiarity = newValue;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      InkWell(
                        child: Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(bottom: 30),
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: WalkButton(
                              onPressed: () async {
                                setState(() => isLoading = true);
                                var response = await createWalkContext(
                                    decision[walkInfo.decision.round()],
                                    purpose[walkInfo.purpose.round()],
                                    groupSize[walkInfo.groupSize.round()],
                                    familiarity[walkInfo.familiarity.round()],
                                    walkInfo.city,
                                    walkInfo.countryCode);
                                if (response) {
                                  setState(() => isLoading = false);
                                  Navigator.of(context).pop();
                                }
                              },
                              text: WalkLocalizations.of(context)
                                  .translate('initialSettingSETTINGFORMbutton'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  isLoading
                      ? Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container()
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:walkability/util/localization.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/util/background.dart';
import 'package:walkability/ui/initialSettings/settingForm.dart';

class SettingStart extends StatelessWidget {
  SettingStart({
    Key key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset('assets/images/steps.svg'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('initialSettingSETTINGSTARTtitle'),
                    size: 24,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    bottom: MediaQuery.of(context).size.height * 0.08,
                  ),
                  child: WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('initialSettingSETTINGSTARTtext'),
                    weight: FontWeight.w400,
                    size: 14,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.15,
                    child: WalkButton(
                      onPressed: () {
                        showConnectivity(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingForm()));
                      },
                      text: WalkLocalizations.of(context)
                          .translate('initialSettingSETTINGSTARTbutton'),
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
}

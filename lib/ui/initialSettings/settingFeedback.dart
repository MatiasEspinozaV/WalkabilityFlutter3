import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:walkability/util/localization.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/util/background.dart';
import 'package:walkability/ui/mapScreen/map.dart';

class SettingFeedback extends StatelessWidget {
  SettingFeedback({
    Key key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Material(
      child: Stack(
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
                  child: SvgPicture.asset(
                    'assets/images/success.svg',
                    width: MediaQuery.of(context).size.width / 1.15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.15),
                  child: WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('initialSettingSETTINGFEEDBACKtitle'),
                    size: 24,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.08,
                    bottom: MediaQuery.of(context).size.width * 0.16,
                  ),
                  child: WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('initialSettingSETTINGFEEDBACKtext'),
                    weight: FontWeight.w400,
                    size: 14,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.15,
                    child: WalkButton(
                      text: WalkLocalizations.of(context)
                          .translate('initialSettingSETTINGFEEDBACKbutton'),
                      onPressed: () async {
                        showConnectivity(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(),
                          ),
                          (route) => false,
                        );
                      },
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

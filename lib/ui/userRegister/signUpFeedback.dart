import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:walkability/ui/logIn.dart';

import 'package:walkability/util/localization.dart';
import 'package:walkability/util/background.dart';
import 'package:walkability/util/components.dart';

class SignUpFeedback extends StatelessWidget {
  SignUpFeedback({
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
                  child: SvgPicture.asset('assets/images/celebrate.svg'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('userRegisterSIGNUPFEEDBACKtitle'),
                    size: 24,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 60),
                  child: WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('userRegisterSIGNUPFEEDBACKtext'),
                    size: 14,
                    weight: FontWeight.w400,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.15,
                    child: WalkButton(
                      text: WalkLocalizations.of(context)
                          .translate('userRegisterSIGNUPFEEDBACKbutton'),
                      onPressed: () async {
                        showConnectivity(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogIn(),
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

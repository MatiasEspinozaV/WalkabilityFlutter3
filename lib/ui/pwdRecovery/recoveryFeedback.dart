import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:walkability/ui/logIn.dart';
import 'package:walkability/util/background.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/util/localization.dart';

class RecoveryFeedback extends StatelessWidget {
  RecoveryFeedback({Key key, this.state});
  final state;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: state
                        ? SvgPicture.asset(
                            'assets/images/recoveryCheck.svg',
                            width: MediaQuery.of(context).size.width * 0.55,
                          )
                        : SvgPicture.asset(
                            'assets/images/recoveryCross.svg',
                            width: MediaQuery.of(context).size.width * 0.55,
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: WalkText(
                          text: state
                              ? WalkLocalizations.of(context)
                                  .translate('pwdRecoveryFEEDBACKtitleSUCCESS')
                              : WalkLocalizations.of(context)
                                  .translate('pwdRecoveryFEEDBACKtitleFAIL'),
                          size: 21,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: WalkText(
                          text: state
                              ? WalkLocalizations.of(context)
                                  .translate('pwdRecoveryFEEDBACKtextSUCCESS')
                              : WalkLocalizations.of(context)
                                  .translate('pwdRecoveryFEEDBACKtextFAIL'),
                          size: 14,
                          weight: FontWeight.w400,
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
                            .translate('pwdRecoveryFEEDBACKbutton'),
                        onPressed: () {
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
      ),
    );
  }
}

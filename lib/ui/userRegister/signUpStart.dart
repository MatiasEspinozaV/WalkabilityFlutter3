import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:walkability/ui/userRegister/privacyPolicy.dart';
import 'package:walkability/ui/userRegister/termService.dart';

import 'package:walkability/util/requests.dart';
import 'package:walkability/util/localization.dart';
import 'package:walkability/util/background.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/ui/userRegister/signUpForm.dart';

class SignUpStart extends StatefulWidget {
  SignUpStart({
    Key key,
    this.signUpKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> signUpKey;

  _SignUpStartState createState() => _SignUpStartState();
}

class _SignUpStartState extends State<SignUpStart> {
  final _formKey = GlobalKey<FormState>();
  var _iconFeedback = List<Icon>.filled(3, null);
  var userName = "";
  var _validated = Color(0xFFA0A09C);
  String usernameValidator;

  void termService(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Scrollbar(
              isAlwaysShown: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TermService(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            height: 42,
                            width: MediaQuery.of(context).size.width / 3.7,
                            child: WalkButton(
                              text: WalkLocalizations.of(context)
                                  .translate('userRegisterSIGNUPSTARTdecline'),
                              onPressed: () {
                                setState(() => _validated = Color(0xFFA0A09C));
                                setState(() => _iconFeedback[1] = cross);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            height: 42,
                            width: MediaQuery.of(context).size.width / 3.7,
                            child: WalkButton(
                              text: WalkLocalizations.of(context)
                                  .translate('userRegisterSIGNUPSTARTaccept'),
                              onPressed: () {
                                setState(() => _iconFeedback[1] = check);
                                if (_iconFeedback[0] == check &&
                                    _iconFeedback[2] == check) {
                                  setState(
                                      () => _validated = Color(0xFF20CE88));
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void privacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Scrollbar(
              isAlwaysShown: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrivacyPolicy(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            height: 42,
                            width: MediaQuery.of(context).size.width / 3.7,
                            child: WalkButton(
                              text: WalkLocalizations.of(context)
                                  .translate('userRegisterSIGNUPSTARTdecline'),
                              onPressed: () {
                                setState(() => _validated = Color(0xFFA0A09C));
                                setState(() => _iconFeedback[2] = cross);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            height: 42,
                            width: MediaQuery.of(context).size.width / 3.7,
                            child: WalkButton(
                              text: WalkLocalizations.of(context)
                                  .translate('userRegisterSIGNUPSTARTaccept'),
                              onPressed: () {
                                setState(() => _iconFeedback[2] = check);
                                if (_iconFeedback[0] == check &&
                                    _iconFeedback[1] == check) {
                                  setState(
                                      () => _validated = Color(0xFF20CE88));
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_iconFeedback[1] == null) {
      _iconFeedback[1] = cross;
      _iconFeedback[2] = cross;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Background(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/welcome.svg',
                        width: MediaQuery.of(context).size.width * 0.85,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: WalkText(
                        text: WalkLocalizations.of(context)
                            .translate('userRegisterSIGNUPSTARTtitle'),
                        size: 24,
                      ),
                    ),
                    WalkText(
                      text: WalkLocalizations.of(context)
                          .translate('userRegisterSIGNUPSTARTtext'),
                      size: 14,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 30),
                      child: WalkForm(
                        text: WalkLocalizations.of(context)
                            .translate('userRegisterSIGNUPSTARTformText'),
                        icon: _iconFeedback[0],
                        onChanged: (value) {
                          userName = value;
                          if (value.contains(' ') ||
                              value.length < 3 ||
                              RegExp(r'[A-Z]').hasMatch(value)) {
                            setState(
                              () => {
                                _iconFeedback[0] = cross,
                                _validated = Color(0xFFA0A09C),
                              },
                            );
                          } else {
                            setState(() => _iconFeedback[0] = check);
                            if (_iconFeedback[1] == check &&
                                _iconFeedback[2] == check) {
                              setState(() => _validated = Color(0xFF20CE88));
                            }
                          }
                        },
                        validator: (value) {
                          userName = value;
                          setState(() => _validated = Color(0xFFA0A09C));
                          return usernameValidator;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.error_outline, color: Color(0xFF20CE88)),
                          GestureDetector(
                            child: WalkText(
                              text: WalkLocalizations.of(context).translate(
                                  'userRegisterSIGNUPSTARTtermsOfService'),
                              weight: FontWeight.w400,
                              size: 12,
                              color: Color(0xFF20CE88),
                            ),
                            onTap: () {
                              termService(context);
                            },
                          ),
                          SizedBox(width: 80),
                          _iconFeedback[1],
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.error_outline, color: Color(0xFF20CE88)),
                          GestureDetector(
                            child: WalkText(
                              text: WalkLocalizations.of(context).translate(
                                  'userRegisterSIGNUPSTARTprivacyPolicy'),
                              weight: FontWeight.w400,
                              size: 12,
                              color: Color(0xFF20CE88),
                            ),
                            onTap: () {
                              privacyPolicy(context);
                            },
                          ),
                          SizedBox(width: 95),
                          _iconFeedback[2] == check ? check : cross,
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: WalkButton(
                          text: WalkLocalizations.of(context)
                              .translate('userRegisterSIGNUPSTARTbutton'),
                          color: _validated,
                          onPressed: () async {
                            showConnectivity(context);
                            setState(() => usernameValidator = null);
                            bool userExists = await checkUser(userName);
                            print(userExists);
                            if (userExists) {
                              print(userExists);
                              setState(() => _iconFeedback[0] = cross);
                              setState(() => usernameValidator =
                                  WalkLocalizations.of(context)
                                      .translate('userRegisterSIGNUPSTARTval'));
                            }
                            if (_iconFeedback[1] == check ||
                                _iconFeedback[2] == check) {
                              setState(() => _validated = Color(0xFF20CE88));
                            }
                            if (_formKey.currentState.validate() &&
                                _iconFeedback[1] == check &&
                                _iconFeedback[2] == check) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpForm(name: userName),
                                ),
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

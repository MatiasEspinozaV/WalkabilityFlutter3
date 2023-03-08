import 'package:flutter/material.dart';

import 'package:walkability/util/localization.dart';
import 'package:walkability/util/background.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/ui/userRegister/signUpFeedback.dart';
import 'package:walkability/util/requests.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({
    Key key,
    this.name,
  }) : super(key: key);
  final name;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var _iconFeedback = List<Icon>.filled(4, null);
  var _validation = '';

  String email, phone;
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: WalkText(
                        text: WalkLocalizations.of(context)
                                .translate('userRegisterSIGNUPFORMtitle') +
                            widget.name,
                        size: 24,
                      ),
                    ),
                    WalkText(
                      text: WalkLocalizations.of(context)
                          .translate('userRegisterSIGNUPFORMtext1'),
                      size: 14,
                      weight: FontWeight.w400,
                    ),
                    WalkForm(
                      keyboardType: TextInputType.text,
                      text: WalkLocalizations.of(context)
                          .translate('userRegisterSIGNUPFORMformMail'),
                      icon: _iconFeedback[0],
                      onChanged: (value) {
                        email = value;
                        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                            .hasMatch(value)) {
                          setState(() => _iconFeedback[0] = cross);
                        } else {
                          setState(() => _iconFeedback[0] = check);
                        }
                        if (value == null || value.isEmpty) {
                          setState(() => _iconFeedback[0] = check);
                        }
                      },
                      validator: (value) {
                        email = value;
                        _iconFeedback[0] = check;
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                            .hasMatch(value)) {
                          _iconFeedback[0] = cross;
                          return WalkLocalizations.of(context)
                              .translate('userRegisterSIGNUPFORMformMailVAL1');
                        }
                        return null;
                      },
                    ),
                    WalkForm(
                      keyboardType: TextInputType.number,
                      text: WalkLocalizations.of(context)
                          .translate('userRegisterSIGNUPFORMformPhone'),
                      icon: _iconFeedback[1],
                      onChanged: (value) {
                        phone = value;
                        if (!RegExp(r'^[0-9]{7,15}$').hasMatch(value)) {
                          setState(() => _iconFeedback[1] = cross);
                        } else {
                          setState(() => _iconFeedback[1] = check);
                        }
                        if (value == null || value.isEmpty) {
                          setState(() => _iconFeedback[1] = check);
                        }
                      },
                      validator: (value) {
                        _iconFeedback[1] = check;
                        phone = value;
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (value.contains('+') || value.contains(' ')) {
                          _iconFeedback[1] = cross;
                          return WalkLocalizations.of(context)
                              .translate('userRegisterSIGNUPFORMformPhoneVAL1');
                        }
                        if (!RegExp(r'^[0-9]{7,15}$').hasMatch(value)) {
                          _iconFeedback[1] = cross;
                          return WalkLocalizations.of(context)
                              .translate('userRegisterSIGNUPFORMformPhoneVAL2');
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        phone = value;
                      },
                    ),
                    WalkText(
                      text: WalkLocalizations.of(context)
                          .translate('userRegisterSIGNUPFORMtext2'),
                      size: 14,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: WalkText(
                        text: WalkLocalizations.of(context)
                            .translate('userRegisterSIGNUPFORMrulesPass'),
                        weight: FontWeight.w400,
                        size: 10,
                        color: Color(0xFF20CE88),
                      ),
                    ),
                    WalkForm(
                      controller: _password,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      text: WalkLocalizations.of(context)
                          .translate('userRegisterSIGNUPFORMformPass1'),
                      icon: _iconFeedback[2],
                      validator: (value) {
                        if (value.length < 8 ||
                            value.contains(' ') ||
                            _password.text != _confirmPassword.text) {
                          setState(() => _iconFeedback[2] = cross);
                        } else {
                          setState(() => _iconFeedback[2] = check);
                        }
                        return null;
                      },
                    ),
                    WalkForm(
                      controller: _confirmPassword,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      text: WalkLocalizations.of(context)
                          .translate('userRegisterSIGNUPFORMformPass2'),
                      icon: _iconFeedback[3],
                      validator: (value) {
                        setState(() => _iconFeedback[3] = check);
                        _validation = '';
                        if (_password.text != _confirmPassword.text) {
                          setState(
                            () => {
                              _iconFeedback[3] = cross,
                              _validation = WalkLocalizations.of(context)
                                  .translate(
                                      'userRegisterSIGNUPFORMformPass2VAL1')
                            },
                          );
                        }
                        if (value.length < 8 ||
                            value.contains(' ')) {
                          setState(
                            () => {
                              _iconFeedback[3] = cross,
                              _validation = WalkLocalizations.of(context)
                                  .translate(
                                      'userRegisterSIGNUPFORMformPass2VAL2')
                            },
                          );
                        }
                        if (value == null || value.isEmpty) {
                          setState(
                            () => {
                              _iconFeedback[3] = cross,
                              _validation = WalkLocalizations.of(context)
                                  .translate(
                                      'userRegisterSIGNUPFORMformPass2VAL3')
                            },
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: WalkText(
                          text: _validation,
                          size: 12,
                          color: Color(0xFF8A12B1),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: WalkButton(
                          text: WalkLocalizations.of(context)
                              .translate('userRegisterSIGNUPFORMbutton'),
                          onPressed: () async {
                            showConnectivity(context);
                            if (_formKey.currentState.validate() &&
                                _validation.isEmpty) {
                              bool _futureUser = await createUser(widget.name,
                                  email, _password.text, phone, null);
                              if (_futureUser != null) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpFeedback(),
                                  ),
                                  (route) => false,
                                );
                              }
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

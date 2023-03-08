import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:walkability/util/components.dart';
import 'package:walkability/util/localization.dart';
import 'package:walkability/util/requests.dart';

class Account extends StatefulWidget {
  Account({Key key, this.user});
  final user;
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var editState;
  final _formKey = GlobalKey<FormState>();
  var _iconFeedback = List<Icon>.filled(5, null);
  var _validation = '';

  var init;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  Widget build(BuildContext context) {
    if (editState == null) {
      setState(
        () => {
          editState = false,
          _emailController.text = widget.user['email'],
          _phoneController.text = widget.user['phone'],
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: WalkText(
            text:
                WalkLocalizations.of(context).translate('mapScreenMENUname1')),
        backgroundColor: Color(0xFF001968),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: WalkText(
                        text: WalkLocalizations.of(context)
                                .translate('userRegisterSIGNUPFORMtitle') +
                            widget.user['username'],
                        size: 24,
                        color: Color(0xFF001968),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/welcome.svg',
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              !editState
                  ? Show(context, widget)
                  : Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: WalkText(
                              text: WalkLocalizations.of(context)
                                  .translate('menuItemsACCOUNTshowTITLE1'),
                              color: Color(0xFFA0A09C),
                              weight: FontWeight.w700,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: WalkForm(
                              keyboardType: TextInputType.text,
                              text: WalkLocalizations.of(context)
                                  .translate('userRegisterSIGNUPFORMformMail'),
                              icon: _iconFeedback[0],
                              color: Color(0xFFA0A09C),
                              controller: _emailController,
                              onChanged: (value) {
                                if (!RegExp(
                                        '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                                    .hasMatch(value)) {
                                  _iconFeedback[0] = cross;
                                } else {
                                  _iconFeedback[0] = check;
                                }
                                if (value == null || value.isEmpty) {
                                  _iconFeedback[0] = check;
                                }
                              },
                              validator: (value) {
                                _iconFeedback[0] = check;
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                if (!RegExp(
                                        '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                                    .hasMatch(value)) {
                                  _iconFeedback[0] = cross;
                                  return WalkLocalizations.of(context)
                                      .translate(
                                          'userRegisterSIGNUPFORMformMailVAL1');
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: WalkForm(
                              keyboardType: TextInputType.number,
                              text: WalkLocalizations.of(context)
                                  .translate('userRegisterSIGNUPFORMformPhone'),
                              icon: _iconFeedback[1],
                              color: Color(0xFFA0A09C),
                              controller: _phoneController,
                              onChanged: (value) {
                                if (!RegExp(r'^[0-9]{7,15}$').hasMatch(value)) {
                                  _iconFeedback[1] = cross;
                                } else {
                                  _iconFeedback[1] = check;
                                }
                                if (value == null || value.isEmpty) {
                                  _iconFeedback[1] = check;
                                }
                              },
                              validator: (value) {
                                setState(
                                  () => {
                                    _iconFeedback[1] = check,
                                  },
                                );
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                if (value.contains('+') ||
                                    value.contains(' ')) {
                                  _iconFeedback[1] = cross;
                                  return WalkLocalizations.of(context).translate(
                                      'userRegisterSIGNUPFORMformPhoneVAL1');
                                }
                                if (!RegExp(r'^[0-9]{7,15}$').hasMatch(value)) {
                                  _iconFeedback[1] = cross;
                                  return WalkLocalizations.of(context).translate(
                                      'userRegisterSIGNUPFORMformPhoneVAL2');
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: WalkText(
                              text: WalkLocalizations.of(context)
                                  .translate('menuItemsACCOUNTshowTITLE2'),
                              color: Color(0xFFA0A09C),
                              weight: FontWeight.w700,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 5),
                            child: WalkText(
                              text: WalkLocalizations.of(context)
                                  .translate('userRegisterSIGNUPFORMrulesPass'),
                              weight: FontWeight.w400,
                              size: 12,
                              color: Color(0xFF20CE88),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: WalkForm(
                              controller: _newPassword,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              text: WalkLocalizations.of(context)
                                  .translate('menuItemsACCOUNTshowFORM1'),
                              icon: _iconFeedback[2],
                              color: Color(0xFFA0A09C),
                              validator: (value) {
                                setState(
                                  () => {
                                    _validation == "",
                                    _iconFeedback[2] = check,
                                  },
                                );
                                if (_newPassword.text !=
                                    _confirmPassword.text) {
                                  setState(
                                    () => {
                                      _iconFeedback[2] = cross,
                                      _validation = WalkLocalizations.of(
                                              context)
                                          .translate(
                                              'userRegisterSIGNUPFORMformPass2VAL1'),
                                    },
                                  );
                                }
                                if (value.length < 8 || value.contains(' ')) {
                                  print(value);
                                  setState(
                                    () => {
                                      _iconFeedback[2] = cross,
                                      _validation = WalkLocalizations.of(
                                              context)
                                          .translate(
                                              'userRegisterSIGNUPFORMformPass2VAL2'),
                                    },
                                  );
                                }
                                if (value == null || value == "") {
                                  setState(() => {_iconFeedback[2] = check});
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: WalkForm(
                              controller: _confirmPassword,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              text: WalkLocalizations.of(context)
                                  .translate('menuItemsACCOUNTshowFORM2'),
                              icon: _iconFeedback[3],
                              color: Color(0xFFA0A09C),
                              validator: (value) {
                                setState(
                                  () => {
                                    _validation == "",
                                    _iconFeedback[3] = check,
                                  },
                                );
                                if (_newPassword.text !=
                                    _confirmPassword.text) {
                                  setState(
                                    () => {
                                      _iconFeedback[3] = cross,
                                      _validation = WalkLocalizations.of(
                                              context)
                                          .translate(
                                              'userRegisterSIGNUPFORMformPass2VAL1'),
                                    },
                                  );
                                }
                                if (value.length < 8 || value.contains(' ')) {
                                  setState(
                                    () => {
                                      _iconFeedback[3] = cross,
                                      _validation = WalkLocalizations.of(
                                              context)
                                          .translate(
                                              'userRegisterSIGNUPFORMformPass2VAL2'),
                                    },
                                  );
                                }
                                if (value == null || value.isEmpty) {
                                  setState(() => {_iconFeedback[3] = check});
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: WalkForm(
                              controller: _password,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              text: WalkLocalizations.of(context)
                                  .translate('menuItemsACCOUNTshowFORM3'),
                              icon: _iconFeedback[4],
                              color: Color(0xFFA0A09C),
                              validator: (value) {
                                if (_newPassword.text == _confirmPassword.text)
                                  _validation = "";
                                if (value == null || value.isEmpty) {
                                  setState(
                                    () => {
                                      _iconFeedback[4] = cross,
                                      _validation =
                                          WalkLocalizations.of(context)
                                              .translate(
                                                  'menuItemsACCOUNTeditVAL1'),
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: WalkText(
                                text: _validation != null ? _validation : "",
                                size: 12,
                                color: Color(0xFF8A12B1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              Center(
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: WalkButton(
                    text: editState
                        ? WalkLocalizations.of(context)
                            .translate('menuItemsACCOUNTeditBUTTON')
                        : WalkLocalizations.of(context)
                            .translate('menuItemsACCOUNTshowBUTTON'),
                    onPressed: () async {
                      if (editState) {
                        if (_formKey.currentState.validate() &&
                            _validation.isEmpty &&
                            _validation == "") {
                          TextEditingController newPassword =
                              _newPassword.text.isEmpty
                                  ? _password
                                  : _newPassword;
                          var passwordState =
                              await updatePassword(_password, newPassword);
                          if (passwordState) {
                            setState(() => _iconFeedback[4] = check);
                            var response = await updateUserInfo(
                                _emailController,
                                newPassword,
                                _phoneController);
                            if (response)
                              setState(
                                () => {
                                  widget.user['email'] = _emailController.text,
                                  widget.user['phone'] = _phoneController.text,
                                  _newPassword.text = "",
                                  _confirmPassword.text = "",
                                  _password.text = "",
                                  editState = !editState,
                                  _iconFeedback = List<Icon>.filled(5, null),
                                },
                              );
                          } else {
                            setState(
                              () => {
                                _iconFeedback[4] = cross,
                                _validation = WalkLocalizations.of(context)
                                    .translate('menuItemsACCOUNTeditVAL2'),
                              },
                            );
                          }
                        }
                      } else {
                        setState(() => editState = !editState);
                      }
                    },
                    weight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget Show(context, widget) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: WalkText(
          text: WalkLocalizations.of(context)
              .translate('menuItemsACCOUNTshowTITLE1'),
          color: Color(0xFFA0A09C),
          weight: FontWeight.w700,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: WalkText(
          text: WalkLocalizations.of(context)
                  .translate('menuItemsACCOUNTshowTEXT1.1') +
              ": " +
              widget.user['username'],
          color: Color(0xFFA0A09C),
          weight: FontWeight.w400,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: WalkText(
          text: WalkLocalizations.of(context)
                  .translate('menuItemsACCOUNTshowTEXT1.2') +
              ": " +
              (widget.user['email'] == ""
                  ? WalkLocalizations.of(context)
                      .translate('menuItemsACCOUNTshowNONE')
                  : widget.user['email']),
          color: Color(0xFFA0A09C),
          weight: FontWeight.w400,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: WalkText(
          text: WalkLocalizations.of(context)
                  .translate('menuItemsACCOUNTshowTEXT1.3') +
              ": " +
              ((widget.user['phone'] == null || widget.user['phone'] == "")
                  ? WalkLocalizations.of(context)
                      .translate('menuItemsACCOUNTshowNONE')
                  : widget.user['phone']),
          color: Color(0xFFA0A09C),
          weight: FontWeight.w400,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
        child: WalkText(
          text: WalkLocalizations.of(context)
              .translate('menuItemsACCOUNTshowTITLE2'),
          color: Color(0xFFA0A09C),
          weight: FontWeight.w700,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: WalkText(
          text: "********",
          color: Color(0xFFA0A09C),
          weight: FontWeight.w400,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
        child: WalkText(
          text: WalkLocalizations.of(context)
              .translate('menuItemsACCOUNTshowTITLE3'),
          color: Color(0xFFA0A09C),
          weight: FontWeight.w700,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: WalkText(
          text: widget.user['walkgroup'] == null
              ? WalkLocalizations.of(context)
                  .translate('menuItemsACCOUNTshowNONE')
              : widget.user['walkgroup'],
          color: Color(0xFFA0A09C),
          weight: FontWeight.w400,
        ),
      ),
    ],
  );
}

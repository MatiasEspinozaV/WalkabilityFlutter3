import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:walkability/providers/walkInfo.dart';

import 'package:walkability/util/localization.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/util/requests.dart';

class Comment extends StatefulWidget {
  Comment({Key key}) : super(key: key);

  _CommentState createState() => _CommentState();

  static showComment(BuildContext context) async {
    return _CommentState()._showComment(context);
  }
}

class _CommentState extends State<Comment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String comment;

  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> _showComment(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              final walkInfo = Provider.of<WalkInfo>(context);
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                content: Form(
                  key: _formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: Color(0xFF20CE88)),
                            iconSize: 18,
                            onPressed: () => {Navigator.of(context).pop()},
                          ),
                          WalkText(
                            text: WalkLocalizations.of(context)
                                .translate('mapScreenCOMMENTformTITLE'),
                            weight: FontWeight.w600,
                            color: Color(0xFF001968),
                          ),
                        ]),
                        TextField(
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: WalkLocalizations.of(context)
                                .translate('mapScreenCOMMENTformTEXT'),
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFFBDBDBD),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF9D9D9D),
                                width: 0.5,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => comment = value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  InkWell(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: SizedBox(
                          height: 42,
                          width: MediaQuery.of(context).size.width,
                          child: WalkButton(
                            text: WalkLocalizations.of(context)
                                .translate('mapScreenCOMMENTformBUTTON'),
                            onPressed: () {
                              walkInfo.comment = comment;
                              walkInfo.checked = List<bool>.filled(
                                  walkInfo.checked.length, false);
                              /*walkInfo.reportStep = false;
                              createData(walkInfo);*/
                              Navigator.of(context).pop();
                              _showFeedback(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  Future<void> _showFeedback(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: SvgPicture.asset('assets/images/check.svg'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: WalkText(
                        text: WalkLocalizations.of(context)
                            .translate('mapScreenCOMMENTfeedbackTEXT'),
                        weight: FontWeight.w600,
                        color: Color(0xFF9D9D9D),
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: SizedBox(
                        height: 42,
                        width: MediaQuery.of(context).size.width,
                        child: WalkButton(
                          text: WalkLocalizations.of(context)
                              .translate('mapScreenCOMMENTfeedbackBUTTON'),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}

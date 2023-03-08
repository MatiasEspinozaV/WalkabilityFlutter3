import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:walkability/util/localization.dart';
import 'package:walkability/util/components.dart';

class TermService extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.raleway(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF001968),
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: WalkLocalizations.of(context)
                              .translate('userRegisterTERMSOFSERVICEtitle1') +
                          ' '),
                  TextSpan(
                    text: WalkLocalizations.of(context)
                        .translate('userRegisterTERMSOFSERVICEtitle2'),
                    style: TextStyle(color: Color(0xFF20CE88)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterTERMSOFSERVICEtext0.1.1') +
                      ' ',
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterTERMSOFSERVICEwebsite') +
                      ' ',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterTERMSOFSERVICEtext0.1.2'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext0.2'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext0.3'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext0.4'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle1'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext1.1'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext1.2'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext1.3'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle2'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext2'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle3'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext3'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle4'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.1'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.2'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.3'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.4'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.5'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.6'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.7'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.8'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.9'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.10'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.11'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.12'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.13'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.14'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.15'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.16'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext4.17'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle5'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext5.1'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: String.fromCharCode(0x2022) + ' ',
                  style: TextStyle(color: Color(0xFF20CE88)),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterTERMSOFSERVICEtext5.2'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: String.fromCharCode(0x2022) + ' ',
                  style: TextStyle(color: Color(0xFF20CE88)),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterTERMSOFSERVICEtext5.3'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: String.fromCharCode(0x2022) + ' ',
                  style: TextStyle(color: Color(0xFF20CE88)),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterTERMSOFSERVICEtext5.4'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle6'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext6'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle7'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext7.1'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext7.2'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext7.3'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext7.4'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext7.5'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle8'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext8.1'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: String.fromCharCode(0x2022) + ' ',
                  style: TextStyle(color: Color(0xFF20CE88)),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterTERMSOFSERVICEtext8.2'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: String.fromCharCode(0x2022) + ' ',
                  style: TextStyle(color: Color(0xFF20CE88)),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterTERMSOFSERVICEtext8.3'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: String.fromCharCode(0x2022) + ' ',
                  style: TextStyle(color: Color(0xFF20CE88)),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterTERMSOFSERVICEtext8.4'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle9'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext9'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle10'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEtext10'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterTERMSOFSERVICEsubtitle11'),
            weight: FontWeight.w600,
            size: 15,
            color: Color(0xFF001968),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15, bottom: 20),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterTERMSOFSERVICEtext11') +
                      ' ',
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterTERMSOFSERVICEmail'),
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

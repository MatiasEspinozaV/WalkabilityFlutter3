import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:walkability/util/localization.dart';
import 'package:walkability/util/components.dart';

class PrivacyPolicy extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
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
                              .translate('userRegisterPRIVACYPOLICYtitle1.1') +
                          ' '),
                  TextSpan(
                    text: WalkLocalizations.of(context)
                        .translate('userRegisterPRIVACYPOLICYtitle1.2'),
                    style: TextStyle(color: Color(0xFF20CE88)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: WalkText(
              text: WalkLocalizations.of(context)
                  .translate('userRegisterPRIVACYPOLICYtitle2'),
              weight: FontWeight.w600,
              size: 10,
              color: Color(0xFF001968),
              align: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYtext0.1'),
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
                .translate('userRegisterPRIVACYPOLICYtext0.2'),
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
                .translate('userRegisterPRIVACYPOLICYtext0.3'),
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
                .translate('userRegisterPRIVACYPOLICYsubtitle1'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
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
                          .translate('userRegisterPRIVACYPOLICYtext1.1') +
                      ' ',
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYfoundation') +
                      ' ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYtext1.2') +
                      ' ',
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYmail'),
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYsubtitle2'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYtext2.1'),
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
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYa') +
                      ' ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYtext2.2'),
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
                    text: WalkLocalizations.of(context)
                            .translate('userRegisterPRIVACYPOLICYb') +
                        ' ',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYtext2.3'),
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
                    text: WalkLocalizations.of(context)
                            .translate('userRegisterPRIVACYPOLICYc') +
                        ' ',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYtext2.4'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYsubtitle3'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYtext3.1'),
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
                .translate('userRegisterPRIVACYPOLICYtext3.2'),
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
                .translate('userRegisterPRIVACYPOLICYsubtitle4'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
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
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYtext4.1.1') +
                      ' ',
                ),
                TextSpan(
                  text: '(' +
                      WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYa') +
                      ' ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYtext4.1.2') +
                      ' ',
                ),
                TextSpan(
                  text: '(' +
                      WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYc') +
                      ' ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYtext4.1.3'),
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
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYtext4.2.1'),
                ),
                TextSpan(
                  text: ' (' +
                      WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYb') +
                      ', ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYtext4.2.2'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYsubtitle5'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
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
                          .translate('userRegisterPRIVACYPOLICYtext5.1') +
                      ' ',
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYmail') +
                      ' ',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYtext5.2') +
                      ' ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYtext5.3') +
                      ' ',
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYmail') +
                      ' ',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYtext5.4'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYsubtitle6'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
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
                          .translate('userRegisterPRIVACYPOLICYtext6.1') +
                      ' ',
                ),
                TextSpan(
                  text: '(' +
                      WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYa') +
                      ' ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYtext6.2') +
                      ' ',
                ),
                TextSpan(
                  text: '(' +
                      WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYb') +
                      ' ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYtext6.3') +
                      ' ',
                ),
                TextSpan(
                  text: '(' +
                      WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYc') +
                      ' ',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYtext6.4'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYsubtitle7'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYtext7.1'),
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
                      .translate('userRegisterPRIVACYPOLICYtext7.2'),
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
                      .translate('userRegisterPRIVACYPOLICYtext7.3'),
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
                      .translate('userRegisterPRIVACYPOLICYtext7.4'),
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
                      .translate('userRegisterPRIVACYPOLICYtext7.5'),
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
                      .translate('userRegisterPRIVACYPOLICYtext7.6'),
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
                      .translate('userRegisterPRIVACYPOLICYtext7.7'),
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
                      .translate('userRegisterPRIVACYPOLICYtext7.8'),
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
                      .translate('userRegisterPRIVACYPOLICYtext7.9'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYtext7.10'),
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
                .translate('userRegisterPRIVACYPOLICYfoundation'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYtext7.11'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYtext7.12'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
            align: TextAlign.justify,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: WalkLocalizations.of(context)
                          .translate('userRegisterPRIVACYPOLICYtext7.13') +
                      ' ',
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYmail'),
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYsubtitle8'),
            weight: FontWeight.w800,
            size: 12,
            color: Colors.black,
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
                          .translate('userRegisterPRIVACYPOLICYtext8.1') +
                      ' ',
                ),
                TextSpan(
                  text: WalkLocalizations.of(context)
                      .translate('userRegisterPRIVACYPOLICYpage'),
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 15, bottom: 20),
          child: WalkText(
            text: WalkLocalizations.of(context)
                .translate('userRegisterPRIVACYPOLICYtext8.2'),
            weight: FontWeight.w400,
            size: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

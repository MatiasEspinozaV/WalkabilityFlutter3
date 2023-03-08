import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:walkability/util/localization.dart';

final check = Icon(Icons.check, color: Color(0xFF20CE88));
final cross = Icon(Icons.clear_rounded, color: Color(0xFF8A12B1));

class WalkButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;
  final FontWeight weight;

  WalkButton({
    Key key,
    @required this.text,
    this.color,
    @required this.onPressed,
    this.weight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: WalkText(
        text: text,
        color: color == null ? Color(0xFF20CE88) : color,
        weight: weight,
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: color == null ? Color(0xFF20CE88) : color, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}

class WalkText extends StatelessWidget {
  final double size;
  final FontWeight weight;
  final Color color;
  final String text;
  final TextAlign align;

  WalkText({
    Key key,
    @required this.text,
    this.size = 16,
    this.weight,
    this.color = Colors.white,
    this.align = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.raleway(
        fontWeight: weight,
        fontSize: size,
        color: color,
      ),
      textAlign: align,
    );
  }
}

class WalkForm extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function onChanged;
  final Function validator;
  final Function onSaved;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final Color color;

  WalkForm({
    Key key,
    this.controller,
    this.keyboardType,
    @required this.text,
    this.icon,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.obscureText = false,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: GoogleFonts.raleway(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: color,
      ),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(fontSize: 14.0, color: color),
        suffixIcon: icon,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 1.0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 1.0,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
    );
  }
}

class WalkSlider extends StatelessWidget {
  final double min;
  final double max;
  final List<String> labels;
  final double value;
  final Function onChanged;

  WalkSlider({
    Key key,
    @required this.min,
    @required this.max,
    @required this.labels,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        activeLabelStyle: TextStyle(
          color: Color(0xFF001968),
          fontSize: 12,
          fontStyle: FontStyle.normal,
        ),
        inactiveLabelStyle: TextStyle(
          color: Color(0xFF001968),
          fontSize: 12,
          fontStyle: FontStyle.normal,
        ),
        thumbColor: Color(0xFF20CE88),
        thumbRadius: 11.5,
        activeTrackColor: Color(0xFF001968),
        inactiveTrackColor: Color(0xFF99A3C3),
        activeTrackHeight: 6,
        inactiveTrackHeight: 6,
      ),
      child: SfSlider(
        min: min,
        max: max,
        interval: 1,
        stepSize: 1,
        showLabels: true,
        value: value,
        labelFormatterCallback: (dynamic actualValue, String formattedText) {
          return labels[actualValue.round()];
        },
        onChanged: onChanged,
      ),
    );
  }
}

void showConnectivity(context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  var hasInternet = connectivityResult != ConnectivityResult.none;
  if (!hasInternet) {
    InternetModal.showTopSnackBar(context);
  }
}

class InternetModal {
  static void showTopSnackBar(
    BuildContext context,
  ) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.23,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WalkText(
                      text: WalkLocalizations.of(context)
                          .translate('utilCOMPONENTSconnectivityTITLE'),
                      weight: FontWeight.w600,
                      color: Color(0xFF001968),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      child: WalkText(
                        text: WalkLocalizations.of(context)
                            .translate('utilCOMPONENTSconnectivityTEXT'),
                        weight: FontWeight.w400,
                        size: 14,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        height: 42,
                        width: MediaQuery.of(context).size.width / 3.7,
                        child: WalkButton(
                          text: WalkLocalizations.of(context)
                              .translate('utilCOMPONENTSconnectivityBUTTON'),
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            var hasInternet =
                                connectivityResult != ConnectivityResult.none;
                            if (hasInternet) Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WalkInfo with ChangeNotifier {
  String comment = null;
  double latitude;
  double longitude;
  double accuracy;
  String perception;
  List<dynamic> icons = [];
  List<Marker> marker = [];
  List<bool> checked = [];
  bool reportStep = false;
  String city = '';
  String country = '';
  double decision = 0;
  double purpose = 0;
  double groupSize = 0;
  double familiarity = 0;
  String countryCode = '';

  set setDecision(double nombre) {
    this.decision = nombre;
    notifyListeners();
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walkability/providers/walkInfo.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;

/* Function to create a new user */
Future<bool> createUser(username, email, password, cellphone, walkgroup) async {
  Map data = {
    "username": username,
    "email": email,
    "password": password,
    "celphone": cellphone == '' ? null : cellphone,
    "walkgroup": walkgroup
  };

  var body = json.encode(data);
  var response = await http.post(
    Uri.parse('http://walkabilityrest.cedeus.cl/user/'),
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception('Failed to create user.');
  }
}

/* Function to create a user context for an existing user.
The user id might not be on phone's storage when it is just created, 
it can be changed on createUser function */
Future<bool> createUserContext(gender, ability, age) async {
  final storage = new FlutterSecureStorage();
  String username = await storage.read(key: 'username');
  String token = await storage.read(key: "token");
  final user = await http.get(
    Uri.parse('http://walkabilityrest.cedeus.cl/user/?username=' + username),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    },
  );
  if (user.statusCode == 200) {
    var userInfo = json.decode(user.body);
    Map data = {
      "gender": gender,
      "ability": ability,
      "age": age,
      "user": userInfo[0]['id'],
    };
    await storage.write(key: "userID", value: userInfo[0]['id'].toString());
    var response = await http.post(
      Uri.parse('http://walkabilityrest.cedeus.cl/usercontext/'),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      var userContext = json.decode(response.body)["id"].toString();
      await storage.write(key: "userContext", value: userContext);
      return true;
    } else {
      throw Exception('Failed to create user context.');
    }
  } else {
    throw Exception('Failed to find the user');
  }
}

/* Function to validate user and login, the token and username are saved on phone's storage */
Future<Object> authLog(username, password) async {
  final storage = new FlutterSecureStorage();
  Map<String, String> body = {
    "username": username.text,
    "password": password.text,
  };
  var response = await http.post(
    Uri.parse('http://walkabilityrest.cedeus.cl/login/'),
    headers: {
      "Content-type": "application/json",
    },
    body: json.encode(body),
  );
  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> output = json.decode(response.body);
    await storage.write(key: "token", value: output['access']);
    await storage.write(key: "refresh", value: output['refresh']);
    await storage.write(key: "username", value: username.text);
    await storage.write(key: "userID", value: output['user']['id'].toString());
    await storage.write(
        key: "userContext", value: output['last_usercontext'].toString());
    await storage.write(
        key: "walkContext", value: output['last_walkcontext'].toString());
    return (output['last_usercontext'] != null &&
        output['last_walkcontext'] != null);
  }
  return null;
}

Future<void> logout() async {
  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: "token");
  String refresh = await storage.read(key: "refresh");
  var response = await http.post(
      Uri.parse('http://walkabilityrest.cedeus.cl/api/logout/'),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode({"refresh": refresh}));
  print(response.body);
}

Future<bool> checkToken() async {
  final storage = new FlutterSecureStorage();
  String refresh = await storage.read(key: "refresh");
  var response = await http.post(
    Uri.parse('http://walkabilityrest.cedeus.cl/api/token/refresh/'),
    headers: {"Content-Type": "application/json"},
    body: json.encode({"refresh": refresh}),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> output = json.decode(response.body);
    await storage.write(key: "token", value: output['access']);
    await storage.write(key: "refresh", value: output['refresh']);
    return true;
  } else {
    await storage.deleteAll();
    return false;
  }
}

/* Function to check if the username on the user register */
Future<bool> checkUser(username) async {
  final response = await http.get(
    Uri.parse('http://walkabilityrest.cedeus.cl/username_check/?username=' +
        username),
  );
  return !(json.decode(response.body)['code'] == 200);
}

/* Function to create walk context, the data required is collected and then sended to the API
Finally the walk context id is saved on phone's storage */
Future<bool> createWalkContext(
    decision, purpose, groupSize, familiarity, city, countryCode) async {
  final storage = new FlutterSecureStorage();
  var userID = await storage.read(key: 'userID');
  var location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  print(location);
  WeatherFactory wf = new WeatherFactory('bd7d3ddfcdeb3b9288bcc3c9d4383dc9');
  var weather =
      await wf.currentWeatherByLocation(location.latitude, location.longitude);
  print(weather.weatherConditionCode);
  var version = await http.get(
    Uri.parse('http://walkabilityrest.cedeus.cl/version/?country=global'),
    headers: {"Content-Type": "application/json"},
  );
  print(json.decode(version.body)[0]['id'].toString());
  var temperature = weather.temperature.celsius.toStringAsFixed(1);
  print(temperature);
  String token = await storage.read(key: "token");
  Map data = {
    "decision": decision,
    "purpose": purpose,
    "group_size": groupSize,
    "familiarity": familiarity,
    "user": userID,
    "latitude_start": num.parse(location.latitude.toStringAsFixed(12)),
    "longitude_start": num.parse(location.longitude.toStringAsFixed(12)),
    "gpsaccuracy_start": num.parse(location.accuracy.toStringAsFixed(12)),
    "version": json.decode(version.body)[0]['id'].toString(),
    "weather_code": weather.weatherConditionCode,
    "weather_codition": weather.weatherMain,
    "weather_text": weather.weatherIcon,
    "temperature": temperature,
    "city": city,
    "countryCode": countryCode
  };
  var response = await http.post(
    Uri.parse('http://walkabilityrest.cedeus.cl/walkcontext/'),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    },
    body: json.encode(data),
  );
  if (response.statusCode == 201) {
    var walkContext = json.decode(response.body)['id'].toString();
    await storage.write(key: 'walkContext', value: walkContext);
    return true;
  } else {
    throw Exception('Failed to create walk context.');
  }
}

/* Function to create a report. After the user sends the report, the function creates the data point.
Then it creates the datavalues with the data ID */
Future<http.Response> createData(walkInfo) async {
  final storage = new FlutterSecureStorage();
  var userID = await storage.read(key: 'userID');
  var userContext = await storage.read(key: 'userContext');
  var walkContext = await storage.read(key: 'walkContext');
  print(walkInfo.city);
  print(userContext);
  String token = await storage.read(key: "token");
  Map body = {
    "latitude": num.parse(walkInfo.latitude.toStringAsFixed(12)),
    "longitude": num.parse(walkInfo.longitude.toStringAsFixed(12)),
    "comments": walkInfo.comment,
    "gpsaccuracy": num.parse(walkInfo.accuracy.toStringAsFixed(12)),
    "perception": walkInfo.perception,
    "user": userID,
    "context": userContext,
    "walk_context": walkContext,
    "version": null,
  };
  var response = await http.post(
    Uri.parse('http://walkabilityrest.cedeus.cl/data/'),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    },
    body: json.encode(body),
  );
  if (response.statusCode == 200 || response.statusCode == 201) {
    for (var i = 0; i < walkInfo.icons.length; i++) {
      Map button = {
        "data": json.decode(response.body)['id'],
        "value": walkInfo.icons[i],
      };
      await http.post(
        Uri.parse('http://walkabilityrest.cedeus.cl/datavalue/'),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode(button),
      );
    }
    var customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 30)), 'assets/markers/report.png');
    walkInfo.marker.add(
      Marker(
        markerId: MarkerId((walkInfo.marker.length + 1).toString()),
        position: LatLng(walkInfo.latitude, walkInfo.longitude),
        zIndex: 2,
        icon: customIcon,
        anchor: Offset(0.5, 0.5),
      ),
    );
    walkInfo.perception = null;
    walkInfo.icons = [];
    walkInfo.comment = null;
    print("Comentario Post Back:");
    print(walkInfo.comment);
  }
  return response;
}

/* Function to get the last walk context data when the user starts a new walk */
Future<void> getWalkContext(walkInfo) async {
  final storage = new FlutterSecureStorage();
  String username = await storage.read(key: 'username');
  String token = await storage.read(key: "token");
  var response = await http.get(
    Uri.parse(
        'http://walkabilityrest.cedeus.cl/walkcontext?username=' + username),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    },
  );
  var walkContext = await json.decode(response.body);
  var lastWalkContext = await walkContext[walkContext.length - 1];
  walkInfo.decision = ['necessity', 'choice']
      .indexWhere((state) => state == lastWalkContext['decision'])
      .toDouble();
  walkInfo.purpose = ['transport', 'leisure']
      .indexWhere((state) => state == lastWalkContext['purpose'])
      .toDouble();
  walkInfo.groupSize = ['alone', 'with_a_dependent', 'group']
      .indexWhere((state) => state == lastWalkContext['group_size'])
      .toDouble();
  walkInfo.familiarity = ['local', 'visitor']
      .indexWhere((state) => state == lastWalkContext['familiarity'])
      .toDouble();
}

/* Function to update the walk context after the user stops the walk */
Future<http.Response> updateWalkContext(location) async {
  final storage = new FlutterSecureStorage();
  var walkContext = await storage.read(key: 'walkContext');
  String token = await storage.read(key: "token");
  Map body = {
    "latitude_end": num.parse(location.latitude.toStringAsFixed(12)),
    "longitude_end": num.parse(location.longitude.toStringAsFixed(12)),
    "gpsaccuracy_end": num.parse(location.accuracy.toStringAsFixed(12)),
  };
  var response = await http.put(
    Uri.parse(
        'http://walkabilityrest.cedeus.cl/walkcontext/' + walkContext + '/'),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    },
    body: json.encode(body),
  );
  return response;
}

Future<Object> getUserContext() async {
  final storage = new FlutterSecureStorage();
  var userID = await storage.read(key: 'userID');
  String token = await storage.read(key: "token");
  var response = await http.get(
    Uri.parse('http://walkabilityrest.cedeus.cl/usercontext?user=' + userID),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    },
  );
  if (response.statusCode == 200) {
    var userContext = await json.decode(response.body);
    var lastContext = userContext.length - 1;
    return userContext[lastContext];
  }
  return {};
}

/* Function to get all user's markers and place them on the map */
Future<List<Marker>> loadMarker() async {
  List<Marker> markerList = [];
  final storage = new FlutterSecureStorage();
  String username = await storage.read(key: 'username');
  String token = await storage.read(key: "token");
  var response = await http.get(
    Uri.parse('http://walkabilityrest.cedeus.cl/data/?username=' + username),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    },
  );
  if (response.statusCode == 200 || response.statusCode == 201) {
    var markers = json.decode(response.body);
    print(markers);
    var customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 30)), 'assets/markers/report.png');
    for (var i = 0; i < markers.length; i++) {
      print(markers[i]['latitude']);
      var marker = Marker(
        markerId: MarkerId('prev-' + (markerList.length + 1).toString()),
        position: LatLng(double.parse(markers[i]['latitude']),
            double.parse(markers[i]['longitude'])),
        zIndex: 2,
        icon: customIcon,
        anchor: Offset(0.5, 0.5),
      );
      markerList.add(marker);
    }
  }
  print(markerList);
  return markerList;
}

/* Function to get user data: email, phone number, walkgroup */
Future<Object> getUserInfo() async {
  final storage = new FlutterSecureStorage();
  String username = await storage.read(key: 'username');
  String token = await storage.read(key: 'token');
  final user = await http.get(
    Uri.parse('http://walkabilityrest.cedeus.cl/user/?username=' + username),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    },
  );
  print(user);
  if (user.statusCode == 200) {
    var userInfo = json.decode(user.body);
    Map data = {
      "username": username,
      "email": userInfo[0]['email'],
      "phone": userInfo[0]['celphone'],
      "walkgroup": userInfo[0]['walkgroup'],
    };
    return data;
  }
  return {};
}

Future<bool> updateUserInfo(email, password, phone) async {
  final storage = new FlutterSecureStorage();
  var username = await storage.read(key: 'username');
  var userID = await storage.read(key: 'userID');
  String token = await storage.read(key: "token");
  print(email.text);
  print(phone.text);
  Map body = {
    "id": userID,
    "username": username,
    "email": email.text,
    "password": password.text,
    "celphone": phone.text == "" ? null : phone.text,
  };
  print(body);
  var response = await http.put(
    Uri.parse('http://walkabilityrest.cedeus.cl/user/' + userID + "/"),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    },
    body: json.encode(body),
  );
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    print("Entre");
    return true;
  }
  return false;
}

Future<bool> updatePassword(password, newPassword) async {
  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: "token");
  print(token);
  print(password.text);
  print(newPassword.text);
  var response = await http.put(
    Uri.parse('http://walkabilityrest.cedeus.cl/password/change-password/'),
    headers: {'Authorization': 'Bearer ' + token},
    body: {"old_password": password.text, "new_password": newPassword.text},
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<Object> passwordRecovery(username) async {
  var response = await http.post(
    Uri.parse('http://walkabilityrest.cedeus.cl/req-reset-password/'),
    body: {
      "username": username,
      "redirect_url": "http://walkability.walk21.com/passwordRecovery",
    },
  );
  print(json.decode(response.body));
  return response.body;
}

Future<bool> disableWalkEdit() async {
  final storage = new FlutterSecureStorage();
  var walkId = await storage.read(key: 'walkContext');
  var response = await http.get(
    Uri.parse(
        'http://walkabilityrest.cedeus.cl/disable_auto_add/?walk=' + walkId),
  );
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

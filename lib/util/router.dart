import 'package:flutter/material.dart';
import 'package:walkability/ui/initialSettings/settingStart.dart';
import 'package:walkability/ui/pwdRecovery/recoveryStart.dart';
import 'package:walkability/ui/userRegister/signUpStart.dart';
import 'package:walkability/ui/mapScreen/map.dart';
import 'package:walkability/ui/logIn.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final GlobalKey<ScaffoldState> key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => LogIn(),
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => SettingStart(),
        );
      case '/signUp':
        return MaterialPageRoute(
          builder: (_) => SignUpStart(
            signUpKey: key,
          ),
        );
      case '/map':
        return MaterialPageRoute(
          builder: (_) => MapScreen(
            color: Colors.redAccent,
            homeScreenKey: key,
          ),
        );
      case '/recovery':
        return MaterialPageRoute(
          builder: (_) => Recovery(
            recoveryKey: key,
          ),
        );
      default:
        return null;
    }
  }
}

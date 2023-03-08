import 'package:flutter/material.dart';
import 'package:walkability/providers/walkInfo.dart';
import 'package:walkability/util/requests.dart';
import 'package:walkability/util/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:walkability/ui/logIn.dart';
import 'package:walkability/ui/mapScreen/map.dart';
import 'package:provider/provider.dart';

import 'util/localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: "token");
  //chequear el token
  bool response = await checkToken();
  runApp(MyApp(response: response));
}

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
    this.response,
  }) : super(key: key);

  final response;
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    print(response);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WalkInfo>(create: (_) => WalkInfo()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        supportedLocales: [
          Locale('en', ''),
          Locale('de', ''),
          Locale('es', ''),
        ],
        localizationsDelegates: [
          WalkLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: response ? MapScreen() : LogIn(),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:walkability/ui/logIn.dart';
import 'package:walkability/ui/menuItems/about.dart';
import 'package:walkability/ui/menuItems/account.dart';
import 'package:walkability/ui/menuItems/setting.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/util/localization.dart';
import 'package:walkability/util/requests.dart';

class Menu extends StatelessWidget {
  Menu({Key key}) : super(key: key);
  final storage = new FlutterSecureStorage();

  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF001968),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  child: DrawerHeader(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/walky.svg", height: 35),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: WalkText(
                            text: "Walkability",
                            size: 30,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
                ListTile(
                  focusColor: Color(0xFF485B97),
                  hoverColor: Color(0xFF485B97),
                  iconColor: Color(0xFF20CE88),
                  leading: Icon(Icons.person_outline),
                  title: WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('mapScreenMENUname1'),
                    color: Color(0xFF20CE88),
                    size: 14,
                  ),
                  onTap: () async {
                    var userInfo = await getUserInfo();
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Account(user: userInfo),
                      ),
                    );
                  },
                ),
                ListTile(
                  focusColor: Color(0xFF485B97),
                  hoverColor: Color(0xFF485B97),
                  iconColor: Color(0xFF20CE88),
                  leading: Icon(Icons.tune_rounded),
                  title: WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('mapScreenMENUname2'),
                    color: Color(0xFF20CE88),
                    size: 14,
                  ),
                  onTap: () async {
                    var userContext = await getUserContext();
                    print(userContext);
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Setting(userContext),
                      ),
                    );
                  },
                ),
                ListTile(
                  focusColor: Color(0xFF485B97),
                  hoverColor: Color(0xFF485B97),
                  iconColor: Color(0xFF20CE88),
                  leading: Icon(Icons.person_outline),
                  contentPadding: EdgeInsets.only(top: 20, left: 15),
                  title: WalkText(
                    text:
                  WalkLocalizations.of(context)
                        .translate('mapScreenMENUname3'),
                    color: Color(0xFF20CE88),
                    size: 14,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => About(),
                      ),
                    );
                  },
                ),
                ListTile(
                  focusColor: Color(0xFF485B97),
                  hoverColor: Color(0xFF485B97),
                  iconColor: Color(0xFF20CE88),
                  leading: Icon(Icons.logout),
                  title: WalkText(
                    text:
                  WalkLocalizations.of(context)
                        .translate('mapScreenMENUname4'),
                    color: Color(0xFF20CE88),
                    size: 14,
                  ),
                  onTap: () async {
                    await logout();
                    await storage.deleteAll();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext ctx) => LogIn(),
                      ),
                  );
                },
              ),
              ],
            ),
          ),
          SizedBox(
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset("assets/icons/alstom.svg"),
                SvgPicture.asset("assets/icons/walk21.svg"),
                SvgPicture.asset("assets/icons/cedeus.svg"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:walkability/util/components.dart';
import 'package:walkability/util/localization.dart';

class About extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WalkText(
            text:
                WalkLocalizations.of(context).translate('mapScreenMENUname3')),
        backgroundColor: Color(0xFF001968),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalkText(
              text: WalkLocalizations.of(context)
                  .translate('menuItemsABOUTtext1'),
              color: Colors.black,
            ),
            WalkText(
              text: WalkLocalizations.of(context)
                  .translate('menuItemsABOUTtext2'),
              color: Colors.black,
            ),
            WalkText(
              text: WalkLocalizations.of(context)
                  .translate('menuItemsABOUTtext3'),
              color: Colors.black,
            ),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                {
                  var version = '';
                  if (snapshot.data != null) {
                    version = snapshot.data.version;
                  }
                  print(version);
                  return WalkText(
                    text: WalkLocalizations.of(context)
                            .translate('menuItemsABOUTtext4') +
                        ': $version',
                    color: Colors.black,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:walkability/util/localization.dart';
import 'package:walkability/providers/walkInfo.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/ui/mapScreen/comment.dart';
import 'package:walkability/util/requests.dart';

class ButtonData {
  ButtonData(this.path, this.title, this.id);
  final String path;
  final String title;
  final int id;
}

class Report extends StatefulWidget {
  Report({Key key}) : super(key: key);

  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  var walkFlag = false;
  List<ButtonData> icons = [];
  GlobalKey<ScaffoldState> secondScreenKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final walkInfo = Provider.of<WalkInfo>(context);
    if (walkInfo.checked.length <= 0) {
      walkInfo.checked = List<bool>.filled(icons.length, false);
    }
    return BottomSheet(
      backgroundColor: Colors.transparent,
      onClosing: () {},
      builder: (BuildContext context) => AnimatedContainer(
        margin: EdgeInsets.only(right: 16, left: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: AnimatedCrossFade(
            firstChild: moodReaction(),
            secondChild: iconReaction(),
            crossFadeState: walkInfo.reportStep
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 400)),
        duration: Duration(milliseconds: 400),
      ),
    );
  }

  Widget moodReaction() {
    final List<ButtonData> _green = [
      ButtonData('assets/icons/Green/1.svg', 'mapScreenREPORTgreen1', 1),
      ButtonData('assets/icons/Green/2.svg', 'mapScreenREPORTgreen2', 2),
      ButtonData('assets/icons/Green/3.svg', 'mapScreenREPORTgreen3', 3),
      ButtonData('assets/icons/Green/4.svg', 'mapScreenREPORTgreen4', 4),
      ButtonData('assets/icons/Green/5.svg', 'mapScreenREPORTgreen5', 5),
      ButtonData('assets/icons/Green/6.svg', 'mapScreenREPORTgreen6', 6),
      ButtonData('assets/icons/Green/7.svg', 'mapScreenREPORTgreen7', 7),
      ButtonData('assets/icons/Green/8.svg', 'mapScreenREPORTgreen8', 8),
      ButtonData('assets/icons/Green/9.svg', 'mapScreenREPORTgreen9', 9),
      ButtonData('assets/icons/Green/10.svg', 'mapScreenREPORTgreen10', 10),
      ButtonData('assets/icons/Green/11.svg', 'mapScreenREPORTgreen11', 11),
      ButtonData('assets/icons/Green/12.svg', 'mapScreenREPORTgreen12', 12)
    ];

    final List<ButtonData> _yellow = [
      ButtonData('assets/icons/Yellow/1.svg', 'mapScreenREPORTyellow1', 13),
      ButtonData('assets/icons/Yellow/2.svg', 'mapScreenREPORTyellow2', 14),
      ButtonData('assets/icons/Yellow/3.svg', 'mapScreenREPORTyellow3', 15),
      ButtonData('assets/icons/Yellow/4.svg', 'mapScreenREPORTyellow4', 16),
      ButtonData('assets/icons/Yellow/5.svg', 'mapScreenREPORTyellow5', 17),
      ButtonData('assets/icons/Yellow/6.svg', 'mapScreenREPORTyellow6', 18),
      ButtonData('assets/icons/Yellow/7.svg', 'mapScreenREPORTyellow7', 19),
      ButtonData('assets/icons/Yellow/8.svg', 'mapScreenREPORTyellow8', 20),
      ButtonData('assets/icons/Yellow/9.svg', 'mapScreenREPORTyellow9', 21),
      ButtonData('assets/icons/Yellow/10.svg', 'mapScreenREPORTyellow10', 22),
      ButtonData('assets/icons/Yellow/11.svg', 'mapScreenREPORTyellow11', 23),
      ButtonData('assets/icons/Yellow/12.svg', 'mapScreenREPORTyellow12', 24)
    ];

    final List<ButtonData> _red = [
      ButtonData('assets/icons/Red/1.svg', 'mapScreenREPORTred1', 25),
      ButtonData('assets/icons/Red/2.svg', 'mapScreenREPORTred2', 26),
      ButtonData('assets/icons/Red/3.svg', 'mapScreenREPORTred3', 27),
      ButtonData('assets/icons/Red/4.svg', 'mapScreenREPORTred4', 28),
      ButtonData('assets/icons/Red/5.svg', 'mapScreenREPORTred5', 29),
      ButtonData('assets/icons/Red/6.svg', 'mapScreenREPORTred6', 30),
      ButtonData('assets/icons/Red/7.svg', 'mapScreenREPORTred7', 31),
      ButtonData('assets/icons/Red/8.svg', 'mapScreenREPORTred8', 32),
      ButtonData('assets/icons/Red/9.svg', 'mapScreenREPORTred9', 33),
      ButtonData('assets/icons/Red/10.svg', 'mapScreenREPORTred10', 34),
      ButtonData('assets/icons/Red/11.svg', 'mapScreenREPORTred11', 35),
      ButtonData('assets/icons/Red/12.svg', 'mapScreenREPORTred12', 36)
    ];
    final walkInfo = Provider.of<WalkInfo>(context);
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      padding: EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: WalkText(
                text: WalkLocalizations.of(context)
                    .translate('mapScreenREPORTtitle'),
                weight: FontWeight.w600,
                size: 18,
                color: Color(0xFF001968),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    setState(
                      () => {
                        walkInfo.reportStep = true,
                        icons = List.from(_green),
                      },
                    );
                    var location = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.best);
                    walkInfo.perception = 'green';
                    walkInfo.icons = [];
                    walkInfo.latitude = location.latitude;
                    walkInfo.longitude = location.longitude;
                    walkInfo.accuracy = location.accuracy;
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFFFFFF)),
                  ),
                  child: SvgPicture.asset('assets/icons/good.svg'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    setState(
                      () => {
                        walkInfo.reportStep = true,
                        icons = List.from(_yellow),
                      },
                    );
                    var location = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.best);
                    walkInfo.perception = 'yellow';
                    walkInfo.icons = [];
                    walkInfo.latitude = location.latitude;
                    walkInfo.longitude = location.longitude;
                    walkInfo.accuracy = location.accuracy;
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFFFFFF)),
                  ),
                  child: SvgPicture.asset('assets/icons/poor.svg'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    setState(
                      () => {
                        walkInfo.reportStep = true,
                        icons = List.from(_red),
                      },
                    );
                    var location = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.best);
                    walkInfo.perception = 'red';
                    walkInfo.icons = [];
                    walkInfo.latitude = location.latitude;
                    walkInfo.longitude = location.longitude;
                    walkInfo.accuracy = location.accuracy;
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFFFFFF)),
                  ),
                  child: SvgPicture.asset('assets/icons/bad.svg'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconReaction() {
    final walkInfo = Provider.of<WalkInfo>(context);
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon:
                          Icon(Icons.arrow_back_ios, color: Color(0xFF20CE88)),
                      iconSize: 18,
                      onPressed: () => {
                        setState(
                          () => {
                            walkInfo.reportStep = false,
                            icons = [],
                          },
                        )
                      },
                    ),
                    WalkText(
                      text: WalkLocalizations.of(context)
                          .translate('mapScreenREPORTtitle'),
                      weight: FontWeight.w600,
                      size: 18,
                      color: Color(0xFF001968),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: GestureDetector(
                    child: SvgPicture.asset('assets/icons/message.svg',
                        color: walkInfo.comment == null
                            ? Color(0xFF8912B1)
                            : Color(0xFF20CE88)),
                    onTap: () {
                      Comment.showComment(context);
                    }),
              ),
            ],
          ),
          GridView.builder(
            padding: EdgeInsets.only(top: 15, bottom: 0),
            itemCount: icons.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.6,
              crossAxisCount: 4,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  this.setState(() {
                    walkInfo.checked[index] = !walkInfo.checked[index];
                    print(walkInfo.checked[index]);
                    if (walkInfo.checked[index] &&
                        !walkInfo.icons.contains(icons[index].id)) {
                      walkInfo.icons.add(icons[index].id);
                    } else {
                      walkInfo.icons.remove(icons[index].id);
                    }
                  });
                },
                child: Card(
                  elevation: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      walkInfo.checked[index]
                          ? SvgPicture.asset(
                              icons[index].path,
                              width: MediaQuery.of(context).size.width / 8,
                              height: MediaQuery.of(context).size.width / 8,
                            )
                          : Opacity(
                              opacity: 0.3,
                              child: SvgPicture.asset(
                                icons[index].path,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                colorBlendMode: BlendMode.color,
                                color: Colors.white,
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: WalkText(
                          text: WalkLocalizations.of(context)
                              .translate(icons[index].title),
                          color: Color(0xFF000000),
                          size: 10,
                          align: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child: SizedBox(
                height: 42,
                width: MediaQuery.of(context).size.width,
                child: WalkButton(
                  onPressed: () {
                    walkInfo.checked = List<bool>.filled(12, false);
                    walkInfo.reportStep = false;
                    createData(walkInfo);
                    print("Comentario Post Create Data");
                  },
                  text: WalkLocalizations.of(context)
                      .translate('mapScreenREPORTbutton'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

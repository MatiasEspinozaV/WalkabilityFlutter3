import 'package:connectivity/connectivity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:walkability/util/localization.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:walkability/providers/walkInfo.dart';
import 'package:walkability/ui/mapScreen/menu.dart';
import 'package:walkability/ui/mapScreen/report.dart';
import 'package:walkability/ui/mapScreen/walk.dart';
import 'package:walkability/util/components.dart';
import 'package:walkability/util/requests.dart';

class MapScreen extends StatefulWidget {
  MapScreen({
    Key key,
    this.color,
    this.homeScreenKey,
  }) : super(key: key);

  final Color color;
  final GlobalKey<ScaffoldState> homeScreenKey;
  _MapState createState() => _MapState();
  static showComment(BuildContext context) async {
    return _MapState()._showWarning(context);
  }
}

class _MapState extends State<MapScreen> with WidgetsBindingObserver {
  StreamSubscription _locationSubscription;
  Marker marker;
  List<Marker> markers = [];
  bool markersLoaded = false;
  Circle circle;
  GoogleMapController _controller;
  BitmapDescriptor customIcon;
  var walkFlag = false;
  var directory = '';
  var position;
  List<bool> checked = [];
  List<ButtonData> icons = [];
  WeatherFactory wf = new WeatherFactory('bd7d3ddfcdeb3b9288bcc3c9d4383dc9');
  final storage = new FlutterSecureStorage();
  static CameraPosition _initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  var subscription;
  var location;
  Duration duration = Duration();
  Timer timer;
  List<Placemark> placemarks;
  Weather actualWeather;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Geolocator.checkPermission().then(
      (value) => {
        print(value.toString()),
        if (value.toString() == 'LocationPermission.whileInUse')
          _getCurrentLocation()
        else
          _showWarning(context)
      },
    );
    showConnectivity(context);
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print(result);
      var hasInternet = result != ConnectivityResult.none;
      if (!hasInternet) {
        InternetModal.showTopSnackBar(context);
      }
    });
  }

  Future<bool> _onWillPop(walkInfo) async {
    if (!walkFlag || !walkInfo.reportStep) {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text(WalkLocalizations.of(context)
                  .translate('mapScreenMAPpopupTITLE')),
              content: new Text(WalkLocalizations.of(context)
                  .translate('mapScreenMAPpopupTEXT')),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text(WalkLocalizations.of(context)
                      .translate('mapScreenMAPpopupNO')),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text(WalkLocalizations.of(context)
                      .translate('mapScreenMAPpopupYES')),
                ),
              ],
            ),
          )) ??
          false;
    } else {
      setState(
        () => {
          walkInfo.reportStep = false,
          walkInfo.perception = null,
          walkInfo.checked = List<bool>.filled(12, false),
        },
      );
      return false;
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print(AppLifecycleState.values);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        _initMapStyle("assets/mapStyle.json");
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        var location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        await updateWalkContext(location);
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        disableWalkEdit();
        print('appLifeCycleState detached');
        break;
    }
  }

  Future<void> _initMapStyle(String path) async {
    var _mapStyle = await rootBundle.loadString(path);
    await _controller.setMapStyle(_mapStyle);
  }

  void _getCurrentLocation() async {
    try {
      var location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      print(placemarks.first.country);
      print(placemarks.first.isoCountryCode);
      updateMarker(location);

      markers = await loadMarker();
      final GoogleMapController controller = _controller;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          location.latitude,
          location.longitude,
        ),
        zoom: 16.4746,
      )));
      setState(() {
        _initialLocation = CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 16.4746,
        );
      });
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        debugPrint("Permission Denied");
      }
    }
  }

  void _stopWalk() async {
    setState(
      () => {
        timer.cancel(),
        duration = Duration(),
        walkFlag = false,
      },
    );
    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    await updateWalkContext(location);
    await disableWalkEdit();
    _locationSubscription.cancel();
  }

  void dispose() async {
    subscription.cancel();
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walkInfo = Provider.of<WalkInfo>(context);
    return WillPopScope(
      onWillPop: () => _onWillPop(walkInfo),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Color(0xFF20CE88)),
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              child: GoogleMap(
                mapType: MapType.normal,
                tiltGesturesEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: true,
                myLocationButtonEnabled: false,
                initialCameraPosition: _initialLocation,
                markers: Set<Marker>.of(marker != null
                    ? [marker] + walkInfo.marker + markers
                    : walkInfo.marker),
                circles: Set.of((circle != null ? [circle] : [])),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  _initMapStyle("assets/mapStyle.json");
                  setState(() {});
                },
              ),
            ),
            walkFlag
                ? Container()
                : Positioned(
                    bottom: 0,
                    child: walk(),
                  ),
            Positioned(
              top: 0,
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF001968).withOpacity(0.0),
                      Color(0xFF001968)
                    ], begin: Alignment.bottomCenter, end: Alignment.center),
                  ),
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                  )),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.055,
                  right: MediaQuery.of(context).size.width * 0.07,
                ),
                child: walkFlag ? walkTime() : summary(),
              ),
            ),
            Positioned(
              bottom: 0,
              child: walkFlag ? Report() : Container(),
            ),
          ],
        ),
        drawer: Menu(),
        floatingActionButton: walkFlag
            ? (walkInfo.reportStep
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(bottom: 130),
                    child: FloatingActionButton(
                      backgroundColor: Color(0xFFFF0B0B),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Icon(Icons.circle, size: 30),
                          Icon(
                            Icons.close_rounded,
                            color: Color(0xFFFF0B0B),
                            size: 16,
                          ),
                        ],
                      ),
                      onPressed: () {
                        _stopWalk();
                      },
                    ),
                  ))
            : Padding(
                padding: EdgeInsets.only(bottom: 70),
                child: FloatingActionButton(
                  child: Icon(Icons.my_location),
                  backgroundColor: Color(0xFF8912B1),
                  onPressed: () {
                    _getCurrentLocation();
                  },
                ),
              ),
      ),
    );
  }

  void updateMarker(Position newLocalData) async {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);

    if (actualWeather == null) {
      actualWeather = await wf.currentWeatherByLocation(
          newLocalData.latitude, newLocalData.longitude);
    }

    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 30)), 'assets/markers/location.png');
    this.setState(() {
      marker = Marker(
        markerId: MarkerId("home"),
        position: latlng,
        zIndex: 2,
        icon: customIcon,
        rotation: newLocalData.heading,
        anchor: Offset(0.5, 0.5),
      );
      circle = Circle(
          circleId: CircleId("radio"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void startWalk() async {
    try {
      location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      updateMarker(location);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          Geolocator.getPositionStream().listen((Position newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  zoom: 19.151926040649414)));
          updateMarker(newLocalData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        debugPrint("Permission Denied");
      }
    }
  }

  void addTime() {
    final addSeconds = 1;
    final isRunning = timer == null ? false : timer.isActive;
    if (isRunning) {
      setState(() {
        final seconds = duration.inSeconds + addSeconds;
        duration = Duration(seconds: seconds);
      });
    }
  }

  Widget walkTime() {
    final walkInfo = Provider.of<WalkInfo>(context);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final country = placemarks.first.country;
    final city = placemarks.first.locality;
    final countryCode = placemarks.first.isoCountryCode;
    walkInfo.city = city;
    walkInfo.countryCode = countryCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        WalkText(
          text: WalkLocalizations.of(context).translate('mapScreenMAPwalktime'),
          weight: FontWeight.w300,
          size: 18,
        ),
        WalkText(
          text: '$hours:$minutes:$seconds',
          weight: FontWeight.w600,
          size: 26,
        ),
        WalkText(
          text: '$city, $country',
          weight: FontWeight.w700,
          size: 10,
        ),
      ],
    );
  }

  Widget summary() {
    final walkInfo = Provider.of<WalkInfo>(context);
    var weatherName, weatherIcon;
    if (actualWeather != null) {
      weatherName = actualWeather.weatherMain;
      weatherIcon = actualWeather.weatherIcon;
    }
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: weatherIcon == null
                ? Container()
                : Image.network(
                    'http://openweathermap.org/img/w/${weatherIcon}.png',
                    color: Colors.white,
                    height: 30,
                  ),
          ),
          WalkText(
            text: weatherName == null ? '' : weatherName.toString(),
            size: 12,
            weight: FontWeight.w600,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              width: 0.5,
              height: 22.0,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ),
          ),
          /*Padding(
            padding: EdgeInsets.only(right: 10),
            child: SvgPicture.asset('assets/icons/distance.svg'),
          ),
          WalkText(
            text: '10 Km',
            size: 12,
            weight: FontWeight.w600,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              width: 0.5,
              height: 22.0,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ),
          ),*/
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: SvgPicture.asset('assets/icons/report.svg'),
          ),
          WalkText(
            text: (markers.length + walkInfo.marker.length).toString(),
            size: 12,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget walk() {
    final walkInfo = Provider.of<WalkInfo>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF001968).withOpacity(0.0), Color(0xFF001968)],
            begin: Alignment.topCenter,
            end: Alignment.center),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 30, bottom: 25, left: 25, right: 25),
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width / 1.15,
          child: SizedBox(
            height: 45,
            child: WalkButton(
              onPressed: () async {
                walkFlag = true;
                await getWalkContext(walkInfo);
                Walk.showWalkContext(context);
                timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
                startWalk();
              },
              text: WalkLocalizations.of(context)
                  .translate('mapScreenMAPstartwalk'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showWarning(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                right: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('mapScreenMAPwarningTITLE'),
                    size: 24,
                    color: Colors.black,
                    align: TextAlign.center,
                  ),
                  WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('mapScreenMAPwarningTEXT1'),
                    size: 14,
                    weight: FontWeight.w400,
                    color: Colors.black,
                    align: TextAlign.center,
                  ),
                  WalkText(
                    text: WalkLocalizations.of(context)
                        .translate('mapScreenMAPwarningTEXT2'),
                    size: 14,
                    weight: FontWeight.w400,
                    color: Colors.black,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: SizedBox(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      child: WalkButton(
                        text: WalkLocalizations.of(context)
                            .translate('mapScreenMAPwarningBUTTON'),
                        onPressed: () async {
                          await Geolocator.requestPermission();
                          Geolocator.checkPermission().then(
                            (value) => {
                              if (value.toString() !=
                                  'LocationPermission.denied')
                                {
                                  _getCurrentLocation(),
                                  Navigator.of(context).pop(),
                                }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

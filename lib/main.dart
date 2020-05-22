import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './appendix.dart';
import './simulate.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
   testDevices: <String>[],
   keywords: <String> ['CPU', 'technology', 'software', 'hardware', 'computer system'],
   designedForFamilies: true,
   gender: MobileAdGender.male,
   birthday: DateTime.now()
 );

 BannerAd _bannerAd;

 BannerAd createBannerAd(){
   return new BannerAd(
     adUnitId: "ca-app-pub-2793138059826858/3949365715",
      size: AdSize.banner,
      targetingInfo: targetInfo,
      listener: (MobileAdEvent event){}
   );
 }

  @override
  void initState(){
    super.initState();
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-2793138059826858~5837162452");
    _bannerAd = createBannerAd()
    ..load()
    ..show();
  }

  @override
  void dispose(){
    _bannerAd ?.dispose();
    super.dispose();
  }

  navigate(String text) {
    if (text == "Learn about CPU")
    //_bannerAd ?.dispose(),
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Appendix()));
    else if (text == "Simulate")
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Simulate()));
           else if (text == "Take a rest~")
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  Widget menu(String text) {
    return GestureDetector(
      child: new Card(
          margin: EdgeInsets.all(0.0),
          child: new Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white54, Colors.lightGreenAccent])),
            width: MediaQuery.of(context).size.width,
            height: 70.0,
            child: new Text(text,
                style: TextStyle(
                  fontSize: 30.0,
                )),
          )),
      onTap: () => {
            navigate(text),
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50.0),
          child: new Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                gradient: new RadialGradient(
                    radius: 3.0,
                    colors: [Colors.white24, Colors.lightBlueAccent[200]])),
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                ),
                new Text(
                  "CPU Anatomy",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            menu("Learn about CPU"),
            new Padding(
              padding: EdgeInsets.all(20.0),
            ),
            menu("Simulate"),
            new Padding(
              padding: EdgeInsets.all(20.0),
            ),
            menu("Take a rest~")
          ],
        ));
  }
}

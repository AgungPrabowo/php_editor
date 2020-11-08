import 'package:easy_web_view/easy_web_view.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Splash());
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WebView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = Container(
        child: Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: CircularProgressIndicator()),
        Text("Loading..")
      ],
    ));

    final _logo = Container(
      width: 150.0,
      height: 150.0,
      child: Image(image: AssetImage("assets/icon/icon.png")),
    );
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_logo, loading],
            ),
          ),
        ),
      ),
    );
  }
}

// id perangkat yang digunakan untuk test admob
const String testDevice = "5ACA2DB358F2857DCCA953A2DD2F1017";

class WebView extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  BannerAd _bannerAd;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: <String>[],
      nonPersonalizedAds: true,
      keywords: <String>['Education']);

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-6902830085354035/8716258308",
        size: AdSize.smartBanner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-6902830085354035~1001419816");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => Scaffold(
              appBar: AppBar(
                title: Text("PHP Editor"),
              ),
              body: Container(
                padding: EdgeInsets.only(bottom: 50),
                child: EasyWebView(
                  src: "https://rextester.com/l/php_online_compiler",
                ),
              ),
            ),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weatherworld/screens/loading_screen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:weatherworld/screens/admob_service.dart';

//void main() => runApp(MyApp());

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseAdMob.instance.initialize(appId: AdMobService().getAdMobAppId());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
    );
  }
}

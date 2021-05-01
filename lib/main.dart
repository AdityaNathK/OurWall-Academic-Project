
import 'package:family/pages/home/signinpage.dart';
import 'package:family/resources/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //================== Orientation Lock Code ==========================//

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    //================== Orientation Lock Code ==========================//

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: AppTheme.mainColor, accentColor: AppTheme.fabColor),
      home: SignIn(),
    );
  }
}

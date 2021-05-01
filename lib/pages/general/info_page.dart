import 'package:family/resources/styling.dart';
import 'package:family/widgets/header_appbar.dart';
import 'package:flutter/material.dart';
class InfoPage extends StatelessWidget {

  final double height = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      headerAppBar(context, titleText: "INFO", removeBackButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(8.0),
//                color: Colors.orange,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text(
                        "LIST OF PACKAGES",style: txtHeadingNormal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "PACKAGE", style: txtCreditsTitle.copyWith(color: AppTheme.mainColor),
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "USAGE",style: txtCreditsTitle.copyWith(color: AppTheme.mainColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "SDK", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "flutter >=2.6.0 <3.0.0",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "firebase_auth", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Firebase Authentication",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "flutter_auth_buttons", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "FB Buttons",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "cloud_firestore", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Firestore Database",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "firebase_storage", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Firebase Storage",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "firebase_helpers", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Firebase Helper Methods",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "firebase_messaging", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Firebase Notifications",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "google_sign_in", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Google Authentication",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "cached_network_image", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Network Image Cache",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "path_provider", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "State Management",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "flutter_staggered_grid_view", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Staggered Grid View",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "curved_navigation_bar", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Curved Bottom Nav Bar",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "image", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Flutter Image Package",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "image_picker", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Flutter Image Picker",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "flutter_svg", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "SVG Image",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "uuid", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Unique Id Generator",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "table_calendar", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Flutter Calendar",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "geolocator", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Geo Locations",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "data_connection_checker", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Check Internet Connection",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "url_launcher", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Open url, Mail, Phone",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:height,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            "intl", style: txtCreditsTitle,
                          ),
                        ),
                        SizedBox(
                          width:height,
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Internationalisation",style: txtCreditsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

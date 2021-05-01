import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/models/usermodel.dart';
import 'package:family/pages/home/signinpage.dart';
import 'package:family/pages/lists/lists_page.dart';
import 'package:family/resources/styling.dart';
import 'package:family/widgets/header_appbar.dart';
import 'package:flutter/material.dart';
import '../calendar/calendar_page.dart';
import 'package:intl/intl.dart';

const double padding = 30;
DateTime now = DateTime.now();
String _dateFormat = DateFormat.yMMMMd().format(now);
String _dayFormat = DateFormat('EEEE').format(now);
var message = '';
var imageToShow = '';

class MyHomePage extends StatefulWidget {
  final String id;

  MyHomePage({this.id});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User user;
  String userName;
  @override
  Widget build(BuildContext context) {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 11) {
        return 'GOOD MORNING';
      }
      if (hour < 15) {
        return 'GOOD AFTERNOON';
      }
      if (hour < 19) {
        return 'GOOD EVENING';
      }
      return 'GOOD NIGHT';
    }
//      if (timeNow <=12) {
//        message = "GOOD MORNING";
//      } else if(timeNow >12 && timeNow <=16){
//        message = "GOOD AFTERNOON";
//      }
//      else if(timeNow >16 && timeNow <=19){
//        message = "GOOD EVENING";
//      }else{
//        message = "GOOD NIGHT";
//      }
    getUser() async {

      DocumentSnapshot doc = await userRef.document(widget.id).get();
      user = User.fromDocument(doc);
      userName = user.displayName;

    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: headerAppBar(context,
            titleText: "Hi ${googleSignIn.currentUser.displayName.toUpperCase()}"),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              ImageSelection(),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    greeting(),
                    style: txtMainTitle.copyWith(color: AppTheme.mainColor),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    "$_dayFormat",
                    style: txtDateNormal,
                  ),
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    "$_dateFormat",
                    style: txtDateNormal,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(05),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            child: Card(
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.all(padding),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.event,
                                      color: AppTheme.mainColor,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                    ),
                                    Text(
                                      "EVENTS",
                                      style: txtNormal,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CalenderDisplay()));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Card(
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.all(padding),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.list,
                                      color: AppTheme.mainColor,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                    ),
                                    Text("LISTS", style: txtNormal)
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSelection extends StatefulWidget {
  @override
  _ImageSelectionState createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/addimage.gif",
                    ),
                    fit: BoxFit.contain)),
          ),
          onTap: () {}),
    );
  }
}

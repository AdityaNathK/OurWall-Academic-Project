import 'package:family/resources/styling.dart';
import 'package:family/widgets/header_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsPage extends StatefulWidget {
  @override
  _CreditsPageState createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {

  String adityaMail = "adityanath.kalla@student.adelaide.edu.au";
  String normanMail = "tianyuan.li@student.adelaide.edu.au";
  String soniaMail = "soniarani@student.adelaide.edu.au";
  String tutorMail = "claudia.szabo@adelaide.edu.au";
  String tutorUrl = "https://www.adelaide.edu.au/directory/claudia.szabo";




  void _launchEmail(String emailId)async{
    var url = "mailto:$emailId?subject=Family Share App";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not send email";
    }
  }

  void _launchUrl(String url)async{
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not open url";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          headerAppBar(context, titleText: "DEVELOPER INFO", removeBackButton: false),
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
                        "APPLICATION DEVELOPERS",style: txtHeadingNormal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            "ADITYA NATH K", style: txtCreditsTitle,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "A1760704",style: txtCreditsTitle,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.mail,color: AppTheme.mainColor,),
                            onPressed: (){
                              _launchEmail(adityaMail);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            "SONIA RANI",style: txtCreditsTitle,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "A1759645",style: txtCreditsTitle,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.mail,color: AppTheme.mainColor,),
                            onPressed: () {
                              _launchEmail(soniaMail);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            "TIANYUAN LI",style: txtCreditsTitle,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "A1775656",style: txtCreditsTitle,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.mail,color: AppTheme.mainColor,),
                            onPressed: () {
                              _launchEmail(normanMail);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
//                color: Colors.orange,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text(
                        "PROJECT SUPERVISOR", style: txtHeadingNormal,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Text(
                                "CLAUDIA SZABO", style: txtCreditsTitle,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.language,color: AppTheme.blueColor,),
                                onPressed: () {
                                      _launchUrl(tutorUrl);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.mail,color: AppTheme.mainColor,),
                                onPressed: () {
                                  _launchEmail(tutorMail);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:0,bottom: 5,right: 15,left: 15),
                        child: Text(
                          "DIRECTOR OF DIGITAL TECHNOLOGIES",style: txtCreditsSubTitle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:0,bottom: 5,right: 15,left: 15),
                        child: Text(
                          "SCHOOL OF COMPUTER SCIENCE",style: txtCreditsSubTitle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:0,bottom: 15,right: 15,left: 15),
                        child: Text(
                          "THE UNIVERSITY OF ADELAIDE",style: txtCreditsSubTitle,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
//                color: Colors.orange,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text(
                        "PROJECT SUBMITTED TO",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/uoa.png",
                            ),
                            fit: BoxFit.contain)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:family/models/eventmodel.dart';
import 'package:family/resources/styling.dart';
import 'package:family/widgets/header_appbar.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: headerAppBar(context,titleText: "Event Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 5),
//                color: Colors.orange,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "TITLE", style: txtHeadingNormal.copyWith(color: AppTheme.mainColor),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ListTile(
                    title: Center(
                      child: Text(
                        event.title,style: txtNormal,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              margin: const EdgeInsets.all(5.0),
//                color: Colors.orange,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "DESCRIPTION",style: txtHeadingNormal.copyWith(color: AppTheme.mainColor),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ListTile(
                    title: Center(
                      child: Text(
                        event.description,style: txtNormal,
                      ),
                    ),
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
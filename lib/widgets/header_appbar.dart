import 'package:family/resources/styling.dart';
import 'package:flutter/material.dart';

AppBar headerAppBar(context, {String titleText, removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton ?false: true ,
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    title: Text(
      titleText,
      style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal),
    ),
    centerTitle: true,
    backgroundColor: AppTheme.mainColor,
    elevation: 0,
    actions: <Widget>[
          ],
  );
}

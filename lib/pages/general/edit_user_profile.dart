import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/models/usermodel.dart';
import 'package:family/pages/home/signinpage.dart';
import 'package:family/resources/styling.dart';
import 'package:family/widgets/header_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({this.currentUserId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioInfoController = TextEditingController();
  bool isLoading = false;
  User user;
  bool _bioValid = true;
  bool _displayNameValid = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  logout() async{
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
  }
  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await userRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    displayNameController.text = user.displayName;
    bioInfoController.text = user.bio;

    setState(() {
      isLoading = false;
    });
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "Display Name",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "UPDATE DISPLAY NAME",
            errorText: _displayNameValid ? null : "Display Name Too Short",
          ),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "Bio Information",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextField(
          controller: bioInfoController,
          decoration: InputDecoration(
            hintText: "Update Bio Info",
            errorText: _bioValid ? null : "Bio Too Long",
          ),
        )
      ],
    );
  }

  updateProfileData() {
    setState(() {
      displayNameController.text.trim().length < 3 ||
              displayNameController.text.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;

      bioInfoController.text.trim().length > 100
          ? _bioValid = false
          : _bioValid = true;
      if (_displayNameValid && _bioValid) {
        userRef.document(widget.currentUserId).updateData({
          'displayName': displayNameController.text,
          'bio': bioInfoController.text,
        });

        SnackBar snackBar = SnackBar(content: Text("PROFILE UPDATED"));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });

    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile(profileId: googleSignIn.currentUser.id,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: headerAppBar(context, titleText: "EDIT PROFILE"),
        body: isLoading
            ? CircularProgressIndicator()
            : ListView(
                children: <Widget>[
                  Container(
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              CachedNetworkImageProvider(user.photoUrl),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            buildDisplayNameField(),
                            buildBioField(),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: AppTheme.mainColor,
                        child: Text(
                          "UPDATE PROFILE",
                          style: txtCreditsTitle.copyWith(color: AppTheme.whiteColor),
                        ),
                        onPressed: updateProfileData,
                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(16.0),
//                        child: RaisedButton(
//                          color: Colors.red,
//                          child: Text(
//                            "LOGOUT",
//                            style: txtCreditsTitle.copyWith(color: AppTheme.whiteColor),
//                          ),
//                          onPressed: logout,
//                        ),
//                      )
                    ]),
                  )
                ],
              ));
  }
}

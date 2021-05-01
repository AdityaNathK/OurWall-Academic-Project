import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:family/models/usermodel.dart';
import 'package:family/pages/general/credits.dart';
import 'package:family/pages/general/edit_user_profile.dart';
import 'package:family/pages/general/info_page.dart';
import 'package:family/pages/social/searchpage.dart';
import 'package:family/resources/strings.dart';
import 'package:family/resources/styling.dart';
import 'package:family/widgets/header_appbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'createaccount.dart';
import 'homepage.dart';
import '../social/imagespage.dart';

const padding = 25.0;

const animateTime = 300;

final GoogleSignIn googleSignIn = GoogleSignIn();
final StorageReference storageRef = FirebaseStorage.instance.ref();
final userRef = Firestore.instance.collection('users');
final postRef = Firestore.instance.collection('posts');
final DateTime timeStamp = DateTime.now();
User currentUser;

String currentUserId;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  void login() async {
    DataConnectionStatus status =
        await DataConnectionChecker().connectionStatus;
    if (status == DataConnectionStatus.connected) {
      googleSignIn.signIn();
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No Internet"),
                content: Text("Check Your Internet Connection"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }

//  checkInternet() async {
//    // Simple check to see if we have internet
//    print("The statement 'this machine is connected to the Internet' is: ");
//    print(await DataConnectionChecker().hasConnection);
//    // returns a bool
//
//    // We can also get an enum value instead of a bool
//    print("Current status: ${await DataConnectionChecker().connectionStatus}");
//    // prints either DataConnectionStatus.connected
//    // or DataConnectionStatus.disconnected
//
//    // This returns the last results from the last call
//    // to either hasConnection or connectionStatus
//    print("Last results: ${DataConnectionChecker().lastTryResults}");
//
//    // actively listen for status updates
//    // this will cause DataConnectionChecker to check periodically
//    // with the interval specified in DataConnectionChecker().checkInterval
//    // until listener.cancel() is called
//    var listener = DataConnectionChecker().onStatusChange.listen((status) {
//      switch (status) {
//        case DataConnectionStatus.connected:
//          print('Data connection is available.');
//          break;
//        case DataConnectionStatus.disconnected:
//          print('You are disconnected from the internet.');
//          break;
//      }
//    });
//
//    // close listener after 1 seconds, so the program doesn't run forever
//    await Future.delayed(Duration(seconds: 1));
//    //await listener.cancel();
//    return await DataConnectionChecker().connectionStatus;
//
//  }

  handleSignIn(GoogleSignInAccount account) {
    createUserInFireStore();
    if (account != null) {
      setState(() {
        isAuth = true;
      });
    } else {
      isAuth = false;
    }
  }

  createUserInFireStore() async {
    // Check if user exists in user collection in database (with their Id)

    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await userRef.document(user.id).get();

    // If user does not exist we will take them to create account page

    if (!doc.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      userRef.document(user.id).setData({
        "id": user.id,
        "userName": username,
        "displayName": user.displayName,
        "photoUrl": user.photoUrl,
        "displayPic": "",
        "email": user.email,
        "bio": "",
        "familyId": "",
        "isAdmin": "",
        "memberActive": "",
        "index": "",
        "timeStamp": timeStamp
      });
      doc = await userRef.document(user.id).get();
    }

    currentUser = User.fromDocument(doc);
    print("Print Current user Id: ${currentUser.displayName}");
  }

  // get Username from create account. use it to make a document in users collection

  logout() {
    setState(() {
      googleSignIn.signOut();
    });
  }

  onPageChanged(int pageIndex) async {
    DataConnectionStatus status =
        await DataConnectionChecker().connectionStatus;
    if (status == DataConnectionStatus.connected) {
      setState(() {
        this.pageIndex = pageIndex;
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No Internet"),
                content: Text("Check Your Internet Connection"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: animateTime), curve: Curves.easeInOut);
  }

  Scaffold buildAuthScreen() {
    setState(() {
      currentUserId = googleSignIn.currentUser.id;
    });
    return Scaffold(
      body: PageView(
        children: <Widget>[
          MyHomePage(
              id: currentUserId
          ),
          GalleryImages(currentUser: currentUser),
//          MediaUpload(currentUser: currentUser),
          SearchPage(),
          SettingsPage(id: currentUserId)
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: AppTheme.semiBlack,
        backgroundColor: Colors.white,
        buttonBackgroundColor: AppTheme.mainColor,
        height: 50,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 20,
            color: Colors.white,
          ),
          Icon(
            Icons.perm_media,
            size: 20,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            size: 20,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            size: 20,
            color: Colors.white,
          )
        ],
        animationDuration: Duration(milliseconds: animateTime),
        index: 0,
        animationCurve: Curves.easeInOut,
        onTap: onTap,
      ),
    );
  }

  Scaffold buildSignInScreen() {
    return Scaffold(
      backgroundColor: Color.fromARGB(0xFF, 0xF0, 0xF0, 0xF0),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
//                begin: Alignment.topRight,
//                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFD1913C).withOpacity(0.5),
                  Theme.of(context).primaryColor,

            ])),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              Strings.welcomeText,
              style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.whiteColor),
            ),
            Padding(
              padding: EdgeInsets.all(30),
            ),
            Container(
                height: 200,
                width: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Card(
                        elevation: 50.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset("assets/images/logo.png")))),
            Padding(
              padding: EdgeInsets.all(70),
            ),
            GoogleSignInButton(
                onPressed: () {
                  login();
                },
                darkMode: true),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);

//    Detect's when user is signed In
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    },
//    Detects if there is any error signing In
        onError: (err) {
      print("Error Signing In: $err");
    });

//    ReAuthenticate user when app is opened

    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print("Error Signing In: $err");
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildSignInScreen();
  }
}

// handel User Profile Page
class Profile extends StatefulWidget {
  final String profileId;

  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
//  Column buildCountColumn(String label, int count) {
//    return Column(
//      mainAxisSize: MainAxisSize.min,
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Text(
//          count.toString(),
//          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
//        ),
//        Container(
//          margin: EdgeInsets.only(top: 4),
//          child: Text(
//            label,
//            style: TextStyle(
//                fontSize: 15.0,
//                fontWeight: FontWeight.w400,
//                color: Colors.grey),
//          ),
//        )
//      ],
//    );
//  }

  buildProfileEditButton() {
    return buildButton(text: 'Edit Profile', function: editProfile);
  }

  editProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(currentUserId: currentUserId)));
  }

  Container buildButton({String text, Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      child: FlatButton(
        onPressed: function,
        child: Container(
          alignment: Alignment.center,
          width: 210,
          height: 27,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  buildProfileHeader() {
    return FutureBuilder(
        future: userRef.document(widget.profileId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          User user = User.fromDocument(snapshot.data);
          return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          CachedNetworkImageProvider(user.photoUrl),
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 4),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              "USER NAME",
                              style: txtHeadingNormal.copyWith(color: AppTheme.mainColor),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
//                color: Colors.orange,
                          child: ListTile(
                            title: Center(
                              child: Text(
                                user.displayName,
                                style: txtNormal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          title: Center(
                            child: Text(
                              "BIO",
                              style: txtHeadingNormal.copyWith(color: AppTheme.mainColor),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
//                color: Colors.orange,
                          child: ListTile(
                            title: Center(
                              child: Text(
                                user.bio,
                                style: txtNormal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  buildProfileEditButton(),

//                  Expanded(
//                    flex: 4,
//                    child: Container(
//                      color: Colors.green,
//                    ),
//                  )
                ],
              ));
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: headerAppBar(context, titleText: 'USER PROFILE'),
        body: ListView(
          children: <Widget>[
            buildProfileHeader(),
          ],
        ));
  }

//  void getCurrentUser() {
//
//    currentUserIdNew = currentUserId ;
//    print("The Current User is :$currentUserId");
//  }
}

class SettingsPage extends StatefulWidget {
  final String id;

  SettingsPage({this.id});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  logout() async {
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: headerAppBar(context, titleText: "SETTINGS"),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(8.0),
//                color: Colors.orange,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile(profileId: widget.id))),
                  child: ListTile(
                    title: Text(
                      "PROFILE SETTINGS",
                      style: txtCreditsTitle,
                    ),
                    trailing: Icon(
                      Icons.account_circle,
                      color: AppTheme.mainColor,
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
//                color: Colors.orange,
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InfoPage())),
                  child: ListTile(
                    title: Text(
                      "APPLICATION INFO",
                      style: txtCreditsTitle,
                    ),
                    trailing: Icon(Icons.info, color: AppTheme.mainColor),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
//                color: Colors.orange,
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreditsPage())),
                  child: ListTile(
                    title: Text(
                      "DEVELOPER INFO",
                      style: txtCreditsTitle,
                    ),
                    trailing:
                        Icon(Icons.developer_mode, color: AppTheme.mainColor),
                  ),
                ),
              ),
              Card(
                color: Colors.red,
                margin: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: logout,
                  child: ListTile(
                    title: Text(
                      "LOGOUT",
                      style: txtCreditsTitle.copyWith(color: AppTheme.whiteColor),
                    ),
                    trailing: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Text("app version: v 1.0",style: txtNormal,),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

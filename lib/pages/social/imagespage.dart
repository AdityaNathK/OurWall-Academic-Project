import 'package:family/models/usermodel.dart';
import 'package:family/widgets/header_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:family/pages/home/signinpage.dart';
import 'package:family/resources/styling.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';

class GalleryImages extends StatefulWidget {
  final User currentUser;

  GalleryImages({this.currentUser});

  @override
  _GalleryImagesState createState() => _GalleryImagesState();
}

class _GalleryImagesState extends State<GalleryImages> {
  File file;
  bool isUploading = false;
  String postId = Uuid().v4();
  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  bool circularIndicator = false;
  final CollectionReference collectionReference =
      Firestore.instance.collection("posts");

  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 675, maxWidth: 960);
    setState(() {
      this.file = file;
    });
  }

  handleGalleryPhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            elevation: 10.0,
            title: Text("SELECT IMAGE"),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: <Widget>[
                    SimpleDialogOption(
                      child: Text(
                        "CAMERA",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      onPressed: handleTakePhoto,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60, right: 60),
                      child: Divider(
                        color: AppTheme.greyColor,
                        height: 3,
                      ),
                    ),
                    SimpleDialogOption(
                      child: Text("GALLERY",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                      onPressed: handleGalleryPhoto,
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                child: Center(
                    child: Container(
                  color: AppTheme.mainColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                          color: AppTheme.whiteColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  clearImage() {
    setState(() {
      file = null;
    });
  }

  Scaffold buildUploadScreen() {
    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: headerAppBar(context, titleText: "GALLERY"),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => selectImage(context),
        ),
        body: Container(
          color: Colors.white,
          child: wallpapersList != null
              ? StaggeredGridView.countBuilder(
                  padding: const EdgeInsets.all(8.0),
                  crossAxisCount: 4,
                  itemCount: wallpapersList.length,
                  itemBuilder: (context, i) {
                    String imgPath = wallpapersList[i].data['mediaUrl'];
                    return Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: InkWell(
                        child: Hero(
                          tag: imgPath,
                          child: FadeInImage(
                            image: NetworkImage(imgPath),
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage("assets/images/place-holder.jpeg"),
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (i) =>
                      StaggeredTile.count(2, i.isEven ? 2 : 3),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  // TODO: Compress image in flutter
  //=================== Image Compression ===============================//
  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  //=================== Image Compression ===============================//

  cretePostInFirestore({String mediaUrl, String location, String description}) {
    postRef.document(postId).setData({
      "postId": postId,
      "ownerId": widget.currentUser.id,
      'username': widget.currentUser.userName,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "timestamp": timeStamp,
      "likes": {},
    });
  }

  handleSubmit() async {
    print("handling submit");
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file);
    cretePostInFirestore(
        mediaUrl: mediaUrl,
        location: locationController.text,
        description: captionController.text);

    captionController.clear();
    locationController.clear();
    setState(() {
      file = null;
      isUploading = false;
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageRef.child("post_$postId.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  circular() {
    setState(() {
      circularIndicator = true;
    });
  }

  buildUploadForm() {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "NEW POST",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal),
        ),
        backgroundColor: AppTheme.mainColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.whiteColor,
          ),
          onPressed: clearImage,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: isUploading ?()=> circular() : () => handleSubmit(),
            icon: Icon(Icons.check_circle, color: Colors.greenAccent),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
//          isUploading ? LinearProgressIndicator() : Text("True"),
          //TODO: Linear Progress bar to indicate post time
          Container(
            padding: EdgeInsets.all(10),
            height: 220,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(file),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                    hintText: "Write a caption", border: InputBorder.none),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.description,
              color: AppTheme.mainColor,
              size: 20,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                    hintText: "Where was this photo taken?",
                    border: InputBorder.none),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              onPressed: getUserLocation,
              icon: Icon(
                Icons.my_location,
                color: AppTheme.whiteColor,
              ),
              label: Text(
                "Use Current Location",
                style: TextStyle(color: AppTheme.whiteColor, fontSize: 15),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: AppTheme.mainColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          circularIndicator?CircularProgressIndicator():Container(),
        ],
      ),
    );
  }

  getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark placeMark = placeMarks[0];

    String fullAddress =
        '${placeMark.subThoroughfare} ${placeMark.thoroughfare},${placeMark.subLocality}${placeMark.locality},${placeMark.subAdministrativeArea} ${placeMark.administrativeArea} ${placeMark.postalCode},${placeMark.country}';

    print(fullAddress);

    String formattedAddress = "${placeMark.locality}, ${placeMark.country}";

    locationController.text = formattedAddress;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buildUploadScreen() : buildUploadForm();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family/models/usermodel.dart';
import 'package:family/pages/home/signinpage.dart';
import 'package:family/resources/styling.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();

  bool isSearching = false;

  Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query) {
    Future<QuerySnapshot> users = userRef
        .where('displayName', isGreaterThanOrEqualTo: query).where('displayName', isLessThan: query + 'z')
        .getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  AppBar buildSearchField() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppTheme.mainColor,
      title: !isSearching
          ? Text(
              "SEARCH",
              style: TextStyle(
                  color: AppTheme.whiteColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 30.0),
            )
          : TextFormField(
              style: txtNormal.copyWith(color: AppTheme.whiteColor),
              controller: textEditingController,
              decoration: InputDecoration(
//                  filled: true,
                  hintText: 'search',
                  icon: Icon(
                    Icons.search,
                    color: AppTheme.whiteColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: AppTheme.whiteColor,
                    ),
                    onPressed: clearSearch,
                  ),
                  hintStyle: TextStyle(
                      color: AppTheme.whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal)),
              onFieldSubmitted: handleSearch,
            ),
      actions: <Widget>[
        isSearching
            ? IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: AppTheme.whiteColor,
                ),
                onPressed: () {
                  setState(() {
                    this.isSearching = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.search,
                  color: AppTheme.whiteColor,
                ),
                onPressed: () {
                  setState(() {
                    this.isSearching = true;
                  });
                },
              )
      ],
    );
  }

  clearSearch() {
    textEditingController.clear();
  }

  buildNoContent() {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            //TODO: Image Added
            Container(
                height: 300,
                child: SvgPicture.asset(
                  'assets/images/search.svg',
                  height: 300,
                )),
          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
        future: searchResultsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: CircularProgressIndicator(),
            );
          }
          List<UserResult> searchResults = [];
          snapshot.data.documents.forEach((doc) {
            User user = User.fromDocument(doc);
            UserResult searchResult = UserResult(user);
            searchResults.add(searchResult);
          });
          return ListView(
            children: searchResults,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => print("Tapped"),
          child: Container(
            padding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            child: Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.whiteColor,
                  backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                ),
                title: Text(
                  user.displayName,
                  style: txtCreditsTitle,
                ),
                subtitle: Text(
                  user.userName,
                  style: txtCreditsSubTitle,
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: 2.0,
          color: AppTheme.whiteColor,
        )
      ],
    );
  }
}

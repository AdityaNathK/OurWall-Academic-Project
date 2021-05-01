import 'package:family/widgets/header_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TODOListPage extends StatefulWidget {
  @override
  _TODOListPageState createState() => _TODOListPageState();
}

class _TODOListPageState extends State<TODOListPage> {
  String listItem = "";

  createGroceryList() {
    DocumentReference documentReference =
    Firestore.instance.collection('TODOlist').document(listItem);

    Map<String, String> gList = {"listItem": listItem};

    documentReference.setData(gList).whenComplete(() {
      Scaffold.of(context)
          .showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
            "ITEM CREATED"),
      ));
    });
  }

  deleteGroceryList(item) {
    DocumentReference documentReference =
    Firestore.instance.collection('TODOlist').document(item);
    documentReference.delete().whenComplete(() {
      print("$item Deleted");
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerAppBar(context, titleText: 'TO-DO LIST '),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text('ADD NEW ITEM'),
                  content: TextField(
                    onChanged: (String value) {
                      listItem = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green,
                        ),
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'ADD',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        createGroceryList();
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("TODOlist").snapshots(),
        builder: (context, snapshots) {
          if(snapshots.data == null) return CircularProgressIndicator();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshots.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot =
              snapshots.data.documents[index];

              return Dismissible(
                direction: DismissDirection.startToEnd,
                resizeDuration: Duration(milliseconds: 200),
                key: Key(documentSnapshot['listItem']),
                onDismissed: (direction) {
                  deleteGroceryList(documentSnapshot['listItem']);
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text(
                        "ITEM DELETED"),
                  ));
                },
                background:  Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerStart,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: Card(
                  margin: EdgeInsets.all(3),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(documentSnapshot['listItem']),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deleteGroceryList(documentSnapshot['listItem']);
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                              "ITEM DELETED"),
                        ));
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

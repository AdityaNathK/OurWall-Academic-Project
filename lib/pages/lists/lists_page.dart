import 'package:family/pages/lists/todo_list_Page.dart';
import 'package:family/resources/styling.dart';
import 'package:family/widgets/header_appbar.dart';
import 'package:flutter/material.dart';

import 'grocery_list_page.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerAppBar(context, titleText: 'LISTS'),
      backgroundColor: Colors.white,
      body:Container(
        //TODO implement todo list
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TODOListPage()));
                },
                child:Card(
                  margin: const EdgeInsets.all(8.0),
//                color: Colors.orange,
                  child: ListTile(
                    title: Text(
                      "TO-DO LIST",
                    ),
                    trailing: Icon(Icons.view_list,color: AppTheme.mainColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> GroceryPage()));
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
//                color: Colors.orange,
                  child: ListTile(
                    title: Text(
                      "GROCERY LIST",
                    ),
                    trailing: Icon(Icons.shopping_cart,color: AppTheme.mainColor,),
                  ),
                ),
              ),
            )
          ],
        ),

        //TODO implement Grocery list
      ),

    );
  }
}

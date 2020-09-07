import 'package:flutter/material.dart';
import 'package:recipeme2/screens/CreateRecipe.dart';
import 'package:sqflite/sqflite.dart';
import '../components/Database.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as ImageProcess;
import 'package:flip_card/flip_card.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

final List<String> titles = <String>[];
final List<String> descr = <String>[];
final List<String> images = <String>[];
final List<int> colorCodes = <int>[];
final dbHelper = DatabaseHelper.instance;

class ListContainers extends StatefulWidget {
  @override
  _ListContainersState createState() => _ListContainersState();
}

class _ListContainersState extends State<ListContainers> {
  String answertitle, answerdesc;

  @override
  void initState() {
    titles.removeRange(0, titles.length);
    descr.removeRange(0, descr.length);
    images.removeRange(0, images.length);
    colorCodes.removeRange(0, colorCodes.length);
    _query();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      child: TextField(
                        onChanged: (value) {
                          answertitle = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Search By Title',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.search),
                      onPressed: () {
                        print(answertitle);
                        if (answertitle != null) {
                          _querybytitle();
                        }
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        margin: EdgeInsets.all(10.0),
                        height: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            /*
                            Expanded(
                              child: Container(
                                height: 50.0,
                                child: Center(child:
                                Text('${titles[index]}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0

                                  ),)),
                              ),
                            ),
*/
                            images[index] == null ? Image.memory(
                              base64Decode(images[index]), fit: BoxFit.cover,
                              width: 220,
                              height: 220,) :
                            Image.memory(
                              base64Decode(images[index]), fit: BoxFit.cover,
                              width: 220,
                              height: 220,),

                          ],
                        ),
                      ),
                      back: Container(
                        padding: EdgeInsets.all(20.0),
                        margin: EdgeInsets.all(10.0),
                        height: 230,
                        color: Colors.pink[colorCodes[index]],
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text('${titles[index]}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0
                                  ),),
                                  Text('${descr[index]}')
                                ],
                              ),
                            ),
                            IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {

                                    titles.removeAt(index);
                                    descr.removeAt(index);
                                    images.removeAt(index);
                                    colorCodes.removeAt(index);
                                    _delete(index+1); // Primero borramos la fila en la db que tendra el id sumado a 1 , porque en la lista empiezan desde 0
                                    dbHelper.updateId((index+1).toString());  //Here we say , okey for the row we deleted , all the rows above, substract one to the id to align with the lists we have
                                  });
                                }),
                          ],
                        ),

                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) {
      setState(() {
        titles.add(row['title']);
        descr.add(row['descr']);
        images.add(row['image']);
        colorCodes.add(200);
      });
    });
  }

 void _delete(int row) async {
    // Assuming that the number of rows is the id for the last row.
    //final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(row);
    print('deleted $rowsDeleted row(s): row $row');
 }

  void _querybytitle() async {
    setState(() {
      titles.removeRange(0, titles.length);
      descr.removeRange(0, descr.length);
      images.removeRange(0, images.length);
      colorCodes.removeRange(0, colorCodes.length);
    });
    final allRows = await dbHelper.queryRowByTitle(answertitle);
    allRows.forEach((row) {
      setState(() {
        titles.add(row['title']);
        descr.add(row['descr']);
        images.add(row['image']);
        colorCodes.add(600);
      });


    });
  }


}

class ListDatabase {

  String title;
  String description;
  String image;

  ListDatabase(String title, String description, String image) {
    this.title = title;
    this.description = description;
    this.image = image;


    titles.add(this.title);
    descr.add(this.description);
    images.add(this.image);
    colorCodes.add(200);
  }

}


  // aqui le tengo que añadir al final de cada lista los valores para que asi me añada el container






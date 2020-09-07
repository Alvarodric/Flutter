import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:recipeme2/components/Database.dart';
import 'package:recipeme2/screens/ListContainers.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as ImageProcess;
import 'package:convex_bottom_bar/convex_bottom_bar.dart';



class CreateRecipe extends StatefulWidget {
  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {

  File _image;
  Image _imagecoded;
  Uint8List dataimage;
  String base64Image;



  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      dataimage = _image.readAsBytesSync();
      base64Image = base64String(dataimage);
      print(base64Image);


    });
  }

  final dbHelper = DatabaseHelper.instance;
    String title;
    String description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  width: MediaQuery.of(context).size.width,
                  height: 150.0,
                  child: Center(
                    child: _image ==null ?
                    Text('Tap here to select image') :
                    ClipOval(child: Image.file(_image,fit: BoxFit.cover,width: 120,height: 120,)),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  textCapitalization: TextCapitalization.characters,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title of the recipe',
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  maxLines: 8,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'List of ingredients:',
                  ),
                ),
              ),

              FlatButton(
                color: Colors.white,
                child: Text(
                  'Add Recipe',
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
                onPressed: (){


                  _insert();
                  ListDatabase(title,description,base64Image);
                  Navigator.pushReplacementNamed(context, '/first');
                  //Tengo que poner un mensaje de que esta añadido
                  //
                  //
                  //
                  //

                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle : title,
      DatabaseHelper.columnDesc : description,
      DatabaseHelper.columnImage  : base64Image,
    };

    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  static String base64String(Uint8List data){

    return base64Encode(data);
  }

//  static Image imageFromBase64String(String base64String){
//
//    return Image.memory(base64Decode(base64String),
//    fit: BoxFit.fill,);
//
//  }


}




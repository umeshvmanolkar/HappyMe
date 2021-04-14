
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'happy.dart';


Future<String> getNamePreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");
  return name;
}

class HomePage extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _name = "";
  File _image;
  String _imagepath;

  @override

  void initState() {
    getNamePreference().then(updateName);
    super.initState();
    loadImage();
  }
  Widget build(BuildContext context) {
    return new Scaffold(

        body: Container(
                  padding: EdgeInsets.all(20),
    child: Column(
    children: [

      SizedBox(height: 180,),

    _imagepath != null
        ?CircleAvatar(backgroundImage:FileImage(File(_imagepath)) ,radius:60 ,)
        :CircleAvatar(radius:60,backgroundImage
        : _image!=null?FileImage(_image)
        :AssetImage("Images/person.png"),),
    SizedBox(height: 20,),


    SizedBox(height: 10,),

    new Align(
      alignment: Alignment.center,
    child:
    Text("Welcome  "+_name),
    ),

      SizedBox(height: 40,),

      Text("Do you want to have sad or a Happy Day \ntoday?"),

      SizedBox(height: 30,),

      Row(
        children: [
          SizedBox(width: 33,),
          ButtonTheme(minWidth:30.0, buttonColor:Colors.white,child:
          RaisedButton(child:Text("Sad"),onPressed: (){})
          ),
          SizedBox(width: 15,),

          ButtonTheme(minWidth:170.0, buttonColor:Colors.white,child:
          RaisedButton(child:Text("Happy"),onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> Happy() ));
          })
          )
        ],
      )
    ]
    ),
    ),);
  }



  void updateName(String name){
    setState(() {
      this._name=name;
    });
  }

  void pickImage()async {
    var imageFile = File(await ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) => pickedFile.path));

    setState(() {
      _image = imageFile;
    });
  }

  void saveImage(path) async{
    SharedPreferences saveimage= await SharedPreferences.getInstance();
    saveimage.setString('imagepath', path);
  }

  void loadImage() async{
    SharedPreferences saveimage= await SharedPreferences.getInstance();
    setState(() {
      _imagepath= saveimage.getString('imagepath');
    });

  }

}




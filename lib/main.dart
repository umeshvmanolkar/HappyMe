import 'package:flutter/material.dart';
import 'package:happy/Evening.dart';
import 'Home.dart';
import 'happy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        NextPage.routeName:(context)=> new NextPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => new _MyHomePageState();

}

//Register Page
class _MyHomePageState extends State<MyHomePage>{
  var _controller = new TextEditingController(); //for edit text
  String valueChoose;
  File _image;
  String _imagepath;
  List listItem=[
    "Pacific/Apia	UTC - 13:00","Etc/GMT+12	UTC - 12:00","America/Regina	UTC - 06:00","America/New_York	UTC - 05:00","Asia/Calcutta	UTC + 05:30"
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),

              Text("Happy Me",style: TextStyle(fontSize: 20,color: Colors.blue),),

              SizedBox(height: 20),

              Row(
                children:[
                  SizedBox(width: 190,),
                  IconButton(icon: Icon(Icons.edit_outlined),
                      onPressed: (){
                    pickImage();
                  }),
              ]),
              _imagepath != null
                  ?CircleAvatar(backgroundImage:FileImage(File(_imagepath)) ,radius:60 ,)
                  :CircleAvatar(radius:60,backgroundImage
                  : _image!=null?FileImage(_image)
                  :AssetImage("Images/person.png"),),

              SizedBox(height: 20,),

              new Align(
                alignment: Alignment.topLeft,
              child:Text("Do you want to be Happy Everyday ?"),
              ),

              SizedBox(height: 20),

          Text("Register Below, we will help you, with one simple proven method, which has worked for everyone."),

              SizedBox(height: 15),

              Container(
                padding: EdgeInsets.only(right: 30),
                child:Column(
                  children:[
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your Name',
                )),

              TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your Email',

              )),

                     DropdownButton(
                      value: valueChoose,
                       onChanged: (newValue){
                        setState(() {
                          valueChoose = newValue;
                        });
                       },
                       items:listItem.map((valueItem){
                         return DropdownMenuItem(
                             value:valueItem,
                             child: Text(valueItem));
                       }).toList(),
                     ),
                ]
              ),
              ),

                     RaisedButton(
                        child:new Text("Register"),
                        onPressed: (){
                          saveName();
                    }),
                ],
              ),
        ),
      ),
      );

  }


  //saving name in shared preferences
  void saveName() {
    String name = _controller.text;
    saveNamePreference(name).then((bool committed){
      Navigator.of(context).pushNamed(NextPage.routeName);
      saveImage(_image.path);
    });
  }

  //Image Picker
  void pickImage() async {
    var imageFile = File(await ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) => pickedFile.path));
    setState(() {
      _image = imageFile;
    });
  }

  //Saving image in shared preferences
  void saveImage(path) async{
    SharedPreferences saveimage= await SharedPreferences.getInstance();
    saveimage.setString('imagepath', path);
  }

  //Loading image from shared preferences
  void loadImage() async{
    SharedPreferences saveimage= await SharedPreferences.getInstance();
    setState(() {
      _imagepath= saveimage.getString('imagepath');
    });

  }
  
}
//saving name in shared preferences
Future<bool> saveNamePreference(String name) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name",name);
  return prefs.commit();
}

// getting name from shared preferences
Future<String> getNamePreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");
  return name;
}



//Continue Page
class NextPage extends StatefulWidget{

  static String routeName = "/nextPage";
  @override
  _NextPageState createState()=> new _NextPageState();

}

class _NextPageState extends State<NextPage>{
  @override

  Widget build(BuildContext context) {
    return new Scaffold(

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 150,),
            Text("Thank you for registering \n\nHow does the app work?\n\n1. Every day morning you will get a notification on how you want to live your day? Tap\n\n2. Based on your choice you will see a fantastic life changing short story for the day. You will promise yourself to be happy entire day what ever happens. \n\n3. Evening you will get one more notification, asking how was your day? That will help you to monitor yourself and keep improving everyday. ",
              style: TextStyle(fontSize: 16),),
            SizedBox(height: 20,),

            RaisedButton(
                child: Text("Continue"),
                onPressed:(){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage() ));
            })
          ],
        ),
      ),
    );
  }





}
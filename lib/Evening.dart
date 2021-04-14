import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:io';

Future<String> getNamePreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");
  return name;
}
class Evening extends StatefulWidget {
  @override
  _EveningState createState() => _EveningState();
}

class _EveningState extends State<Evening> {
  String _name = "";
  File _image;
  String _imagepath;
  bool pressAttention1 = true, pressAttention2 =true, pressAttention3 =true,pressAttention4 =true,pressAttention5 =true;
  double h = 0, b = 0;

  @override
  void initState() {
    getNamePreference().then(updateName);
    super.initState();
    loadImage();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
            SizedBox(height: 20,),
          _imagepath != null
              ? CircleAvatar(backgroundImage: FileImage(File(_imagepath)), radius: 60,)
              : CircleAvatar(radius: 60, backgroundImage
              : _image != null ? FileImage(_image)
              : AssetImage("Images/person.png"),),

          SizedBox(height: 10,),

          Align(
            alignment: Alignment.center,
            child: Text("Welcome  " + _name),
          ),

          SizedBox(height: 30,),
          Align(
              alignment: Alignment.topLeft,
              child: Text("   How was your day today ?")),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ButtonTheme( child: RaisedButton(
              child: Text("Amazing "),
              color: pressAttention1 ? Colors.white : Colors.grey,
              onPressed: (){setState(() {h=100;b=5;pressAttention1 = !pressAttention1;});},)),
          ButtonTheme(minWidth: 5.0,
            child: RaisedButton(child: Text("Happy"),
            color: pressAttention2 ? Colors.white : Colors.grey,
            onPressed: () {
            setState(() {
              h = 80;
              b = 20;
              pressAttention2 = !pressAttention2;
            });
          },)),
      ButtonTheme(minWidth: 5.0,
          buttonColor: Colors.white,
          child: RaisedButton(child: Text("OK"),
            color: pressAttention3 ? Colors.white : Colors.grey,
            onPressed: () {
            setState(() {
              h = 50;
              b = 50;
              pressAttention3 = !pressAttention3;
            });
          },)),
      ButtonTheme(minWidth: 5.0,
          buttonColor: Colors.white,
          child: RaisedButton(child: Text("Not Great"),
            color: pressAttention4 ? Colors.white : Colors.grey,
            onPressed: () {
            setState(() {
              h = 30;
              b = 70;
              pressAttention4 = !pressAttention4;
            });
          },)),

      ],

    ),
    ButtonTheme(minWidth:5.0,
        child:RaisedButton(child:Text("Sad"),
      color: pressAttention5 ? Colors.white : Colors.grey,
      onPressed: (){
          setState(() {
            h=10;
            b=90;
            pressAttention5 = !pressAttention5;
          });},)),
    SizedBox(height: 30,),
    Text("Your Mood Meter"),
    SizedBox(height: 20,),

    PieChart(dataMap:{"Amazing":h,"bad":b},
    colorList: [Colors.lightGreen,Colors.redAccent],
    legendOptions: LegendOptions(showLegends: false),
    chartRadius: 240,
    chartValuesOptions: ChartValuesOptions(
    showChartValues: false
    ),),
    SizedBox(height: 30,),
    Text("See you tomorrow."),


    ],
    ),
    ),
    );
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  void loadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString('imagepath');
    });
  }


}

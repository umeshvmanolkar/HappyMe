import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:io';


Future<String> getNamePreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");
  return name;
}

class Happy extends StatefulWidget {
  static String routeName = "/happy";
  @override
  _HappyState createState() => _HappyState();
}

class _HappyState extends State<Happy> {
  String _name = "";

  File _image;
  String _imagepath;

  Random rnd = new Random();
  //var lst = ['Believe that you are beautiful and have what it takes to move mountains, and you’ll move mountains.  Don’t allow yourself to be let down by what others say. Get up and do what you can do best. Good morning. Forget about what you couldn’t achieve yesterday and think of the wonderful things today has for you. Work with all your might towards them to make your tomorrow extraordinarily bright. Good morning! The dreams you had last night can only come to reality if you get up and work at achieving them today. Every morning is an important milestone for the next thing to achieve. So don’t waste any more time, get out there and do your best. Good morning.As you wake up from your slumber, do not look at today as an ordinary day. Look at it as the day that marks the beginning of your journey into prosperity. So get out there and grab all the opportunities that dwell in this beautiful day because the sun will soon go down and all will be gone. Good morning.Today is not just another day, but another possible chance to achieve what you couldn’t achieve yesterday. So get on your feet and chase after your success. Good morning.Today has a lot of good things for all who are alive in it. Wake up and pursue life with courage and hope, and I can assure you that your future is going to be bright. Good morning, my dear.As you wake up from sleep today, know that I have faith in you. I believe in you, and I know you have what it takes to conquer the hurdles in your way. Just believe in yourself like I believe in you and you will achieve remarkable things in this life. Good morning.Start your day knowing that the desire for success is the first step to achieving greatness. If you have it, then get all out and take everything that this special day has made for you. Good morning.'];

  var lst = ['Believe that you are beautiful and have what it takes to move mountains, and you’ll move mountains.  Don’t allow yourself to be let down by what others say. Get up and do what you can do best. Good morning.','Forget about what you couldn’t achieve yesterday and think of the wonderful things today has for you. Work with all your might towards them to make your tomorrow extraordinarily bright. Good morning!','The dreams you had last night can only come to reality if you get up and work at achieving them today. Every morning is an important milestone for the next thing to achieve. So don’t waste any more time, get out there and do your best. Good morning.','As you wake up from your slumber, do not look at today as an ordinary day. Look at it as the day that marks the beginning of your journey into prosperity. So get out there and grab all the opportunities that dwell in this beautiful day because the sun will soon go down and all will be gone. Good morning.','Today is not just another day, but another possible chance to achieve what you couldn’t achieve yesterday. So get on your feet and chase after your success. Good morning.','Today has a lot of good things for all who are alive in it. Wake up and pursue life with courage and hope, and I can assure you that your future is going to be bright. Good morning, my dear.','As you wake up from sleep today, know that I have faith in you. I believe in you, and I know you have what it takes to conquer the hurdles in your way. Just believe in yourself like I believe in you and you will achieve remarkable things in this life. Good morning.','Start your day knowing that the desire for success is the first step to achieving greatness. If you have it, then get all out and take everything that this special day has made for you. Good morning.'];

  @override
  void initState() {
    getNamePreference().then(updateName);
    super.initState();

    loadImage();
  }

  Widget build(BuildContext context) {
    int randoml = Random().nextInt(lst.length);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child:Column(
          children:[
            SizedBox(height: 15,),
            _imagepath != null
                ?CircleAvatar(backgroundImage:FileImage(File(_imagepath)) ,radius:60 ,)
                :CircleAvatar(radius:60,backgroundImage
                : _image!=null?FileImage(_image)
                :AssetImage("Images/person.png"),),

            SizedBox(height: 10,),
          new Align(
          alignment: Alignment.center,
          child: Text(_name,style:TextStyle(fontSize: 15)),
          ),
            SizedBox(height: 20),

            Text("You promise to yourself, you will be HAPPY today irrespective of what ever happens throughout the day.", style:TextStyle(fontSize: 16)),
            SizedBox(height: 10),


        new Align(
          alignment: Alignment.topLeft,
            child:
            Text("Story of the day!",style: TextStyle(fontSize: 20)),
        ),

            SizedBox(height: 10),
            SingleChildScrollView(
              child: Container(
                height: 320,
                child:
              Text(lst[randoml],
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.start,
              ),
                decoration: myBoxDecoration(),
              ),
            ),


            SizedBox(height: 20,),


            Text("See you in evening"),
        ],
        ),
    ),
    );
  }

  BoxDecoration myBoxDecoration(){
    return BoxDecoration(
      border: Border.all(
        width: 2
      )
    );
  }

  void updateName(String name){
    setState(() {
      this._name=name;
    });
  }



  void loadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString('imagepath');
    });
  }
}

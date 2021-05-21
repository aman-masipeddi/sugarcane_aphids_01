import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugarcanaphids01/screens/Home_Page.dart';
import 'package:sugarcanaphids01/screens/Select_State_Page.dart';
import 'package:sugarcanaphids01/screens/After_Splashscreen_Page.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String user_Selected_State;
  bool user_state_status = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    new Future.delayed(
        const Duration(seconds: 2),
            () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AfterSplashscreen()),
            ));
    _getUserSelectedStateFromSP();
  }


  _getUserSelectedStateFromSP() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    setState(() {
      user_Selected_State = myPrefs.getString('User_Selected_State');
    });
    user_state_status = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.lightGreen
        ),
        home: new Scaffold(
        backgroundColor: Colors.lightGreen,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/app_icon_1.png", width: 200, height: 200),
                Container(
                  width: 300,
                  height: 200,
                  child: Text("Glance-N-Go™ Sampler\n for Sugarcane Aphid in Sorghum", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                )
                )
              ],
            )
            ),
          ),
     );
  }
}
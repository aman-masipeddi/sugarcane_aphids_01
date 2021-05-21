import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugarcanaphids01/screens/Home_Page.dart';
import 'package:sugarcanaphids01/screens/Select_State_Page.dart';

class AfterSplashscreen extends StatefulWidget {

  @override
  _AfterSplashscreenState createState() => _AfterSplashscreenState();
}

class _AfterSplashscreenState extends State<AfterSplashscreen> {

  String user_Selected_State;
  bool user_state_status = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUserSelectedStateFromSP();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.lightGreen
        ),
        home: (user_state_status)
            ? ((user_Selected_State != null)
            ? HomePage(user_Selected_State) : SelectStatePage()) : Text(
            "No state data")
      /* (user_Selected_State != null)
          ?HomePage(user_Selected_State) : SelectStatePage(),*/
    );
  }

  _getUserSelectedStateFromSP() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    setState(() {
      user_Selected_State = myPrefs.getString('User_Selected_State');
    });
    user_state_status = true;
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugarcanaphids01/screens/Home_Page.dart';

class SelectStatePage extends StatefulWidget{

  @override
  _SelectStatePageState createState() => _SelectStatePageState();
  }

class _SelectStatePageState extends State<SelectStatePage> {


  String selected_State = "Select";
  String state;
  String user_Selected_State;

  @override
  Widget build(BuildContext context) {

    TextStyle textStyleTitle = Theme
        .of(context)
        .textTheme
        .headline6;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Select your State: ",
                    style: textStyleTitle),
                SizedBox(width: 15,),
                DropdownButton<String>(
                  value: selected_State,
                  onChanged: (String newValue) {
                    setState(() {
                      selected_State = newValue;
                    });
                  },
                  items: <String>[
                    'Select',
                    'Oklahoma',
                    'Kansas',
                    'Texas',
                    'Louisiana'
                  ]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: textStyleTitle,),
                    );
                  }).toList(),
                ),
              ],
            ),
              FloatingActionButton(
                onPressed: () {
                  _onPressed();
                },
                child: Text("Go"),
                backgroundColor: Colors.green,
              ),
            ],
          )
      )
    );
  }

  _onPressed() async {

    if (state != 'Select') {

      state = selected_State.toString();

      SharedPreferences myPrefs = await SharedPreferences.getInstance();
      myPrefs.setString('User_Selected_State', state);

      user_Selected_State = myPrefs.getString('User_Selected_State');
      print(user_Selected_State);

      setState(() {

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomePage(user_Selected_State),
            ));
      });
    }
  }
}

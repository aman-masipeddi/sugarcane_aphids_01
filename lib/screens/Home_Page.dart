import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugarcanaphids01/models/treatment_record.dart';
import 'Treatment_History_Page.dart';
import 'Treatment_Page.dart';
import 'About_Page.dart';
import 'Instructions_Page.dart';



class HomePage extends StatefulWidget {

  String user_Selected_state;

  HomePage( this.user_Selected_state,  {Key key, this.title}) : super(key: key);
  final String title;


  @override
  _HomePageState createState() => _HomePageState(this.user_Selected_state);
}

class _HomePageState extends State<HomePage> {

  String bushel;
  String acreCost;
  int YorN;
  bool value;
  double ttValue;
  String fieldTitle;

  String selected_Acre_Cost = "Select";
  String selected_Bushel_Cost = "Select";
  int group_Value_YorN = 1;

  TextEditingController titleController = TextEditingController();

  String user_Selected_state;
  String image;

  _HomePageState(this.user_Selected_state);


  @override
  initState() {
    super.initState();

    switch(user_Selected_state) {
      case "Oklahoma": {
        image = 'assets/images/DASNR-V_OSU.png';
      }
      break;

      case "Kansas": {
        image = 'assets/images/KSU_AG_College_logo.png';
      }
      break;

      case "Texas": {
        image = 'assets/images/COALS-Stacked-OnWhBkg_TexasA&M.png';
      }
      break;

      case "Louisiana": {
        image = 'assets/images/AgLogo_LSU.png';
      }
      break;

      default: {
        image = 'assets/images/DASNR-V_OSU.png';
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTitle = Theme
        .of(context)
        .textTheme
        .headline6;

    TextStyle textStyleSubtitle = Theme
        .of(context)
        .textTheme
        .subtitle2;


    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("SCA Glance-N-Go Home Page", style: TextStyle(fontSize: 16),),
        leading: GestureDetector(
          onTap: () {
            goToTreatmentHistoryPage();
          },
          child: Icon(
            Icons.history,
            color: Colors.black, // add custom icons also
          ),
        ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                goToAboutPage();
              },
              child: Text(
                "About", style: TextStyle(color: Colors.black),
              ),
            ),
          ]
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
             Column(
    children: <Widget>[
    Image.asset(image, width: 500, height: 300),
    SizedBox(height: 40,),
    TextField(
    controller: titleController,
    style: textStyleTitle,
    autofocus: false,
    decoration: InputDecoration(
    labelText: 'Field Name or Number',
    labelStyle: textStyleTitle,
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0)
    )
    ),
    ),
    SizedBox(height: 15,),
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    Text(r"Control Cost($/Acre): ",
    style: textStyleTitle),
    SizedBox(width: 15,),
    DropdownButton<String>(
    value: selected_Acre_Cost,
    onChanged: (String newValue) {
    setState(() {
    selected_Acre_Cost = newValue;
    });
    },
    items: <String>[
    'Select',
    '12 or less',
    '13 - 17',
    '18 or more'
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
    SizedBox(height: 15,),
    Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 3,
        child:
    Text(r"Price of Grain($/Bushel): ",
    style: textStyleTitle),),
    SizedBox(width: 1,),
    Expanded(
      flex: 2,
      child:
    DropdownButton<String>(
    value: selected_Bushel_Cost,
    onChanged: (String newValue) {
    setState(() {
    selected_Bushel_Cost = newValue;
    });
    },
    items: <String>[
    'Select',
    '3.00 or less',
    '3.50',
    '4.00',
    '4.50 or more'
    ]
        .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value, style: textStyleTitle),
    );
    }).toList(),
    ),)
    ],
    ),
    SizedBox(height: 15,),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Text("Is variety resistant to Sugarcane aphid?", style: textStyleTitle
    ),
    ]
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[

    SizedBox(width: 5,),
    Text("YES", style: textStyleTitle),
    Radio(
    value: 1,
    groupValue: group_Value_YorN,
    onChanged: (T) {
    setState(() {
    group_Value_YorN = T;
    });
    },
    ),
    SizedBox(width: 5,),
    Text("NO", style: textStyleTitle),
    Radio(
    value: 0,
    groupValue: group_Value_YorN,
    onChanged: (T) {
    setState(() {
    group_Value_YorN = T;
    });
    },
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
    SizedBox(height: 50,),
    ]
    ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: goToInstructionsPage,
                        iconSize: 30.0,
                        icon: new Icon(Icons.info_outline,
                          color: Colors.black,)
                    ))
          ],
    ),
        )
    )
    )
    );
  }


  _onPressed() {

    setState(() {
      acreCost = selected_Acre_Cost.toString();
      bushel = selected_Bushel_Cost.toString();
      YorN = group_Value_YorN;
      fieldTitle = titleController.text;


      if (acreCost == 'Select' || bushel == 'Select' || fieldTitle.isEmpty) {
      }
      else {
        _getTT();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TreatmentPage( Treatment_Record(" "," "," ",0), ttValue, fieldTitle),
            ));
      }
    });
  }

  void goToTreatmentHistoryPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TreatmentHistoryPage(),
        ));
  }

  _getTT() {
    setState(() {
      if (YorN == 1) {
        switch (acreCost) {
          case "12 or less":
            switch (bushel) {
              case "3.00 or less":
                value = true;
                ttValue = 0.40;
                break;
              case "3.50":
                value = true;
                ttValue = 0.35;
                break;
              case "4.00":
                value = true;
                ttValue = 0.35;
                break;
              case "4.50 or more":
                value = true;
                ttValue = 0.30;
                break;
            }
            break;
          case "13 - 17":
            switch (bushel) {
              case "3.00 or less":
                value = true;
                ttValue = 0.50;
                break;
              case "3.50":
                value = true;
                ttValue = 0.45;
                break;
              case "4.0":
                value = true;
                ttValue = 0.45;
                break;
              case "4.50 or more":
                value = true;
                ttValue = 0.40;
                break;
            }
            break;
          case "18 or more":
            switch (bushel) {
              case "3.00 or less":
                value = true;
                ttValue = 0.50;
                break;
              case "3.50":
                value = true;
                ttValue = 0.50;
                break;
              case "4.00":
                value = true;
                ttValue = 0.50;
                break;
              case "4.50 or more":
                value = true;
                ttValue = 0.50;
                break;
            }
            break;
        }
      }
      else if (YorN == 0) {
        switch (selected_Acre_Cost) {
          case "12 or less":
            switch (bushel) {
              case "3.00 or less":
                value = true;
                ttValue = 0.20;
                break;
              case "3.50":
                value = true;
                ttValue = 0.20;
                break;
              case "4.00":
                value = true;
                ttValue = 0.20;
                break;
              case "4.50 or more":
                value = true;
                ttValue = 0.20;
                break;
            }
            break;
          case "13 - 17":
            switch (bushel) {
              case "3.00 or less":
                value = true;
                ttValue = 0.25;
                break;
              case "3.50":
                value = true;
                ttValue = 0.25;
                break;
              case "4.00":
                value = true;
                ttValue = 0.25;
                break;
              case "4.50 or more":
                value = true;
                ttValue = 0.25;
                break;
            }
            break;
          case "18 or more":
            switch (bushel) {
              case "3.00 or less":
                value = true;
                ttValue = 0.30;
                break;
              case "3.50":
                value = true;
                ttValue = 0.25;
                break;
              case "4.00":
                value = true;
                ttValue = 0.25;
                break;
              case "4.50 or more":
                value = true;
                ttValue = 0.25;
                break;
            }
            break;
        }
      }
    });
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void goToAboutPage(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AboutPage(),
        ));
  }

  void goToInstructionsPage(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              InstructionsPage(),
        ));
  }

}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:sugarcanaphids01/models/treatment_record.dart';
import 'package:sugarcanaphids01/utils/database_helper.dart';
import 'package:hexcolor/hexcolor.dart';


class TreatmentPage extends StatefulWidget {
  double ttValue;
  String fieldTitle;
  final Treatment_Record treatment_record;

  TreatmentPage( this.treatment_record,this.ttValue, this.fieldTitle);

  @override
  _TreatmentPageState createState() => _TreatmentPageState( this.treatment_record, this.ttValue, this.fieldTitle);
}

class _TreatmentPageState extends State<TreatmentPage>  {

  double ttValue;
  String fieldTitle;
  Treatment_Record treatment_record;
  DatabaseHelper helper = DatabaseHelper();

  _TreatmentPageState( this.treatment_record,this.ttValue, this.fieldTitle);

  List<bool> val = [false,false,false];

  int checked_plants = 0;
  int infested_plants = 0;
  int stops = 0;
  String result = " ";

  Widget checkbox(String title, bool boolValue) {

    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .headline6;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title, style: textStyle),
        SizedBox(height: 5,),
        InkWell(
          onTap: () {
            setState(() {
              boolValue = !boolValue;
              switch (title) {
                case "Plant 1":
                  val[0] = boolValue;
                  break;
                case "Plant 2":
                  val[1] = boolValue;
                  break;
                case "Plant 3":
                  val[2] = boolValue;
                  break;
              }
            }
            );
          },

          child: (boolValue == false)
            ? Container(
              width: 100,
            height: 200,
            decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white, border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ImageIcon(
                AssetImage('assets/images/sugarcane_icon.ico'),
                size:  90.0,
                color:  Colors.black,
              ),
            ),
          )
              : Container(
            width: 100,
            height: 200,
            decoration: BoxDecoration(shape: BoxShape.rectangle, color: HexColor("#C47B6C"), border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ImageIcon(
                AssetImage('assets/images/sugarcane_icon.ico'),
                size:  90.0,
                color:  Colors.black,
              ),
            ),
          )
        )
      ]
    );
  }

  @override
  void initState() {
    result = "Start Sampling";
    print(ttValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text(fieldTitle),
      ),
      body: SingleChildScrollView
        (
        child:Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60,),
            Text("Stops: "+stops.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 25)),
            SizedBox(height: 5,),
            Text("Checked Plants: "+checked_plants.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
            SizedBox(height: 5,),
            Text("Infested Plants: "+infested_plants.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  checkbox("Plant 1", val[0]),
                  SizedBox(width: 20,),
                  checkbox("Plant 2", val[1]),
                  SizedBox(width: 20,),
                  checkbox("Plant 3", val[2]),
                ]
            ),
            SizedBox(height: 35,),
            Text(result, style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
            SizedBox(height: 35,),
            Container(
                child: (result == "Dont Treat" || result == "Treat")
                    ? FloatingActionButton.extended(
                  onPressed: () {
                    _onSave();
                  },
                  label: Text('Save', style: textStyle,),
                  backgroundColor: Colors.blue,
                )
                    : FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    _treat();
                  },
                  label: Text('Go', style: textStyle,),
                  backgroundColor: Colors.green,
                )
            ),
            //Text("$total"),
            //Text("Stop number : $stops"),
            SizedBox(height: 30,),
                FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    _onReset();
                  },
                  label: Text('Reset', style: textStyle,),
                  backgroundColor: Colors.red,
                )
          ],
        ),
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }

  void _treat(){

    for(int i=0;i<3;i++) {
      if(val[i]== true){
        infested_plants++;
      }
    }
    stops++;
    checked_plants = checked_plants+3;

    switch(ttValue.toString()){
      case "0.2":
        _tt_02(infested_plants,stops);
        break;
      case "0.25":
        _tt_025(infested_plants, stops);
        break;
      case "0.3":
        _tt_03(infested_plants, stops);
        break;
      case "0.35":
        _tt_035(infested_plants, stops);
        break;
      case "0.4":
        _tt_04(infested_plants, stops);
        break;
      case "0.45":
        _tt_045(infested_plants, stops);
        break;
      case "0.5":
        _tt_05(infested_plants, stops);
        break;
    }

    setState(() {

      for(int i=0;i<3;i++){
        val[i] = false;
      }

      print(infested_plants);
    });
  }

  void _onReset(){

    infested_plants = 0;
    stops = 0;
    checked_plants = 0;
    result = "Start Sampling";

    setState(() {
//      infested_plants.toString();
//      stops.toString();

      for(int i=0;i<3;i++){
        val[i] = false;
      }
    });
  }

  // Save data to database
  void _onSave() async {

    treatment_record.title = fieldTitle;
    treatment_record.result = result;
    treatment_record.stops = stops;
    treatment_record.date = DateFormat.yMMMd().format(DateTime.now());
    int resultF;
    if (treatment_record.id != null) {  // Case 1: Update operation
      resultF = await helper.updateTreatmentRecord(treatment_record);
    } else { // Case 2: Insert Operation
      resultF = await helper.insertTreatmentRecord(treatment_record);
    }

    Navigator.pop(context, true);

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving');
    }

  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

//------------------------------------------------------------------
  _tt_02(int total, int stops){ // 0.20 tt
    if(stops<= 3){// less than 3 stops
      result = "Keep Sampling";
    }
    else if(stops>=4 && stops<=5){ // 4-5 stops
      if(total == 0)
        result = "Dont Treat";
      else if(total>=1 && total<=3)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops>=6 && stops<=7){ //6-7 stops
      if(total <= 1)
        result = "Dont Treat";
      else if(total>=2 && total<=4)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops>=8 && stops<=9){ // 8-9 stops
      if(total <= 2)
        result = "Dont Treat";
      else if(total>=3 && total<=5)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops>=10 && stops<=11){ // 10-11 stops
      if(total <= 3)
        result = "Dont Treat";
      else if(total>=4 && total<=6)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops>=12 && stops<=13){ // 12-13 stops
      if(total <= 4)
        result = "Dont Treat";
      else if(total>=5 && total<=7)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops>=14 && stops<=15){ // 14-15 stops
      if(total <= 5)
        result = "Dont Treat";
      else if(total>=6 && total<=8)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==16){ // 16 stops
      if(total <= 6)
        result = "Dont Treat";
      else if(total>=7 && total<=9)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else // more than 16 stops
      result = "Return in 2-3 days";
  }

  //------------------------------------------------------------------
  _tt_025(int total, int stops){ // 0.25 tt
    if(stops<= 3) { // less than 3 stops
      result = "Keep Sampling";
    }
    else if(stops==4 ){ // 4 stops
      if(total == 0)
        result = "Dont Treat";
      else if(total>=1 && total<=3)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==5){ //5 stops
      if(total <= 1)
        result = "Dont Treat";
      else if(total>=2 && total<=4)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==6 ){ // 6 stops
      if(total <= 1)
        result = "Dont Treat";
      else if(total>=2 && total<=5)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==7){ // 7 stops
      if(total <= 2)
        result = "Dont Treat";
      else if(total>=3 && total<=5)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==8){ // 8 stops
      if(total <= 3)
        result = "Dont Treat";
      else if(total>=4 && total<=6)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==9){ // 9 stops
      if(total <= 4)
        result = "Dont Treat";
      else if(total>=5 && total<=7)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==10){ // 10 stops
      if(total <= 6)
        result = "Dont Treat";
      else if(total>=7 && total<=9)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==11){ // 11 stops
      if(total <= 5)
        result = "Dont Treat";
      else if(total>=6 && total<=8)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==12){ // 12 stops
      if(total <= 6)
        result = "Dont Treat";
      else if(total>=7 && total<=9)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==13){ // 13 stops
      if(total <= 7)
        result = "Dont Treat";
      else if(total>=8 && total<=10)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==14){ // 14 stops
      if(total <= 7)
        result = "Dont Treat";
      else if(total>=8 && total<=11)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==15){ // 15 stops
      if(total <= 8)
        result = "Dont Treat";
      else if(total>=9 && total<=11)
        result = "Keep Sampling";
      else
        result = "Treat";
    }else if(stops==16){ // 16 stops
      if(total <= 9)
        result = "Dont Treat";
      else if(total>=10 && total<=912)
        result = "Keep Sampling";
      else
        result = "Treat";
    }
    else // more than 16 stops
      result = "Return in 2-3 days";


  }
//------------------------------------------------------------------
  _tt_03(int total, int stops){ // 0.30 tt
    if(stops<= 3){// less than 3 stops
      result = "Keep Sampling";
    }
    else if(stops==4){ // 4 stops
      if(total <=1)
        result = "Dont Treat";
      else if(total>=2 && total<=5)
        result = "Keep Sampling";
      else if(total>=6)
        result = "Treat";
    }
    else if(stops==5){ // 5 stops
      if(total <=2)
        result = "Dont Treat";
      else if(total>=3 && total<=6)
        result = "Keep Sampling";
      else if(total>=7)
        result = "Treat";
    }
    else if(stops==6){ // 6 stops
      if(total <=2)
        result = "Dont Treat";
      else if(total>=3 && total<=7)
        result = "Keep Sampling";
      else if(total>=8)
        result = "Treat";
    }
    else if(stops==7){ // 7 stops
      if(total <=3)
        result = "Dont Treat";
      else if(total>=4 && total<=7)
        result = "Keep Sampling";
      else if(total>=8)
        result = "Treat";
    }
    else if(stops==8){ // 8 stops
      if(total <=4)
        result = "Dont Treat";
      else if(total>=5 && total<=8)
        result = "Keep Sampling";
      else if(total>=9)
        result = "Treat";
    }
    else if(stops==9){ // 9 stops
      if(total <=5)
        result = "Dont Treat";
      else if(total>=6 && total<=9)
        result = "Keep Sampling";
      else if(total>=10)
        result = "Treat";
    }
    else if(stops==10){ // 10 stops
      if(total <=6)
        result = "Dont Treat";
      else if(total>=7 && total<=10)
        result = "Keep Sampling";
      else if(total>=11)
        result = "Treat";
    }
    else if(stops==11){ // 11 stops
      if(total <=7)
        result = "Dont Treat";
      else if(total>=8 && total<=11)
        result = "Keep Sampling";
      else if(total>=12)
        result = "Treat";
    }
    else if(stops==12){ // 12 stops
      if(total <=8)
        result = "Dont Treat";
      else if(total>=9 && total<=12)
        result = "Keep Sampling";
      else if(total>=13)
        result = "Treat";
    }
    else if(stops==13){ // 13 stops
      if(total <=9)
        result = "Dont Treat";
      else if(total>=10 && total<=13)
        result = "Keep Sampling";
      else if(total>=14)
        result = "Treat";
    }
    else if(stops==14){ // 14 stops
      if(total <=9)
        result = "Dont Treat";
      else if(total>=10 && total<=14)
        result = "Keep Sampling";
      else if(total>=15)
        result = "Treat";
    }
    else if(stops==15){ // 15 stops
      if(total <=10)
        result = "Dont Treat";
      else if(total>=11 && total<=14)
        result = "Keep Sampling";
      else if(total>=15)
        result = "Treat";
    }
    else if(stops==16){ // 16 stops
      if(total <=11)
        result = "Dont Treat";
      else if(total>=12 && total<=15)
        result = "Keep Sampling";
      else if(total>=16)
        result = "Treat";
    }
    else
      result = "Return in 2-3 Days";
  }
//------------------------------------------------------------------//

  _tt_035(int total, int stops){ // 0.35 tt
    if(stops<= 3){// less than 3 stops
      result = "Keep Sampling";
    }
    else if(stops==4){ // 4 stops
      if(total <=1)
        result = "Dont Treat";
      else if(total>=2 && total<=6)
        result = "Keep Sampling";
      else if(total>=7)
        result = "Treat";
    }
    else if(stops==5){ // 5 stops
      if(total <=2)
        result = "Dont Treat";
      else if(total>=3 && total<=7)
        result = "Keep Sampling";
      else if(total>=8)
        result = "Treat";
    }
    else if(stops==6){ // 6 stops
      if(total <=3)
        result = "Dont Treat";
      else if(total>=4 && total<=8)
        result = "Keep Sampling";
      else if(total>=9)
        result = "Treat";
    }
    else if(stops==7){ // 7 stops
      if(total <=4)
        result = "Dont Treat";
      else if(total>=5 && total<=9)
        result = "Keep Sampling";
      else if(total>=10)
        result = "Treat";
    }
    else if(stops==8){ // 8 stops
      if(total <=5)
        result = "Dont Treat";
      else if(total>=6 && total<=10)
        result = "Keep Sampling";
      else if(total>=11)
        result = "Treat";
    }
    else if(stops==9){ // 9 stops
      if(total <=6)
        result = "Dont Treat";
      else if(total>=7 && total<=11)
        result = "Keep Sampling";
      else if(total>=12)
        result = "Treat";
    }
    else if(stops==10){ // 10 stops
      if(total <=7)
        result = "Dont Treat";
      else if(total>=8 && total<=12)
        result = "Keep Sampling";
      else if(total>=13)
        result = "Treat";
    }
    else if(stops==11){ // 11 stops
      if(total <=8)
        result = "Dont Treat";
      else if(total>=9 && total<=13)
        result = "Keep Sampling";
      else if(total>=14)
        result = "Treat";
    }
    else if(stops==12){ // 12 stops
      if(total <=9)
        result = "Dont Treat";
      else if(total>=10 && total<=14)
        result = "Keep Sampling";
      else if(total>=15)
        result = "Treat";
    }
    else if(stops==13){ // 13 stops
      if(total <=10)
        result = "Dont Treat";
      else if(total>=11 && total<=15)
        result = "Keep Sampling";
      else if(total>=16)
        result = "Treat";
    }
    else if(stops==14){ // 14 stops
      if(total <=11)
        result = "Dont Treat";
      else if(total>=12 && total<=16)
        result = "Keep Sampling";
      else if(total>=17)
        result = "Treat";
    }
    else if(stops==15){ // 15 stops
      if(total <=12)
        result = "Dont Treat";
      else if(total>=13 && total<=17)
        result = "Keep Sampling";
      else if(total>=18)
        result = "Treat";
    }
    else if(stops==16){ // 16 stops
      if(total <=13)
        result = "Dont Treat";
      else if(total>=14 && total<=18)
        result = "Keep Sampling";
      else if(total>=19)
        result = "Treat";
    }
    else
      result = "Return in 2-3 Days";
  }
//------------------------------------------------------------------//

  _tt_04(int total, int stops){ // 0.40 tt
    if(stops<= 3){// less than 3 stops
      result = "Keep Sampling";
    }
    else if(stops==4){ // 4 stops
      if(total <=1)
        result = "Dont Treat";
      else if(total>=2 && total<=7)
        result = "Keep Sampling";
      else if(total>=8)
        result = "Treat";
    }
    else if(stops==5){ // 5 stops
      if(total <=2)
        result = "Dont Treat";
      else if(total>=3 && total<=8)
        result = "Keep Sampling";
      else if(total>=9)
        result = "Treat";
    }
    else if(stops==6){ // 6 stops
      if(total <=3)
        result = "Dont Treat";
      else if(total>=4 && total<=9)
        result = "Keep Sampling";
      else if(total>=10)
        result = "Treat";
    }
    else if(stops==7){ // 7 stops
      if(total <=5)
        result = "Dont Treat";
      else if(total>=6 && total<=10)
        result = "Keep Sampling";
      else if(total>=11)
        result = "Treat";
    }
    else if(stops==8){ // 8 stops
      if(total <=6)
        result = "Dont Treat";
      else if(total>=7 && total<=11)
        result = "Keep Sampling";
      else if(total>=12)
        result = "Treat";
    }
    else if(stops==9){ // 9 stops
      if(total <=7)
        result = "Dont Treat";
      else if(total>=8 && total<=13)
        result = "Keep Sampling";
      else if(total>=14)
        result = "Treat";
    }
    else if(stops==10){ // 10 stops
      if(total <=8)
        result = "Dont Treat";
      else if(total>=9 && total<=14)
        result = "Keep Sampling";
      else if(total>=15)
        result = "Treat";
    }
    else if(stops==11){ // 11 stops
      if(total <=9)
        result = "Dont Treat";
      else if(total>=10 && total<=15)
        result = "Keep Sampling";
      else if(total>=16)
        result = "Treat";
    }
    else if(stops==12){ // 12 stops
      if(total <=10)
        result = "Dont Treat";
      else if(total>=11 && total<=16)
        result = "Keep Sampling";
      else if(total>=17)
        result = "Treat";
    }
    else if(stops==13){ // 13 stops
      if(total <=12)
        result = "Dont Treat";
      else if(total>=13 && total<=18)
        result = "Keep Sampling";
      else if(total>=19)
        result = "Treat";
    }
    else if(stops==13){ // 14 stops
      if(total <=9)
        result = "Dont Treat";
      else if(total>=14 && total<=19)
        result = "Keep Sampling";
      else if(total>=20)
        result = "Treat";
    }
    else if(stops==15){ // 15 stops
      if(total <=14)
        result = "Dont Treat";
      else if(total>=15 && total<=20)
        result = "Keep Sampling";
      else if(total>=21)
        result = "Treat";
    }
    else if(stops==16){ // 16 stops
      if(total <=15)
        result = "Dont Treat";
      else if(total>=16 && total<=21)
        result = "Keep Sampling";
      else if(total>=22)
        result = "Treat";
    }
    else
      result = "Return in 2-3 Days";
  }
//------------------------------------------------------------------//

  _tt_045(int total, int stops){ // 0.45 tt
  if(stops<= 3){// less than 3 stops
    result = "Keep Sampling";
  }
  else if(stops==4){ // 4 stops
    if(total <=2)
      result = "Dont Treat";
    else if(total>=3 && total<=8)
      result = "Keep Sampling";
    else if(total>=9)
      result = "Treat";
  }
  else if(stops==5){ // 5 stops
    if(total <=3)
      result = "Dont Treat";
    else if(total>=4 && total<=9)
      result = "Keep Sampling";
    else if(total>=10)
      result = "Treat";
  }
  else if(stops==6){ // 6 stops
    if(total <=4)
      result = "Dont Treat";
    else if(total>=5 && total<=10)
      result = "Keep Sampling";
    else if(total>=11)
      result = "Treat";
  }
  else if(stops==7){ // 7 stops
    if(total <=6)
      result = "Dont Treat";
    else if(total>=7 && total<=11)
      result = "Keep Sampling";
    else if(total>=12)
      result = "Treat";
  }
  else if(stops==8){ // 8 stops
    if(total <=7)
      result = "Dont Treat";
    else if(total>=8 && total<=12)
      result = "Keep Sampling";
    else if(total>=13)
      result = "Treat";
  }
  else if(stops==9){ // 9 stops
    if(total <=9)
      result = "Dont Treat";
    else if(total>=10 && total<=14)
      result = "Keep Sampling";
    else if(total>=15)
      result = "Treat";
  }
  else if(stops==10){ // 10 stops
    if(total <=10)
      result = "Dont Treat";
    else if(total>=11 && total<=15)
      result = "Keep Sampling";
    else if(total>=16)
      result = "Treat";
  }
  else if(stops==11){ // 11 stops
    if(total <=11)
      result = "Dont Treat";
    else if(total>=12 && total<=17)
      result = "Keep Sampling";
    else if(total>=18)
      result = "Treat";
  }
  else if(stops==12){ // 12 stops
    if(total <=12)
      result = "Dont Treat";
    else if(total>=13 && total<=18)
      result = "Keep Sampling";
    else if(total>=19)
      result = "Treat";
  }
  else if(stops==13){ // 13 stops
    if(total <=14)
      result = "Dont Treat";
    else if(total>=15 && total<=20)
      result = "Keep Sampling";
    else if(total>=21)
      result = "Treat";
  }
  else if(stops==14){ // 14 stops
    if(total <=15)
      result = "Dont Treat";
    else if(total>=16 && total<=21)
      result = "Keep Sampling";
    else if(total>=22)
      result = "Treat";
  }
  else if(stops==15){ // 15 stops
    if(total <=17)
      result = "Dont Treat";
    else if(total>=18 && total<=22)
      result = "Keep Sampling";
    else if(total>=23)
      result = "Treat";
  }
  else if(stops==16){ // 16 stops
    if(total <=18)
      result = "Dont Treat";
    else if(total>=19 && total<=23)
      result = "Keep Sampling";
    else if(total>=24)
      result = "Treat";
  }
  else
    result = "Return in 2-3 Days";
}

//------------------------------------------------------------------//

  _tt_05(int total, int stops){ // 0.50 tt
    if(stops<= 3){// less than 3 stops
      result = "Keep Sampling";
    }
    else if(stops==4){ // 4 stops
      if(total <=3)
        result = "Dont Treat";
      else if(total>=4 && total<=8)
        result = "Keep Sampling";
      else if(total>=9)
        result = "Treat";
    }
    else if(stops==5){ // 5 stops
      if(total <=5)
        result = "Dont Treat";
      else if(total>=6 && total<=10)
        result = "Keep Sampling";
      else if(total>=11)
        result = "Treat";
    }
    else if(stops==6){ // 6 stops
      if(total <=6)
        result = "Dont Treat";
      else if(total>=7 && total<=11)
        result = "Keep Sampling";
      else if(total>=12)
        result = "Treat";
    }
    else if(stops==7){ // 7 stops
      if(total <=8)
        result = "Dont Treat";
      else if(total>=9 && total<=13)
        result = "Keep Sampling";
      else if(total>=14)
        result = "Treat";
    }
    else if(stops==8){ // 8 stops
      if(total <=9)
        result = "Dont Treat";
      else if(total>=10 && total<=14)
        result = "Keep Sampling";
      else if(total>=15)
        result = "Treat";
    }
    else if(stops==9){ // 9 stops
      if(total <=11)
        result = "Dont Treat";
      else if(total>=12 && total<=16)
        result = "Keep Sampling";
      else if(total>=17)
        result = "Treat";
    }
    else if(stops==10){ // 10 stops
      if(total <=12)
        result = "Dont Treat";
      else if(total>=13 && total<=17)
        result = "Keep Sampling";
      else if(total>=18)
        result = "Treat";
    }
    else if(stops==11){ // 11 stops
      if(total <=14)
        result = "Dont Treat";
      else if(total>=15 && total<=19)
        result = "Keep Sampling";
      else if(total>=20)
        result = "Treat";
    }
    else if(stops==12){ // 12 stops
      if(total <=15)
        result = "Dont Treat";
      else if(total>=16 && total<=20)
        result = "Keep Sampling";
      else if(total>=21)
        result = "Treat";
    }
    else if(stops==13){ // 13 stops
      if(total <=17)
        result = "Dont Treat";
      else if(total>=18 && total<=22)
        result = "Keep Sampling";
      else if(total>=23)
        result = "Treat";
    }
    else if(stops==14){ // 14 stops
      if(total <=18)
        result = "Dont Treat";
      else if(total>=19 && total<=23)
        result = "Keep Sampling";
      else if(total>=24)
        result = "Treat";
    }
    else if(stops==15){ // 15 stops
      if(total <=20)
        result = "Dont Treat";
      else if(total>=21 && total<=25)
        result = "Keep Sampling";
      else if(total>=26)
        result = "Treat";
    }
    else if(stops==16){ // 16 stops
      if(total <=21)
        result = "Dont Treat";
      else if(total>=22 && total<=26)
        result = "Keep Sampling";
      else if(total>=27)
        result = "Treat";
    }
    else
      result = "Return in 2-3 Days";
  }

}



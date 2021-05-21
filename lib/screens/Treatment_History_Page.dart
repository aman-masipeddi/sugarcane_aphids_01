import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sugarcanaphids01/utils/database_helper.dart';
import 'package:sugarcanaphids01/models/treatment_record.dart';

class TreatmentHistoryPage extends StatefulWidget {
  TreatmentHistoryPage();

  @override
  _TreatmentHistoryPageState createState() => _TreatmentHistoryPageState ();
}

class _TreatmentHistoryPageState extends State<TreatmentHistoryPage>  {

  _TreatmentHistoryPageState();

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Treatment_Record> treatmentRecordList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (treatmentRecordList == null) {
      treatmentRecordList = [];
      updateListView();
    }

    return Scaffold(

      appBar: AppBar(
        title: Text("Sample Results"),
      ),

      body: getTreatmentRecordListView(),
    );
  }

  ListView getTreatmentRecordListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subtitle2;

    return ListView.builder(
      itemCount: count,
      reverse: true,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getTreatmentColor(this.treatmentRecordList[position].result),
            ),

            title: Text(this.treatmentRecordList[position].title, style: titleStyle,),

            subtitle: Text(this.treatmentRecordList[position].date),

            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                Text("Stops: "+this.treatmentRecordList[position].stops.toString(), style: titleStyle,),
                Text(this.treatmentRecordList[position].result, style: titleStyle,),
                GestureDetector(
                  child: Icon(Icons.delete, color: Colors.redAccent, size: 30,),
                  onTap: () {
                    _delete(context, treatmentRecordList[position]);
                  },
                ),
              ],
            ),

            /*onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.noteList[position],'Edit Note');
            },*/

          ),
        );
      },
    );
  }

  Color getTreatmentColor(String result) {
    switch (result) {
      case "Dont Treat":
        return Colors.green;
        break;
      case "Treat":
        return Colors.red;
        break;
    }
  }


  void _delete(BuildContext context, Treatment_Record treatmentRecord) async {

    int result = await databaseHelper.deleteTreatmentRecord(treatmentRecord.id);
    if (result != 0) {
      _showSnackBar(context, 'Record Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Treatment_Record>> noteListFuture = databaseHelper.getTreatmentRecordList();
      noteListFuture.then((treatmentRecordList) {
        setState(() {
          this.treatmentRecordList = treatmentRecordList;
          this.count = treatmentRecordList.length;
        });
      });
    });
  }
}
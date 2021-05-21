import 'package:flutter/material.dart';
import 'package:link/link.dart';

class InstructionsPage extends StatefulWidget {

  InstructionsPage();

  @override
  _InstructionsPageState createState() => _InstructionsPageState ();
}

class _InstructionsPageState extends State<InstructionsPage>  {
  _InstructionsPageState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Instructions"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text("This application will help determine if a sorghum field infested with sugarcane aphid should be treated with an insecticide, based on an economic (treatment) threshold. The user selects a treatment threshold based on the crop’s yield potential, potential grain price, and cost of control. The user examines sets of 2-leaf samples per plant and estimates infested plants.",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.justify,),
            SizedBox(height: 20,),
            Text("Collect samples from randomly selected plants that are spaced at least 20 feet apart. One sample consists of 2 fully expanded leaves that have 90% green leaf area: one from the top and one from the bottom of a plant. The two-leaf sample must have more than 50 aphids combined to be considered infested. The first example shows a leaf containing ca. 25 aphids within the yellow circle (ca. 40 aphids total). The second photo shows one leaf with ca. 50 aphids within the white circle (ca. more than 200 total). If the threshold is exceeded, the app will say that the field needs to be treated with an insecticide or not treated.",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.justify, ),
            SizedBox(height: 20,),
            Image.asset('assets/images/Sorghum_Plant.png', width: 200, height: 200),
            SizedBox(height: 7,),
            Text("This is the Sorghum plant image", style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,)

          ],
        ),
      ),
    );
  }


}
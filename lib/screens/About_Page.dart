import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:link/link.dart';

class AboutPage extends StatefulWidget {

  AboutPage();

  @override
  _AboutPageState createState() => _AboutPageState ();
}

class _AboutPageState extends State<AboutPage>  {
  _AboutPageState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
        title: Text("About the App"),
    ),

    body:SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
              children: <Widget>[
                Text("This application determines if an infestation of sugarcane aphid in sorghum should be treated. Please select a treatment threshold based on your crop’s expected yield potential, potential grain price, and cost of control. Sample the field by examining sets of 2-leaf samples for each plant. The app will tell you if a field should be treated, or should not be treated.",
                  style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,),
                SizedBox(height: 40,),
                Text("INFORMATION", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("Please contact your local Extension Educator, Agriculture for information related to your sorghum production needs.", style: TextStyle(fontSize: 15) ,textAlign: TextAlign.justify,),
                SizedBox(height: 15,),
                Align(
                  alignment: Alignment.topLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text("Extension Specialist Contact Details:", textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold) ),
                ),
                SizedBox(height: 5,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Tom Royer - Extension Entomologist, IPM.\nPhone: 405-744-9406\nEmail:tom.royer@okstate.edu") ,
                ),
                SizedBox(height: 40,),
                Text("HELPFUL LINKS", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Link(
                  child: Text('https://extension.okstate.edu/fact-sheets/management-of-insect-and-mite-pests-in-sorghum.html#sugarcane-aphid', style: TextStyle(color: Colors.blue),),
                  url: 'https://extension.okstate.edu/fact-sheets/management-of-insect-and-mite-pests-in-sorghum.html#sugarcane-aphid',
                  onError: _showErrorSnackBar,
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Link(
                    child: Text('https://extension.okstate.edu/county/index.html', style: TextStyle(color: Colors.blue),),
                    url: 'https://extension.okstate.edu/county/index.html',
                    onError: _showErrorSnackBar,
                  ),
                ),
                SizedBox(height: 40,),
                Text("DEVELOPMENT TEAM", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("This App was developed with financial support provided by the U.S. Department of Agriculture National Institute of Food and Agriculture&#39;s Crop Protection and Pest Management Applied Research and Development Program (grant no. 2015-7006-24259/project accession no. 1007751 and the Extension Implementation Program (grant no. 2017-7006-27282/project accession no. 1014126).",
                  style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,),
                SizedBox(height: 15,),
                Align(
                  alignment: Alignment.topLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text("Developers:", textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold) ),
                ),
                SizedBox(height: 5,),
                Text("Aman Masipeddi(Programmer), Tom A. Royer(Extension Entomologist) and Brian Arnall(Oklahoma State University). Contributors: Jessica Lindenmayer (Trécé Incorporated), Kristopher Giles(Oklahoma State University) , Norman C. Elliott (USDA ARS), Allen Knutson (Texas A&M Agrilife Research and Extension), Robert Bowling (Texas A&amp;M Agrilife Research and Extension) Nicholas J. Seiter(University of Arkansas Research and Extension), Brian McCornack (Kansas State University), Sebe A.Brown (Louisiana State University).",
                  style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,),
                SizedBox(height: 10,),
                Image.asset('assets/images/Sorghum_Plant.png', width: 200, height: 200),
                SizedBox(height: 7,),
                Text("This is the Sorghum plant image", style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,)
              ]
          )
      ),
    )
    );
  }

  void _showErrorSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Oops... the URL couldn\'t be opened!'),
      ),
    );
  }
}
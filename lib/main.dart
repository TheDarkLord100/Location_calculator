import 'package:flutter/material.dart';
import 'dart:math' as Math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  double? lat = 0, long = 0, angle, dist;
  double? newLAT = 0.0, newLONG;


  @override

  void getloc(){
     double latRad = lat! * Math.pi / 180;
     double longRad = long! * Math.pi / 180;
     const R = 6371;
     double angD = (dist! / 1000 ) / R;
     
     double angRad = angle! * Math.pi / 180;
     
     double lat2Rad = Math.asin( 
       Math.sin(latRad) * Math.cos(angD) + Math.cos(latRad) * Math.sin(angD) * Math.cos(angRad)
     );
     
     double long2Rad = longRad + Math.atan2(Math.sin(angRad) * Math.sin(angD) * Math.cos(latRad),
         Math.cos(angD) - Math.sin(latRad) * Math.sin(lat2Rad));

     setState(() {
       newLAT = lat2Rad * 180 / Math.pi;
       newLONG = long2Rad * 180 / Math.pi;
     });
  }

  void _latitude(String input) {
    lat = double.tryParse(input);
  }

  void _longitude(String input) {
    long = double.tryParse(input);
  }

  void _bearing(String input)  {
    angle = double.tryParse(input);
  }

  void _distance(String input) {
    dist = double.tryParse(input);
  }

  Widget _inputCoordinate() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Latitude'
              ),
              keyboardType: TextInputType.number,
              onChanged: _latitude,
              onSubmitted: _latitude,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Longitude'
              ),
              keyboardType: TextInputType.number,
              onChanged: _longitude,
              onSubmitted: _longitude,
            ),
          ),
        )
      ],
    );
  }

  Widget _inputAngle() {
    return Expanded(
      child: Container(
          margin: EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter bearings in degrees'
            ),
            keyboardType: TextInputType.number,
            onChanged: _bearing,
            onSubmitted: _bearing,
          ),
      ),
    );
  }

  Widget _inputDistance() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(15),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Distance in metres'
          ),
          keyboardType: TextInputType.number,
          onChanged: _distance,
          onSubmitted: _distance,
        ),
      ),
    );
  }

  Widget _submit() {
    return Container(
      child: TextButton(
        child: Text('SUBMIT'),
        onPressed: getloc,
      ),
    );
  }

  Widget _result(){
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text( newLAT.toString()
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text( newLONG.toString()
            ),
          ),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Distance Locator'),
        ),
        body: Column(
          children: <Widget>[
            _inputCoordinate(),
            _inputAngle(),
            _inputDistance(),
            _submit(),
            Divider(height: 50),
            Expanded(child: _result())
        ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class Intro2 extends StatelessWidget{
  Intro2({super.key});
  
  @override Widget build(BuildContext context){
    return Container(  
      color: Colors.teal,         
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column( children: [
        SizedBox(height: 50),
        Text("This is a WORK IN PROGRESS",
        style: TextStyle(color: Colors.yellow, fontSize: 20)),
        SizedBox(height: 20),
        Text("GOTO YOUR PHONE SETTINGS",
        style: TextStyle(color: Colors.yellow, fontSize: 20)),
        SizedBox(height: 20),
        Text("GIVE THIS APP LOCATION PERMISSION",
        style: TextStyle(color: Colors.yellow, fontSize: 20)),
        SizedBox(height: 20),
        Text("TURN ON YOUR PHONES BLUETOOTH",
        style: TextStyle(color: Colors.yellow, fontSize: 20)),
        SizedBox(height: 40),
        
        Text("FINDING HM-19",
        style: TextStyle(color: Colors.yellow, fontSize: 20)),
        SizedBox(height: 20),
        Text("BLUETOOTH MAC ADDRESS",
        style: TextStyle(color: Colors.yellow, fontSize: 20)),
        SizedBox(height: 20), 
        Text("INSTALL NRF CONNECT APP",
        style: TextStyle(color: Colors.yellow, fontSize: 20)),
        SizedBox(height: 20),
        Text("FROM GOOGLE PLAYSTORE",
        style: TextStyle(color: Colors.yellow, fontSize: 20)),
        SizedBox(height: 20),
        Text("SCAN AND FIND YOUR MODULE HM-19",
        style: TextStyle(color: Colors.yellow, fontSize: 20)),
        SizedBox(height: 20),        
      ]));}}

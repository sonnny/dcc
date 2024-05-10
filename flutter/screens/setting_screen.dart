import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dcc_controller.dart';

class SettingScreen extends StatelessWidget {

@override Widget build(BuildContext context) {

final DCCController dcc = Get.put(DCCController());
TextEditingController bleMac = TextEditingController(text: 'A4:DA:32:55:06:1E');
TextEditingController loco1 = TextEditingController(text: '14');
TextEditingController loco2 = TextEditingController(text: '15');
TextEditingController loco3 = TextEditingController(text: '17');

return Column(children: [
 
  /////////////////////////////////
  ////////// set ble mac address
  //Text('BLE mac address'),
  SizedBox(height:10),
  Row(children: [
    Padding(padding: EdgeInsets.all(5.0), child: Container(color: Colors.blue[50],
    width:220,height:60,child: TextField(decoration: 
    InputDecoration(border: OutlineInputBorder(), labelText: "BLE MAC"), controller: bleMac,
    style: TextStyle(fontSize:20)))),
    SizedBox(width:20),
    ElevatedButton(onPressed:(){ dcc.setBleMac(bleMac.text);}, child: Text("set"))]),
    
  SizedBox(height:30),

  ///////////////////////////////////
  ////////////// set loco1 address
  Row(children: [
    Padding(padding: EdgeInsets.all(10.0), child: Container(color: Colors.red[50],
    width:120,height:45, child: TextField(textAlign: TextAlign.center, decoration: 
      InputDecoration(border: OutlineInputBorder(), labelText: "Loco 1 address:"), controller: loco1,
      style: TextStyle(fontSize:20)))),
    SizedBox(width:10),
    ElevatedButton(onPressed:(){ dcc.setLoco1(loco1.text);}, child: Text("set")),
  ]),
    
  SizedBox(height:30),
  
  ///////////////////////////////
  //////////// set loco2 address
  Row(children: [
    Padding(padding: EdgeInsets.all(10.0), child: Container(color: Colors.teal[50],
      width:120,height:45, child: TextField(textAlign: TextAlign.center, decoration: 
      InputDecoration(border: OutlineInputBorder(), labelText: "Loco 2 address:"), controller: loco2,
      style: TextStyle(fontSize:20)))),
    SizedBox(width:10),
    ElevatedButton(onPressed:(){ dcc.setLoco2(loco2.text);}, child: Text("set")),
  ]),

  SizedBox(height:30),
  
  /////////////////////////////
  /////////// set loco3 address
  Row(children: [
    Padding(padding: EdgeInsets.all(10.0), child: Container(color: Colors.teal[50],
      width:120,height:45, child: TextField(textAlign: TextAlign.center, decoration: 
      InputDecoration(border: OutlineInputBorder(), labelText: "Loco 3 address:"), controller: loco3,
      style: TextStyle(fontSize:20)))),
    SizedBox(width:10),
    ElevatedButton(onPressed:(){ dcc.setLoco3(loco3.text);}, child: Text("set")),
 ])   
    
]);}}


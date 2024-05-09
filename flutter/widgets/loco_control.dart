//
// loco_control.dart
//   creates loco control (address label, direction, speed slider, emergency stop)
//
// must pass loco label
// must pass loco address
// must pass bluetooth controller
// 

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../controllers/blecontroller.dart';

TextStyle myStyle = TextStyle(fontSize: 20);
TextStyle myLabel = TextStyle(color: Colors.green, fontSize: 15, fontWeight:FontWeight.bold, fontStyle:FontStyle.italic);

class LocoControl extends StatefulWidget {
  final String locoLabel;
  final String locoAddress;
  final BleController ble;
  LocoControl({Key? key, required this.locoAddress, required this.ble, required this.locoLabel})
    :super(key: key);
  @override State<LocoControl> createState() => _LocoControl();}

class _LocoControl extends State<LocoControl> {
_LocoControl();

double loco1Speed = 0.0;
double loco2Speed = 0.0;
bool loco1Direction = true;
bool loco2Direction = true;
bool trackPower = false;

@override Widget build(BuildContext context){

  return( 
 
      ////////// start of locomotive controls
      Expanded(child: Container(height: 490.0, child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,      
        children: [
        
          ///// loco label and address        
          Padding(padding: EdgeInsets.fromLTRB(20,0,5,0), child: Row(children: [ Text(widget.locoLabel,style:myLabel),
            Container(padding: EdgeInsets.all(4),
              decoration: BoxDecoration(border:Border.all(color:Colors.purple)),
              child:Text(widget.locoAddress,style:myStyle))
            
          ])),

          ///// toggle lights function 0 and function 4
          Row(children:[
            IconButton(icon: Icon(Icons.lightbulb),
              iconSize: 35.0, onPressed:(){ widget.ble.sendData('+lf ' + widget.locoAddress + ' 0 ~'+'\r');}),
            IconButton(icon: Icon(Icons.light_mode),
              iconSize: 20.0, onPressed:(){ widget.ble.sendData('+lf ' + widget.locoAddress + ' 9 ~'+'\r');})
          ]),            
                
          ///// direction button
          Padding(padding: EdgeInsets.fromLTRB(10,0,0,0), child: Row(children: [ Text('Dir: '),
            IconButton(icon: loco1Direction
              ? Icon(Icons.arrow_forward, color:Colors.green, size:40)
              : Icon(Icons.arrow_back, color:Colors.red, size:40),
              onPressed:(){ setState((){ 
                widget.ble.sendData('+ld ' + widget.locoAddress +' ~'+'\r');
              loco1Direction = !loco1Direction;
             });
          })])),

          ///// speed slider only transmit final value when user let go of slider
          Container(height: 270, child: SfSlider.vertical(min: 0.0, max: 30.0, value: loco1Speed, interval: 2,
            showTicks: true, showLabels: true, enableTooltip: true,
            minorTicksPerInterval: 1,
            onChanged: (dynamic value) {
              setState(() { loco1Speed = value;});},
            onChangeEnd: (dynamic value) { 
              setState(() {
              widget.ble.sendData('+ls ' + widget.locoAddress + ' ' + value.round().toString() + '\r');
              });})),

          ///// emergency stop
          IconButton(icon: Icon(Icons.hexagon), color: Colors.red,
            iconSize: 40.0, onPressed:(){ setState(() { 
              widget.ble.sendData('+ls ' + widget.locoAddress + ' 0\r'); loco1Speed = 0.0;});}),
      ]))));}}

// control_screen.dart
//   layout:
//     bluetooth mac address label
//     bluetooth icon to connect
//     track switch icon to energize track power
//     3 locomotive control with sliders
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../controllers/dcc_controller.dart';
import '../controllers/blecontroller.dart';
import '../widgets/loco_control.dart';

TextStyle myStyle = TextStyle(fontSize: 20);
TextStyle myLabel = TextStyle(color: Colors.green, fontSize: 15, fontWeight:FontWeight.bold, fontStyle:FontStyle.italic);

class ControlScreen extends StatefulWidget {
  ControlScreen({Key? key}):super(key: key);
  @override State<ControlScreen> createState() => _ControlScreen();}

class _ControlScreen extends State<ControlScreen> {
_ControlScreen();
  
bool trackPower = false;

@override Widget build(BuildContext context) {

final DCCController dcc = Get.put(DCCController());
final BleController ble = Get.put(BleController());

return Column(children: [

  //////////////////////////////////////////////////////
  // ble mac address, ble icon to connect to bluetooth
  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [  
    Padding(padding: EdgeInsets.fromLTRB(15,5,5,0), child: SizedBox(width: 150, 
      child: Obx(() => Text('${dcc.bleMac.value}')))),
    SizedBox(width:5),
    IconButton(icon: Icon(Icons.bluetooth), color: Colors.blue,
      iconSize: 40.0, onPressed:(){ 
      ble.connect();
      showDialog(context: context, builder:(ctx) => AlertDialog(
        title: Text('Bluetooth',style:TextStyle(color:Colors.blue)),
          content: Text('red led on the ble should stay lit if connected successfully'),
          actions: <Widget>[TextButton(
            onPressed:(){ Navigator.of(ctx).pop();},
            child: Text('OK',style:TextStyle(color:Colors.red)))]));}), 
 
    SizedBox(width:5),
    
    /////////////////////////////////////////////
    // track switch, to turn on power to track
    Text('track: '),
    Switch(value: trackPower, activeColor: Colors.green,
      onChanged:(bool v){ setState(() {
        if (v) ble.sendData('+mte t\r');
        if (!v) ble.sendData('+mte f\r');
        trackPower = v;});
        showDialog(context: context, builder:(ctx) => AlertDialog(
        title: Text('Track Power',style:TextStyle(color:Colors.blue)),
          content: Text('green led on the pico (not picow) should stay lit if track power is energized'),
          actions: <Widget>[TextButton(
            onPressed:(){ Navigator.of(ctx).pop();},
            child: Text('OK',style:TextStyle(color:Colors.red)))]));       
        
        }),
  ]),
    
    SizedBox(height:8),
    
    
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  
    ///////////////////////////////////////////////////////////////////////////
    // train control 1 must pass loco label, address, and bluetooth controller
    LocoControl(
      locoLabel: 'loco 1  ',
      locoAddress: '${dcc.loco1.value}',
      ble: ble),

    ////////////////////////////////////////////////////////////////////////////
    // train control 2 must pass loco label, address, and bluetooth controller
    LocoControl(
      locoLabel: 'loco 2  ',
      locoAddress: '${dcc.loco2.value}',
      ble: ble),
      
    //////////////////////////////////////////////////////////////////////////////
    // train control 3 must pass loco label, address, and bluetooth controller
    LocoControl(
      locoLabel: 'loco 3  ',
      locoAddress: '${dcc.loco3.value}',
      ble: ble),

    ]), /////////// end of Row children for locomotive controller with slider
    
  //////////////////////////////
  // accessory decoder test
  // using loco speed to test accessory hardcode address 13
  //  speed 8 will blink pico green led on board
  //  speed 9 will show on ssd1306 oled on the pico accessory board
  SizedBox(height:2),
  Text('test decoder address 13'),
  Text('touch below io then toggle'),
 
  SizedBox(height:2),
  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
   
    SizedBox(width:3),
    TextButton(onPressed:(){ble.sendData('+ls 13 2' + '\r');},
      child: Text('led')),
      
    SizedBox(width:3),
    TextButton(onPressed:(){ble.sendData('+ls 13 3' + '\r');},
      child: Text('rgb')),
      
    SizedBox(width:3),
    TextButton(onPressed:(){ble.sendData('+ls 13 4' + '\r');},
      child: Text('oled')),

    SizedBox(width:3),
    TextButton(onPressed:(){ble.sendData('+ls 13 5' + '\r');},
      child: Text('servo')),
    
    SizedBox(width:3),
    TextButton(onPressed:(){ble.sendData('+ld 13 ~' + '\r');},
      child: Text('toggle')),
  ]), // end of Row bottom for accessory decoder address 13
    
  ] ////////////// end of Column children for controller layout
  
  );}}
        

  

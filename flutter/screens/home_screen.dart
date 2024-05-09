import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './listing/instruction.dart';
import './listing/my_decoder.dart';
import './listing/station.dart';
import './listing/booster.dart';
import './listing/bluetooth.dart';
import './listing/dcc_app.dart';
import './listing/booster_md10.dart';
import './listing/decoder_io.dart';

class HomeScreen extends StatelessWidget {
@override Widget build(BuildContext context) {
return Padding(padding: EdgeInsets.all(15), child: ListView(children: <Widget>[
  
  Card(color: Colors.teal[50], child: ListTile(
    onTap:(){ Get.to(Instruction());},
    leading: FlutterLogo(size: 56.0),
    title: Text('Instruction'),
    subtitle: Text('brief instruction'),
    trailing: Icon(Icons.chevron_right))),

  Card(color: Colors.orange[50], child: ListTile(
    onTap:(){ Get.to(MyDecoder());},
    leading: FlutterLogo(size: 56.0),
    title: Text('RP2040 decoder'),
    subtitle: Text('decoder info'),
    trailing: Icon(Icons.chevron_right))),

  Card(color: Colors.orange[50], child: ListTile(
    onTap:(){ Get.to(DecoderIO());},
    leading: FlutterLogo(size: 56.0),
    title: Text('RP2040 Decoder IO'),
    subtitle: Text('decoder info'),
    trailing: Icon(Icons.chevron_right))),
      
  Card(color: Colors.purple[50], child: ListTile(
    onTap:(){ Get.to(Station());},
    leading: FlutterLogo(size: 56.0),
    title: Text('RP2040 station'),
    subtitle: Text('station info'),
    trailing: Icon(Icons.chevron_right))),
      
  Card(color: Colors.yellow[50], child: ListTile(
    onTap:(){ Get.to(Booster());},
    leading: FlutterLogo(size: 56.0),
    title: Text('DRV8871 booster'),
    subtitle: Text('booster info'),
    trailing: Icon(Icons.chevron_right))),
    
  Card(color: Colors.yellow[50], child: ListTile(
    onTap:(){ Get.to(BoosterMD10());},
    leading: FlutterLogo(size: 56.0),
    title: Text('MD10 booster'),
    subtitle: Text('booster info'),
    trailing: Icon(Icons.chevron_right))),
        
  Card(color: Colors.red[50], child: ListTile(
    onTap:(){ Get.to(Bluetooth());},
    leading: FlutterLogo(size: 56.0),
    title: Text('HM-19 Bluetooth'),
    subtitle: Text('bluetooth module info'),
    trailing: Icon(Icons.chevron_right))),
        
  Card(color: Colors.blue[50], child: ListTile(
    onTap:(){ Get.to(DCCApp());},
    leading: FlutterLogo(size: 56.0),
    title: Text('DCC Android app'),
    subtitle: Text('DCC app info'),
    trailing: Icon(Icons.chevron_right))), 
     
  ]));}}

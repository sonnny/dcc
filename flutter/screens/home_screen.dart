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
import './listing/dcc_source_light.dart';
import './listing/dcc_source_dark.dart';

class HomeScreen extends StatelessWidget {
@override Widget build(BuildContext context) {
return Padding(padding: EdgeInsets.all(15), child: ListView(children: <Widget>[
  
  Card(color: Colors.teal[50], child: ListTile(
    onTap:(){ Get.to(Instruction());},
    leading: Icon(Icons.info, size: 56.0, color: Colors.orange),
    title: Text('Instruction'),
    subtitle: Text('brief instruction'),
    trailing: Icon(Icons.chevron_right))),

  Card(color: Colors.orange[50], child: ListTile(
    onTap:(){ Get.to(MyDecoder());},
    leading: Icon(Icons.devices, size: 56.0, color: Colors.green),
    title: Text('RP2040 decoder'),
    subtitle: Text('decoder info'),
    trailing: Icon(Icons.chevron_right))),

  Card(color: Colors.orange[50], child: ListTile(
    onTap:(){ Get.to(DecoderIO());},
    leading: Icon(Icons.settings_input_hdmi, size: 56.0, color: Colors.purple),
    title: Text('RP2040 Decoder IO'),
    subtitle: Text('decoder info'),
    trailing: Icon(Icons.chevron_right))),
      
  Card(color: Colors.purple[50], child: ListTile(
    onTap:(){ Get.to(Station());},
    leading: Icon(Icons.train, size: 56.0, color: Colors.red),
    title: Text('RP2040 station'),
    subtitle: Text('station info'),
    trailing: Icon(Icons.chevron_right))),
      
  Card(color: Colors.yellow[50], child: ListTile(
    onTap:(){ Get.to(Booster());},
    leading: FlutterLogo(size: 56.0),
    title: Text('DRV8871 booster'),
    subtitle: Text('booster info 2 amp'),
    trailing: Icon(Icons.chevron_right))),
    
  Card(color: Colors.yellow[50], child: ListTile(
    onTap:(){ Get.to(BoosterMD10());},
    leading: FlutterLogo(size: 56.0),
    title: Text('MD10 booster'),
    subtitle: Text('booster info 10 amp'),
    trailing: Icon(Icons.chevron_right))),
        
  Card(color: Colors.red[50], child: ListTile(
    onTap:(){ Get.to(Bluetooth());},
    leading: Icon(Icons.bluetooth, size: 56.0, color: Colors.blue),
    title: Text('HM-19 Bluetooth'),
    subtitle: Text('bluetooth module info'),
    trailing: Icon(Icons.chevron_right))),
        
  Card(color: Colors.blue[50], child: ListTile(
    onTap:(){ Get.to(DCCApp());},
    leading: FlutterLogo(size: 56.0),
    title: Text('DCC Android app'),
    subtitle: Text('DCC app info'),
    trailing: Icon(Icons.chevron_right))), 
    
  Card(color: Colors.blue[50], child: ListTile(
    onTap:(){ Get.to(DCCSourceLight());},
    leading: Icon(Icons.source_outlined, size: 56.0),
    title: Text('DCC decoder source light'),
    subtitle: Text('source code light'),
    trailing: Icon(Icons.chevron_right))),
    
  Card(color: Colors.blue[50], child: ListTile(
    onTap:(){ Get.to(DCCSourceDark());},
    leading: Icon(Icons.source, size: 56.0),
    title: Text('DCC decoder source dark'),
    subtitle: Text('source code dark'),
    trailing: Icon(Icons.chevron_right))),   
     
  ]));}}

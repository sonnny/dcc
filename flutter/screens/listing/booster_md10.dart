import 'package:flutter/material.dart';

class BoosterMD10 extends StatelessWidget {

@override Widget build(BuildContext context) {
return Scaffold(backgroundColor: Colors.yellow[50],
appBar: AppBar(title: Text('Booster')),

body: SingleChildScrollView(child: Column(children: [
  Text('Booster info:'),
  
                 ClipOval(
              child: Image.network(
                'https://pinoysa.us/dcc/md10_booster.png',

                width: 300, // Set width
                height: 300, // Set height
                fit: BoxFit.cover,
              ),
            ),
  
  Text("""
    booster uses Cytron md10 shield
    input voltage 7-30 volts
    10 amp max current
    
    DIR jumper     ----- RP2040 gpio 2
    PWM            ----- RP2040 5v
    + POWER        ----- +12V
    - POWER        ----- -12V
    A MOTOR        ----- DCC track
    B MOTOR        ----- DCC track  
    
    HM-19 VCC      ----- RP2040 5v
    HM-19 GND      ----- RP2040 gnd
    HM-19 TXD      ----- RP2040 gpio0
    HM-19 RXD      ----- RP2040 gpio1
    
  """, style: TextStyle(fontSize:18)),
    
  ])));}}

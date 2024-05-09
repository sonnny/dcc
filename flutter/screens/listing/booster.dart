import 'package:flutter/material.dart';

class Booster extends StatelessWidget {

@override Widget build(BuildContext context) {
return Scaffold(backgroundColor: Colors.yellow[50],
appBar: AppBar(title: Text('Booster')),
body: Column(children: [
  Text('Booster info:'),
  
                 ClipOval(
              child: Image.network(
                'https://cdn-shop.adafruit.com/970x728/3190-09.jpg',

                width: 200, // Set width
                height: 200, // Set height
                fit: BoxFit.cover,
              ),
            ),
  
  Text("""
    booster uses drv8871 similar to adafruit
    product id: 3190
    
    drv8871 IN1    ----- RP2040 gpio 2
    drv8871 IN2    ----- RP2040 gpio 3
    drv8871 VM     ----- +12volt
    drv8871 GND    ----- RP2040 ground
    drv8871 motor1 ----- track
    drv8871 motor2 ----- track
    
    to increase current draw, put a parallel
    resistor to the existing resistor
    see datasheet for resistor value
  """, style: TextStyle(fontSize:18)),
    
  ]));}}

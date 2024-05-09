import 'package:flutter/material.dart';

class Instruction extends StatelessWidget {

@override Widget build(BuildContext context) {
return Scaffold(backgroundColor: Colors.teal[50],
  appBar: AppBar(title: Text('Instruction')),
  body: SingleChildScrollView(child: Column(children: [
    Text("""
  turn on bluetooth on your phone
  give this app location permission phone settings
  start this app
  Goto settings tab and set the ble mac address
  use android app nrf connect to find mac address
  While in settings tab
    enter loco1, loco2, and loco3 address
  Go to controller tab
  press bluetooth icon to connect
  look in ble module, 
  if red led remains lit instead of blinking
  then you are connected
    
  press track switch to energize the track
  if you are using regular pico board not pico w
  then when you energize the track
  the green led on the pico will stay lit
    
  press arrow icon to change direction
  if direction is not correct either
  switch train 180 degrees or
  switch track wire from the booster
       
  adjust speed by swiping the slider
  press red hexagon for emergency stop
  
  press the lightbulb icon while at home tab
  on the upper right hand corner for
  screen dark mode
  
  press the right arrow in box icon while
  at home tab on the upper right hand corner next
  to the light bulb to quit the app
  
  to test accessory decoder:
  
    press led then press toggle the green led
      on the pico(not picow) should blink
      
    press rgb then press toggle the rgb led
      should blink from red to blue
      
    press oled then press toggle the ssd1306
      oled should change the screen
      
    press servo then press toggle the servo
      should swing from one extreme to the other
  todo: show turnouts demo
    """, style: TextStyle(fontSize:15)),
    
    
  ])));}}

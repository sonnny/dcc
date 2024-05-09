import 'package:flutter/material.dart';

class Station extends StatelessWidget {

@override Widget build(BuildContext context) {
return Scaffold(backgroundColor: Colors.purple[50],
appBar: AppBar(title: Text('DCC Station')),
body: SingleChildScrollView(child: Column(children: [
  Text('github.com/pico-cs/firmware'),    
  Text("""
  the firmware has options for pico w
  if you use pico w option then you can
  use the tcp function, however you have
  to be hooked-up to a serial terminal
  to find the ip address that the router
  assigned to the pico w
  
  rp2040 gpio2 to booster drv8871 in 1 pin
  rp2040 gpio3 to booster drv8871 in 2 pin
  using regular pico not pico w, when you
  activate power to the track, green led
  on the rp2040 will stay lit
    
  rp2040 gpio 10 thru 22 is available to
  trigger output or used as input
    
  see github.com/pico-cs/firmware/
  protocol.md on what you have available
  for station commands 
  """, style: TextStyle(fontSize:15)),
  SizedBox(height: 10),
  Text("""
  gpio2  --- dcc signal
  gpio3  --- dcc signal inverted
  gpio4  --- dcc signal power
  gpio5  --- dcc signal power inverted
  
  serial monitor connected to 
  HM-19 bluetooth module baud rate 115200
  each command must end with 
  <CR> carriage return
  """, style: TextStyle(fontSize:18))
    
])));}}

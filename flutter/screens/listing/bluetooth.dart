import 'package:flutter/material.dart';

class Bluetooth extends StatelessWidget {

@override Widget build(BuildContext context) {
return Scaffold(backgroundColor: Colors.red[50],
appBar: AppBar(title: Text('Bluetooth')),
body: SingleChildScrollView(child: Column(children: [
  Text('bluetooth info'),
  
                 ClipOval(
              child: Image.network(
                'https://m.media-amazon.com/images/I/61nXzUx43GL._AC_SL1001_.jpg',

                width: 150, // Set width
                height: 150, // Set height
                fit: BoxFit.cover,
              ),
            ),
  
  Text("""
    uses HM-19 Bluetooth module from Amazon
    RP2040 gpio 0 ---- HM-19 RXD
    RP2040 gpio 1 ---- HM-19 TXD
    RP2040 +5v    ---- HM-19 VCC
    RP2040 ground ---- HM-19 GND
                       HM-19 STATE no connect
                       HM-19 EN    no connect
  """, style: TextStyle(fontSize:18)),
  
  Text("""
                       
  red light blinks on the ble module when
  it is not connected
    
  red light stay on when module is connected
  power to the ble module is 3.6v - 6v
    
  when I received the module, the default
  baudrate is 9600, I change it to 115200
  see their website on how to change it
    
  the RP2040 station decoder uart baudrate is
  115200 so the HM-19 must match the same
  baudrate, otherwise you will see garbage
  characters and usually indicative of 
  mismatch baud rate
  
  you can use nrf connect app from google
  playstore to find the mac address 
  of the HM-19
  """, style: TextStyle(fontSize:15)),
    
])));}}

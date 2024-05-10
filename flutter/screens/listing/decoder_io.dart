import 'package:flutter/material.dart';

class DecoderIO extends StatelessWidget {

@override Widget build(BuildContext context) {
return Scaffold(backgroundColor: Colors.orange[50],
  appBar: AppBar(title: Text('Decoder IO')),
  body: SingleChildScrollView(child: Column(children: [
    Text('Decoder info:'),
    SizedBox(height:10),

  Text('Hardware:',style: TextStyle(fontSize:20, color:Colors.blue)),
  Text('homemade from regular pico'),
  
                 ClipOval(
              child: Image.network(
                'https://pinoysa.us/dcc/decoder_io.jpg',

                width: 300, // Set width
                height: 300, // Set height
                fit: BoxFit.cover,
              ),
            ),
  
  SizedBox(height:10),
  
  Text('Software:',style: TextStyle(fontSize:20, color:Colors.blue)),
  Text('source -- github.com/sonnny/dcc'),
  
  SizedBox(height:10),
  
  Text(
  """
    Decoder IO, source at https://github.com/sonnny/dcc
    code will run on regular pico 2mb
    
    this decoder uses the same as the regular decoder
    but uses only the locomotive address 13
    
    demo:
    
    press led then toggle, the pico green led
    should blink, speed sent by android app
    is 0x02, 0x82 (toggle adds 0x80)
    led --- gpio25
    
    press rgb then toggle, the ws2812 should
    switch between red and blue
    speed sent by android app is
    0x03, 0x83 (toggle adds 0x80)
    ws2812 --- gpio4
    
    press oled then toggle, the ssd1306
    should switch showing 0x04 and 0x84
    speed sent by android app is
    0x04, 0x84 (toggle adds 0x80);
    ssd1306 ---- i2c gpio18, gpio19
    
    press servo then toggle, the servo
    should swing back and forth
    speed sent by android app is
    0x05, 0x85 (toggle adds 0x80)
    servo --- gpio6
    
    dcc track --- gpio9
  """, style: TextStyle(fontSize:15)),
  
 
                 GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return DetailInterface();
      }));
    },         
      child: Hero(tag: 'dccInterface',   
             child:Image.network(
                'https://pinoysa.us/dcc/dcc_interface.jpg',

                width: 250, // Set width
                height: 250, // Set height
               ))),
  
    
  ])));}}

  class DetailInterface extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
  body: GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Center(
      child: Hero(
        tag: 'dccInterface',
        child: Image.network(
          'https://pinoysa.us/dcc/dcc_interface.jpg',
        )))));}}

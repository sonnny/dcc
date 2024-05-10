import 'package:flutter/material.dart';

class MyDecoder extends StatelessWidget {

@override Widget build(BuildContext context) {
return Scaffold(backgroundColor: Colors.orange[50],
  appBar: AppBar(title: Text('Decoder')),
  body: SingleChildScrollView(child: Column(children: [
    Text('Decoder info:'),
    SizedBox(height:10),

  Text('Hardware:',style: TextStyle(fontSize:20, color:Colors.blue)),
  Text('source -- ilabs.se/product/opendec02/'),
  
                 ClipOval(
              child: Image.network(
                'https://usercontent.one/wp/ilabs.se/wp-content/uploads/2024/02/iso1-front.jpg?media=1689860297',

                width: 125, // Set width
                height: 125, // Set height
                fit: BoxFit.cover,
              ),
            ),
  
  SizedBox(height:10),
  
  Text('Software:',style: TextStyle(fontSize:20, color:Colors.blue)),
  Text('source -- github.com/PontusO/RP2040-Decoder'),
  
  SizedBox(height:10),
  
  Text(
  """
  you will need a different 
  pico-sdk as of April 12, 2024
  so dont use github.com/raspberrypi/pico-sdk
    
  the correct pico-sdk is:
  github.com/PontusO/pico-sdk
  make sure you clone the develop and not the master
  git clone -b develop remote_repo
       
  if you dont clone the develop branch above, 
  you will find error on cmake 
  -DPICO_BOARD=ilabs_opendec02 ..
  because ilabs_opendec02 is defined only on the
  develop branck of pico-sdk of PontusO github
     
  In the future when Pontus is finally merged to the
  raspberrypi/pico-sdk, then you will not need
  these extra steps
     
  decoder feature:
  4 outputs to drive up to 400ma each
  6 RP2040 GPIO (see raspberry pi for 
  current limitation)
  code can be updated using picoprobe
  """, style: TextStyle(fontSize:15)),
  
  SizedBox(height:15),
  
  Text(
  """
  The fist time you use the decoder, it will
  perform motor calibration, during the calibration
  process the orange led will be lit on the decoder,
  after its done motor calibration the led will turn
  off, you can now use the decoder normally.
  
  If you want to rerun the motor calibration, write
  to CV 65 value 255 and CV 172 value 255.
  
  If you want to reset the decoder write value 8 to
  CV 8
  
  """),
  
  SizedBox(height:15),
  
  Text('IO Wiring',style:TextStyle(fontSize:20, color:Colors.teal)),
  Text('note the sink/source of current'),
  Text('   for aux io and RP2040 gpio'),
                 
              Image.network(
                'https://pinoysa.us/decoder_lighting.png',

                width: 250, // Set width
                height: 250, // Set height
             
         
            ), 
 
  SizedBox(height:40), 
  
  Text('Pico probe wiring',style:TextStyle(fontSize:20, color:Colors.teal)),
  Text('useful for updating the firmware on the decoder'),
  
    
                 GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return DetailScreen();
      }));
    },         
      child: Hero(tag: 'decoderProbe',   
             child:Image.network(
                'https://pinoysa.us/decoder_probe.png',

                width: 250, // Set width
                height: 250, // Set height
               ))),
               
    
  ])));}}
  
  class DetailScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
  body: GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Center(
      child: Hero(
        tag: 'decoderProbe',
        child: Image.network(
          'https://pinoysa.us/decoder_probe.png',
        )))));}}

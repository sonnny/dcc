import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './nav_screen.dart';

class Intro1 extends StatelessWidget {
Intro1({super.key});
  
@override Widget build(BuildContext context){ return Container(
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height,
  child: Column( children: [          
    SizedBox(height: 70),          
    Text("Welcome to DCCF1", style: TextStyle(color: Colors.orangeAccent.shade100, fontSize: 25)),         
    SizedBox(height:50),
    ClipOval(child: Image.network(
      'https://a57.foxnews.com/static.foxbusiness.com/foxbusiness.com/content/uploads/2022/12/720/405/AMTRAK.jpg',
      width: 125, height: 125, fit: BoxFit.cover)),
    SizedBox(height: 50),          
    Text("DCC Flutter controller", style: TextStyle(color: Colors.yellow, fontSize: 20)),
    SizedBox(height: 15),
    Text("Do settings before anything else", style: TextStyle(color: Colors.yellow, fontSize: 20)),
    SizedBox(height: 15),
    Text("Uses RP2040 pico for DCC decoder", style: TextStyle(color: Colors.yellow, fontSize: 20)),
    SizedBox(height: 15),
    Text("Uses RP2040 pico for DCC station", style: TextStyle(color: Colors.yellow, fontSize: 20)),
    SizedBox(height: 15), 
    Text("See docs for more info", style: TextStyle(color: Colors.yellow, fontSize: 20)),                
    SizedBox(height: 30),          
    Icon(Icons.swipe_left_outlined, size:50), 
                     
            //start remove after test
            
            //SizedBox(height:20),
       
              //   IconButton(icon: Icon(Icons.arrow_forward_outlined),
                //   iconSize: 50.0, onPressed:(){ Get.off(NavScreen());}),
            //end remove after test
                  
    ]),
    color: Colors.blue,);}}

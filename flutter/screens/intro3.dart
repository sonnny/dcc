import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './nav_screen.dart';

class Intro3 extends StatelessWidget{
  Intro3({super.key});
  
  @override Widget build(BuildContext context){
    return Container(           
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack( children:[
      
        Text('page 3'),
        
             Padding(padding: EdgeInsets.all(30),
               child: Align(alignment: Alignment.bottomRight,
                 child: IconButton(icon: Icon(Icons.arrow_forward_outlined),
                   iconSize: 50.0, onPressed:(){ Get.off(NavScreen());})))            
      
      ]));}}

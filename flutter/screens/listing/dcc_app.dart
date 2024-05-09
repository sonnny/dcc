import 'package:flutter/material.dart';

class DCCApp extends StatelessWidget {

@override Widget build(BuildContext context) {
return Scaffold(backgroundColor: Colors.blue[50],
appBar: AppBar(title: Text('Android DCCApp')),
body: SingleChildScrollView(child: Column(children: [
  Text('android dcc app made in flutter, source code:'),
  Text('github.com/sonnny/dcc'),
  SizedBox(height:10),
   
  //Text('Plugins:', style: TextStyle(fontSize:20, color:Colors.blue)),  
  //Text("""
  //  flutter pub add flutter_reactive_ble
  //  flutter pub add get
  //  flutter pub add syncfusion_flutter_sliders
  //""",style: TextStyle(fontSize:18)),
  
  Text('Troubleshooting:',style: TextStyle(fontSize:20, color:Colors.red)),
  
  Text("""
   when compiling flutter code, change the file
   android/app/build.gradle
   edit minSdkVersion to 21
   this happens when I add flutter_reactive_ble plugin
      
  also while in build.gradle enter in dependencies:
  constraints{
  implementation 
  'org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.0'
  implementation 
  'org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.8.0'  
  }
  currently when you create a flutter app, 
    dependencies is empty,    
      
  """, style: TextStyle(fontSize:15)),
  
  Text('Creating this app:', style: TextStyle(fontSize:20, color:Colors.blue)),
  Text("""
  flutter create dccf1 --empty
  cd dccf1
  flutter pub add flutter_reactive_ble
  flutter pub add get
  flutter pub add syncfusion_flutter_sliders
  
  copy the flutter/lib folder from github.com/sonnny/dccf1
  
  change android/app/build.gradle
    minSdkVersion to 21 (see troubleshooting above)
    
  edit dependencies section of 
    android/app/build.gradle
      see troubleshooting above
    
  try flutter run
    
  """),
  
    
])));}}

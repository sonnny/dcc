//
// when compiling I'm getting error I had to add
// to android/app/build.gradle 
//
//dependencies {
// constraints{
//          implementation 'org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.0'
//          implementation 'org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.8.0'  
//        }
//	}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import './screens/nav_screen.dart';
import './screens/intro1.dart';
import './screens/intro2.dart';
import './screens/intro3.dart';


void main() {runApp(GetMaterialApp(
  darkTheme: ThemeData.dark(),
  themeMode: ThemeMode.system,
  home: MyApp(),
  debugShowCheckedModeBanner: false,));}

class MyApp extends StatefulWidget {
  @override _MyAppState createState() => _MyAppState();}

class _MyAppState extends State<MyApp> {
PageController page = PageController(initialPage: 0);
int pageIndex = 0;

@override Widget build(BuildContext context) {
  return Scaffold(body: SafeArea(child: PageView(
    onPageChanged: (index){if (index == 4) Get.off(NavScreen());},
    controller: page,
    scrollDirection: Axis.horizontal,
    pageSnapping: true, children: [ 
      Intro1(),
      Intro2(),
      Intro3()])));}}

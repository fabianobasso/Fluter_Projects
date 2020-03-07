import 'package:flutter/material.dart';
import 'package:marcador_truco/view/home_page.dart';
import 'package:wakelock/wakelock.dart';

void main(){
  Wakelock.enable();
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
  home: HomePage(),
  theme: ThemeData(
    primarySwatch: Colors.deepOrange,
    ),
   )
 );
}



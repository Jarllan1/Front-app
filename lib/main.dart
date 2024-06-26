import 'package:flutter/material.dart';
import 'package:jarllan/Home.dart';
import 'package:jarllan/Pages/Dashboard.dart';
import 'package:jarllan/Pages/Menu.dart';

void main() => runApp(MaterialApp(
    routes:{
      '/': (context) =>Dashboard(),
      '/Menu' : (context) => Menu(),
      '/Profile': (context) => Home(),
    },
      ));


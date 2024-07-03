import 'package:flutter/material.dart';
import 'package:jarllan/Home.dart';
import 'package:jarllan/Pages/SignUp.dart';
import 'package:jarllan/Home.dart';
import 'package:jarllan/Pages/Dashboard.dart';
import 'package:jarllan/Pages/Menu.dart';
import 'package:jarllan/Pages/Login.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/menu',
    routes:{
      '/': (context) =>Dashboard(),
      '/menu' : (context) => Menu(),
      '/profile': (context) => Home(),
      '/signup' : (context) => Signup(),
      '/login' : (context) => Login(),
    },
      ));


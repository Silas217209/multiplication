import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:hive/hive.dart';
import 'package:multiplication/language/french.dart';
import 'package:multiplication/language/german.dart';
// ignore_for_file: top_level_function_literal_block

String language = window.locale.languageCode.toString();
getlanguage() {
  var returnvalue;
  switch (language) {
    case 'de':
      returnvalue = German();
      break;
    case 'fr':
      returnvalue = French();
      break;
    default:
      returnvalue = German();
      break;
  }
  return returnvalue;
}

var translation = getlanguage();
Color primaryswatch = Colors.blue;
Box wertbox = Hive.box("wert");
Box timebox = Hive.box('time');
var time = 0;
int falsch = 0;
int richtig = 0;
late var height;
var einmaleins;
List testliste = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
Color? textcolor = Colors.black;
Random random = new Random.secure();
int first = random.nextInt(10) + 1;
int? second = einmaleins == 11 ? random.nextInt(10) + 1 : einmaleins;
int testfirst = random.nextInt(10) + 1;
int testsecond = testliste[random.nextInt(testliste.length)];
List testaufgabenliste = [testfirst];
IconData? checkicon;
Color? iconcolor;
Stopwatch s = Stopwatch();
String current_time = '';
dynamic countdown = '';

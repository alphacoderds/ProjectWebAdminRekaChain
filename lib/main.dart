import 'package:RekaChain/DetailviewPerencanaan.dart';
import 'package:RekaChain/dasboard.dart';
import 'package:RekaChain/inputdokumen.dart';
import 'package:RekaChain/inputkebutuhanmaterial.dart';
import 'package:RekaChain/login.dart';
import 'package:RekaChain/logout.dart';
import 'package:RekaChain/notification.dart';
import 'package:RekaChain/profile.dart';
import 'package:RekaChain/Barchart.dart';
import 'package:RekaChain/dasboard.dart';
import 'package:RekaChain/dasboard.dart';
import 'package:RekaChain/perencanaan.dart';
import 'package:RekaChain/AfterSales/AfterSales.dart';
import 'package:RekaChain/reportsttpp.dart';
import 'package:RekaChain/viewikm.dart';
import 'package:RekaChain/viewperencanaan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetailP(),
    );
  }
}

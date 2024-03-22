import 'package:RekaChain/WebUser/DetailviewPerencanaan.dart';
import 'package:RekaChain/WebUser/cetak.dart';
import 'package:RekaChain/WebUser/cetak1.dart';
import 'package:RekaChain/WebUser/dasboard.dart';
import 'package:RekaChain/WebUser/inputdokumen.dart';
import 'package:RekaChain/WebUser/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebUser/login.dart';
import 'package:RekaChain/WebUser/logout.dart';
import 'package:RekaChain/WebUser/notification.dart';
import 'package:RekaChain/WebUser/profile.dart';
import 'package:RekaChain/WebUser/Barchart.dart';
import 'package:RekaChain/WebUser/dasboard.dart';
import 'package:RekaChain/WebUser/perencanaan.dart';
import 'package:RekaChain/WebUser/AfterSales/AfterSales.dart';
import 'package:RekaChain/WebUser/reportsttpp.dart';
import 'package:RekaChain/WebUser/viewikm.dart';
import 'package:RekaChain/WebUser/viewperencanaan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

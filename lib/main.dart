import 'package:RekaChain/WebAdmin/DetailViewPerencanaan.dart';
import 'package:RekaChain/WebAdmin/inputdokumen.dart';
import 'package:RekaChain/WebAdmin/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/login.dart';
<<<<<<< HEAD
import 'package:RekaChain/WebAdmin/tambahstaff.dart';
=======
import 'package:RekaChain/WebAdmin/perencanaan.dart';
>>>>>>> fb7c7b17eb8cafd737d2c4090d5a7bc445479176
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: InputDokumen(),
        );
      },
    );
  }
}

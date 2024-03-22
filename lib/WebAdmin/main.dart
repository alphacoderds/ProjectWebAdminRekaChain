import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebAdmin/tambahstaff.dart';
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
          home: LoginPage(),
        );
      },
    );
  }
}

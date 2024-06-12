import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebAdmin/inputdokumen.dart';
import 'package:RekaChain/WebAdmin/provider/user_provider.dart';
import 'package:RekaChain/WebAdmin/viewmaterial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  final String nip = '';
  final DataModel data = DataModel(
      kode_staff: '',
      nama: '',
      jabatan: '',
      unit_kerja: '',
      departemen: '',
      divisi: '',
      email: '',
      nip: '',
      noTelp: '',
      status: '',
      password: '',
      konfirmasi_password: '',
      profile: '');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      )
    ],
    child: MyApp1(
      data: data,
      nip: nip,
    ),
  ));
}

class MyApp1 extends StatelessWidget {
  final DataModel data;
  final String nip;
  const MyApp1({Key? key, required this.nip, required this.data})
      : super(key: key);

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
          home: ViewMaterial(data: data, nip: nip),
        );
      },
    );
  }
}

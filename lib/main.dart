import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:flutter/material.dart';
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
      konfirmasi_password: '');
  runApp(MyApp1(
    data: data,
    nip: nip,
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
          home: LoginPage(data: data, nip: nip),
        );
      },
    );
  }
}

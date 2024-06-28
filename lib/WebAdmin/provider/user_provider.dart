import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider extends ChangeNotifier {
  String nip = '';
  String savedPassword = '';
  DataModel dataModel = DataModel(
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

  void saveNip(String newNip, String pass) {
    nip = newNip;
    savedPassword = pass;
    print(nip);
  }

  Future<void> getUserByNip() async {
    final map = <String, dynamic>{};
    map['nip'] = nip;

    await http
        .post(
            body: map,
            Uri.parse(
                "http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/readdataprofile.php"))
        .then((value) {
      dataModel = DataModel.getDataFromJson(jsonDecode(value.body));
      print(dataModel.nama);
      notifyListeners();
    });
  }
}

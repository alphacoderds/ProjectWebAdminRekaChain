import 'dart:convert';

import 'package:RekaChain/WebAdmin/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final Map<String, dynamic>? newStaff;
  final Map<String, dynamic>? tambahStaffData;

  const Profile({Key? key, this.newStaff, this.tambahStaffData})
      : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  List _listdata = [];
  bool _isloading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://192.168.10.194/ProjectWebAdminRekaChain/lib/Project/read.php',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    if (widget.newStaff != null) {
      _listdata.add(widget.newStaff!);
    }
    _getdata();
    super.initState();
  }

  Future<void> updateData() async {
    await _getdata();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        screenWidth = constraints.maxWidth;
        screenHeight = constraints.maxHeight;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(
                  builder: (context) => Profile(),
                );
              default:
                return null;
            }
          },
          home: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/logoREKA.png',
                    width: 250,
                    height: 300,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              toolbarHeight: 100.0,
            ),
            body: Row(
              children: [
                Container(
                  width: 270,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAvatar(),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfile(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(43, 56, 86, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                            ),
                            child: const Text('Ubah Profile'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildRightSection(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRightSection() {
    String namaLengkap = _listdata.isNotEmpty ? _listdata[0]['nama'] ?? '' : '';
    String jabatan = _listdata.isNotEmpty ? _listdata[0]['jabatan'] ?? '' : '';
    String unitKerja =
        _listdata.isNotEmpty ? _listdata[0]['unit_kerja'] ?? '' : '';
    String departemen =
        _listdata.isNotEmpty ? _listdata[0]['departemen'] ?? '' : '';
    String divisi = _listdata.isNotEmpty ? _listdata[0]['divisi'] ?? '' : '';
    String nomorTelepon =
        _listdata.isNotEmpty ? _listdata[0]['no_telp'] ?? '' : '';
    String nip = _listdata.isNotEmpty ? _listdata[0]['nip'] ?? '' : '';
    String password =
        _listdata.isNotEmpty ? _listdata[0]['password'] ?? '' : '';
    String status = _listdata.isNotEmpty ? _listdata[0]['status'] ?? '' : '';

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color.fromRGBO(43, 56, 86, 1),
              padding: const EdgeInsets.only(top: 3.5, left: 15.0),
              child: const Text(
                'PROFIL SAYA',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Donegal One',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildTextView(' Nama Lengkap :', text: namaLengkap),
            _buildDivider(),
            _buildTextView(' Jabatan :', text: jabatan),
            _buildDivider(),
            _buildTextView(' Unit Kerja :', text: unitKerja),
            _buildDivider(),
            _buildTextView(' Departemen :', text: departemen),
            _buildDivider(),
            _buildTextView(' Divisi :', text: divisi),
            _buildDivider(),
            _buildTextView(' Nomor Telepon :', text: nomorTelepon),
            _buildDivider(),
            _buildTextView(' NIP :', text: nip),
            _buildDivider(),
            _buildTextView(' Password :', text: ''),
            _buildDivider(),
            _buildTextView(' Status :', text: status),
            _buildDivider(),
            const SizedBox(height: 16.0),
          ],
        ),
      ],
    );
  }

  Widget _buildTextView(String label, {required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1.0,
      height: 16.0,
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: double.infinity,
      height: 125.0,
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: Colors.white),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
        shape: BoxShape.circle,
        image: const DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          image: AssetImage('assets/images/profile-illustration.png'),
        ),
      ),
    );
  }
}

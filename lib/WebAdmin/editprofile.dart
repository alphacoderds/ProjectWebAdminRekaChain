import 'package:RekaChain/WebAdmin/liststaff.dart';
import 'package:RekaChain/WebAdmin/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final String nip;
  final DataModel data;
  const EditProfile({Key? key, required this.nip, required this.data})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late double screenWidth;
  late double screenHeight;
  final formKey = GlobalKey<FormState>();
  TextEditingController kodeStaffController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  TextEditingController unitKerjaController = TextEditingController();
  TextEditingController departemenController = TextEditingController();
  TextEditingController divisiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController konfirmasiPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getdata();
    fetchData();
  }

  Future _getdata() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.11.148/crudflutter/flutter_crud/lib/read.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          kodeStaffController.text = data['kode_staff'];
          namaController.text = data['nama'];
          jabatanController.text = data['jabatan'];
          unitKerjaController.text = data['unit_kerja'];
          departemenController.text = data['departemen'];
          divisiController.text = data['divisi'];
          noTelpController.text = data['no_telp'];
          nipController.text = data['nip'];
          passwordController.text = data['password'];
          statusController.text = data['status'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _simpan() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.11.148/ProjectScanner/lib/API/edit_profile.php'),
      body: {
        "kode_staff": widget.data.kode_staff,
        "nama": namaController.text,
        "jabatan": jabatanController.text,
        "unit_kerja": unitKerjaController.text,
        "departemen": departemenController.text,
        "divisi": divisiController.text,
        "no_telp": noTelpController.text,
        "status": statusController.text,
        "password": passwordController.text,
        "konfirmasi_password": konfirmasiPasswordController.text,
      },
    );

    if (response.statusCode == 200) {
      final newProjectData = {
        "kode_staff": widget.data.kode_staff,
        "nama": namaController.text,
        "jabatan": jabatanController.text,
        "unit_kerja": unitKerjaController.text,
        "departemen": departemenController.text,
        "divisi": divisiController.text,
        "no_telp": noTelpController.text,
        "password": passwordController.text,
        "status": statusController.text,
        "konfirmasi_password": konfirmasiPasswordController.text,
      };
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ListStaff(data: widget.data, nip: widget.nip)),
      );
    } else {
      print('Gagal menyimpan data: ${response.statusCode}');
    }
  }

  Future<void> fetchData() async {
    String? nip = await getNipFromSharedPreferences();
    if (nip != null) {
      DataModel? data = await getUserDataByNip(nip);
      if (data != null) {
        setState(() {
          namaController.text = data.nama;
          jabatanController.text = data.jabatan;
          unitKerjaController.text = data.unit_kerja;
          departemenController.text = data.departemen;
          divisiController.text = data.divisi;
          noTelpController.text = data.noTelp;
          nipController.text = data.nip;
          passwordController.text = data.password;
          statusController.text = data.status;
        });
      }
    }
  }

  Future<String?> getNipFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nip');
  }

  Future<DataModel?> getUserDataByNip(String nip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataKaryawanJson = prefs.getString('dataKaryawan');
    if (dataKaryawanJson != null) {
      Map<String, dynamic> userMap = jsonDecode(dataKaryawanJson);
      if (userMap['nip'] == nip) {
        return DataModel.getDataFromJson(userMap);
      }
    }
    return null;
  }

  XFile? _selectedImage;

  Future<void> _update() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.11.148/ProjectScanner/lib/tbl_tambahstaff/create_tambahstaff.php'),
      body: {
        "nama": namaController.text,
        "jabatan": jabatanController.text,
        "unit_kerja": unitKerjaController.text,
        "departemen": departemenController.text,
        "divisi": divisiController.text,
        "no_telp": noTelpController.text,
        "nip": nipController.text,
        "password": passwordController.text,
        "status": statusController.text,
      },
    );
    if (response.statusCode == 200) {
      print('Data berhasil diperbarui');
    } else {
      print('Gagal memperbarui data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) =>
                  EditProfile(nip: widget.nip, data: widget.data),
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
                              builder: (context) =>
                                  Profile(nip: widget.nip, data: widget.data),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                        ),
                        child: const Text('Simpan'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            // Main content
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
  }

  Widget _buildRightSection() {
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
            // Letak widget content
            _buildTextView(
                label: ' Nama Lengkap', text: '', controller: namaController),
            _buildTextView(
                label: ' Jabatan', text: '', controller: jabatanController),
            _buildTextView(
                label: ' Unit Kerja',
                text: '',
                controller: unitKerjaController),
            _buildTextView(
                label: ' Departemen',
                text: '',
                controller: departemenController),
            _buildTextView(
                label: ' Divisi', text: '', controller: divisiController),
            _buildTextView(
                label: ' Nomor Telepon',
                text: '',
                controller: noTelpController),
            _buildTextView(label: ' NIP', text: '', controller: nipController),
            _buildTextView(
                label: ' Password', text: '', controller: passwordController),
            _buildTextView(
                label: ' Status', text: '', controller: statusController),
            const SizedBox(height: 16.0),
          ],
        ),
      ],
    );
  }

  Widget _buildTextView(
      {required String label,
      required String text,
      required TextEditingController controller}) {
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
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
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
          image: AssetImage('assets/images/profil.png'),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:RekaChain/WebAdmin/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebUser/editprofile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String kode_staff;
  final String nama;
  final String jabatan;
  final String unit_kerja;
  final String departemen;
  final String divisi;
  final String email;
  final String no_telp;
  final String nip;
  final String status;
  final String password;
  final String konfirmasi_password;

  User({
    required this.kode_staff,
    required this.nama,
    required this.jabatan,
    required this.unit_kerja,
    required this.departemen,
    required this.divisi,
    required this.email,
    required this.no_telp,
    required this.nip,
    required this.status,
    required this.password,
    required this.konfirmasi_password,
  });
}

class Profile extends StatefulWidget {
  final DataModel data;
  final String nip;
  const Profile({super.key, required this.nip, required this.data});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  Map<String, dynamic>? _userData;
  List _listdata = [];
  final formKey = GlobalKey<FormState>();
  String _errorMassage = 'Terjadi kesalahan saat mengambil data';

  TextEditingController kodeStaffController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  TextEditingController unitkerjaController = TextEditingController();
  TextEditingController departemenController = TextEditingController();
  TextEditingController divisiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController konfirmasiPasswordController = TextEditingController();

  bool _isLoading = true;
  String _errorMessage = 'Terjadi kesalahan saat mengambil data';

  Future<void> _getdata() async {
    try {
      print(widget.nip);
      final map = <String, dynamic>{};
      map['nip'] = widget.nip;
      final response = await http.post(
        body: map,
        Uri.parse(
          'http://192.168.10.230/ProjectWebAdminRekaChain/lib/Project/readdataprofile.php',
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Response data: $data");

        // Ambil NIP dari SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? nip = prefs.getString('nip');
        print("nip: $nip");

        Map<String, dynamic>? userData;
        for (var userDataItem in data) {
          if (userDataItem['nip'] == nip) {
            userData = userDataItem;
            break;
          }
        }
        if (userData != null) {
          // Setel state untuk menampilkan data pengguna yang sesuai
          setState(() {
            _userData = userData;
            _isLoading = false;
          });
        } else {
          // Tampilkan pesan jika data pengguna tidak ditemukan
          setState(() {
            _isLoading = false;
            _errorMessage = 'Data pengguna tidak ditemukan';
          });
        }
      }
    } catch (e) {
      // Tangani kesalahan yang terjadi
      print(e);
      setState(() {
        _isLoading = false;
        _errorMessage = 'Terjadi kesalahan saat mengambil data';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final auth = Provider.of<UserProvider>(context, listen: false);
      auth.getUserByNip();
    });
    
  }

  Future<DataModel?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataStaffJson = prefs.getString('dataStaff');
    if (dataStaffJson != null) {
      Map<String, dynamic> userMap = jsonDecode(dataStaffJson);
      return DataModel.getDataFromJson(userMap);
    }
    return null;
  }

  Future<void> _getUserDataFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataStaffJson = prefs.getString('dataStaff');
    if (dataStaffJson != null) {
      Map<String, dynamic> userMap = jsonDecode(dataStaffJson);
      setState(() {
        _userData = userMap;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Data pengguna tidak ditemukan';
      });
    }
  }

  Future<void> updateData() async {
    await _getdata();
    setState(() {});
  }

  Future<void> _simpan() async {
    // Simpan data dan dapatkan data yang diperbarui
    final updatedData = {
      'kode_staff': widget.data.kode_staff,
      'nama': namaController.text,
      'jabatan': jabatanController.text,
      'unit_kerja': unitkerjaController.text,
      'departemen': departemenController.text,
      'divisi': divisiController.text,
      'email': emailController.text,
      'nip': nipController.text,
      'noTelp': noTelpController.text,
      'status': statusController.text,
      'password': passwordController.text,
      'konfirmasi_password': konfirmasiPasswordController.text,
      // Data yang diperbarui
    };

    // Kirim data yang diperbarui ke halaman profil
    Navigator.pop(context, updatedData);
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
                  builder: (context) =>
                      Profile(data: widget.data, nip: widget.nip),
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
                        child: Consumer<UserProvider>(
                          builder: (context, provider, child) {
                            return Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                          data: provider.dataModel, nip: widget.nip),
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
                            );
                          }
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
    String namaLengkap = _userData?['nama'] ?? '';
    String jabatan = _userData?['jabatan'] ?? '';
    String unitKerja = _userData?['unit_kerja'] ?? '';
    String departemen = _userData?['departemen'] ?? '';
    String divisi = _userData?['divisi'] ?? '';
    String nomorTelepon = _userData?['no_telp'] ?? '';
    String nip = _userData?['nip'] ?? '';
    String status = _userData?['status'] ?? '';

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
            Consumer<UserProvider>(
              builder: (context,provider,child) {
                return _buildTextView(' Nama Lengkap :', text: provider.dataModel.nama);
              }
            ),
            _buildDivider(),

            Consumer<UserProvider>(
              builder: (context, provider,child) {
                return _buildTextView(' Jabatan :', text: provider.dataModel.jabatan);
              }
            ),
            _buildDivider(),
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return _buildTextView(' Unit Kerja :', text: provider.dataModel.unit_kerja);
              }
            ),
            _buildDivider(),
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return _buildTextView(' Departemen :', text: provider.dataModel.departemen);
              }
            ),
            _buildDivider(),
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return _buildTextView(' Divisi :', text: provider.dataModel.divisi);
              }
            ),
            _buildDivider(),
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return _buildTextView(' Nomor Telepon :', text: provider.dataModel.noTelp);
              }
            ),
            _buildDivider(),
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return _buildTextView(' NIP :', text: provider.dataModel.nip);
              }
            ),
            _buildDivider(),
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return _buildTextView(' Password :', text: provider.dataModel.password);
              }
            ),
            _buildDivider(),
            Consumer<UserProvider>(
              builder: (context, provider, child) {
                return _buildTextView(' Status :', text: provider.dataModel.status);
              }
            ),
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
          image: AssetImage('assets/images/profil.png'),
        ),
      ),
    );
  }
}

import 'dart:html';
import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebAdmin/inputdokumen.dart';
import 'package:RekaChain/WebAdmin/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/liststaff.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebAdmin/notification.dart';
import 'package:RekaChain/WebAdmin/perencanaan.dart';
import 'package:RekaChain/WebAdmin/profile.dart';
import 'package:RekaChain/WebAdmin/reportsttpp.dart';
import 'package:RekaChain/WebAdmin/tambahproject.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Staff {
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

  Staff({
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

class StaffProvider extends ChangeNotifier {
  List<Staff> _staff = [];
  List<Staff> get staff => _staff;

  void addStaff(Staff staff) {
    _staff.add(staff);
    notifyListeners();
  }
}

class TambahStaff extends StatefulWidget {
  final DataModel data;
  final String nip;
  const TambahStaff({Key? key, required this.data, required this.nip})
      : super(key: key);

  @override
  State<TambahStaff> createState() => _TambahStaffState();
}

class _TambahStaffState extends State<TambahStaff> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  late TextEditingController kodestaffController;
  late TextEditingController namaController;
  late TextEditingController jabatanController;
  late TextEditingController unitkerjaController;
  late TextEditingController departemenController;
  late TextEditingController divisiController;
  late TextEditingController emailController;
  late TextEditingController nomortelponController;
  late TextEditingController nipController;
  late TextEditingController statusController;
  late TextEditingController passwordController;
  late TextEditingController konfirmasiPasswordController;

  List<File> uploadFiles = [];
  bool isPassword = true;
  bool isKonfirmasiPassword = true;
  bool obscureTextPassword = true;
  bool obscureTextKonfirmasiPassword = true;
  bool isViewVisible = true;

  int _selectedIndex = 0;
  List<String> dropdownItemsJabatan = [
    'Direktur',
    'General Manager',
    'Senior Manager',
    'Manager',
    'SPV',
    'Staff'
  ];
  String? selectedValueJabatan;

  List<String> dropdownItemsDepartemen = [
    'Departemen Teknologi',
    'Departemen Pengelolaan Kualitas & Purna Jual',
    'Departemen Perencanaa dan Pengendalian \nProduksi',
    'Departemen Produksi Elektrik',
    'Departemen Produksi Mekanik',
    'Departemen Produksi Proyek'
  ];
  String? selectedValueDepartemen;

  List<String> dropdownItemsUnitKerja = [
    'Bagian Engineering & EIM',
    'Bagian Design & Eletrical Quality Engineering',
    'Bagian Design & Mechanical Engineering',
    'Bagian Pengelolaan Kualitas Incoming & \nInspeksi InProcess',
    'Bagian Inspeksi Final & Purna Jual',
    'Bagian Perencanaan Produksi',
    'Bagian Pengendalian & Monitoring Produksi',
    'Bagian Produksi Part 1',
    'Bagian Produksi Part 2',
    'Bagian Produksi Part 3',
    'Bagian Fabrikasi',
    'Bagian Mechanical Component',
    'Bagian Cutting & Harness',
    'Bagian Assembly Component'
  ];
  String? selectedValueUnitKerja;

  List<String> dropdownItemsDivisi = [
    'Divisi Teknologi & Pengelolaan Kualitas',
    'Divisi Operasi'
  ];
  String? selectedValueDivisi;

  List<String> dropdownItemsStatus = ['Aktif', 'Non Aktif        '];
  String? selectedValueStatus;

  String hashPassword(String password) {
    var bytes =
        utf8.encode(password); // Mengonversi string password ke bytes UTF-8
    var digest =
        sha1.convert(bytes); // Menghitung hash SHA-1 dari bytes password
    return digest.toString(); // Mengembalikan hash sebagai string
  }

  Future<void> _simpan() async {
    final hashedPassword = hashPassword(passwordController.text);
    final hashedKonfirmasiPassword =
        hashPassword(konfirmasiPasswordController.text);

    if (hashedPassword != hashedKonfirmasiPassword) {
      print('Konfirmasi password tidak sesuai');
      return;
    }

    final response = await http.post(
      Uri.parse(
        "http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/create_tambahstaff.php",
      ),
      body: {
        "kode_staff": kodestaffController.text,
        "nama": namaController.text,
        "jabatan": selectedValueJabatan ?? '',
        "unit_kerja": selectedValueUnitKerja ?? '',
        "departemen": selectedValueDepartemen ?? '',
        "divisi": selectedValueDivisi ?? '',
        "email": emailController.text,
        "no_telp": nomortelponController.text,
        "nip": nipController.text,
        "status": selectedValueStatus ?? '',
        "password": hashedPassword,
        "konfirmasi_password": hashedKonfirmasiPassword,
      },
    );

    if (response.statusCode == 200) {
      final newStaffData = {
        "no": response.body,
        "kodeStaff": kodestaffController.text,
        "nama": namaController.text,
        "jabatan": jabatanController.text,
        "unit_kerja": unitkerjaController.text,
        "departemen": departemenController.text,
        "divisi": divisiController.text,
        "email": emailController.text,
        "no_telp": nomortelponController.text,
        "nip": nipController.text,
        "status": statusController.text,
        "password": hashedPassword,
        "konfirmasi_password": hashedKonfirmasiPassword,
      };

      _showFinishDialog();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListStaff(
            newStaff: newStaffData,
            data: widget.data,
            nip: widget.nip,
          ),
        ),
      );
    } else {
      print('Gagal menyimpan data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    kodestaffController = TextEditingController();
    namaController = TextEditingController();
    jabatanController = TextEditingController();
    unitkerjaController = TextEditingController();
    departemenController = TextEditingController();
    divisiController = TextEditingController();
    emailController = TextEditingController();
    nomortelponController = TextEditingController();
    nipController = TextEditingController();
    statusController = TextEditingController();
    passwordController = TextEditingController();
    konfirmasiPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    kodestaffController.dispose();
    namaController.dispose();
    jabatanController.dispose();
    unitkerjaController.dispose();
    departemenController.dispose();
    divisiController.dispose();
    emailController.dispose();
    nomortelponController.dispose();
    nipController.dispose();
    statusController.dispose();
    passwordController.dispose();
    konfirmasiPasswordController.dispose();
    super.dispose();
  }

  void _calculateNip() {
    setState(() {
      nipController.text =
          '${kodestaffController.text} - ${namaController.text}';
    });
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
                      TambahStaff(data: widget.data, nip: widget.nip),
                );
              default:
                return null;
            }
          },
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDrawer(),
                  Expanded(
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                        toolbarHeight: 65,
                        title: Padding(
                          padding: EdgeInsets.only(left: screenHeight * 0.01),
                          child: Text(
                            'Tambah Data Staff Baru',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Donegal One',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        actions: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: screenHeight * 0.11),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.005,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.list,
                                    size: 38,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListStaff(
                                              data: widget.data,
                                              nip: widget.nip)),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.notifications_active,
                                    size: 33,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Notifikasi(
                                              nip: widget.nip,
                                              data: widget.data)),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.account_circle_rounded,
                                    size: 35,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile(
                                              data: widget.data,
                                              nip: widget.nip)),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      body: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: Column(
                            children: [
                              _buildMainTable(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.04, horizontal: screenWidth * 0.02),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: screenWidth * 0.8,
              height: screenHeight * 0.91,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.05,
                  horizontal: screenWidth * 0.02,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _textfieldStaff('Kode Staff', kodestaffController),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jabatan',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: DropdownButton<String>(
                                    alignment: Alignment.center,
                                    hint: Center(
                                      child: Text(
                                        '--Pilih Jabatan--',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    isExpanded:
                                        true, // Ensures the dropdown takes up full width
                                    underline: SizedBox(),
                                    value: selectedValueJabatan,
                                    items: dropdownItemsJabatan
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedValueJabatan = newValue;
                                      });
                                    },
                                    focusColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Departemen',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: DropdownButton<String>(
                                    alignment: Alignment.center,
                                    hint: Center(
                                      child: Text(
                                        '--Pilih Departemen--',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    isExpanded:
                                        true, // Ensures the dropdown takes up full width
                                    underline: SizedBox(),
                                    value: selectedValueDepartemen,
                                    items: dropdownItemsDepartemen
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedValueDepartemen = newValue;
                                      });
                                    },
                                    focusColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          _textfieldStaff('E-mail', emailController),
                          SizedBox(height: 20),
                          _textfieldStaff('Username/NIP', nipController),
                          SizedBox(height: 20),
                          _inputFieldPassword('Password', passwordController,
                              isPassword: true,
                              backgroundColor: Colors.transparent),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Column(
                        children: [
                          _textfieldStaff('Nama Lengkap', namaController),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Unit Kerja',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: DropdownButton<String>(
                                    alignment: Alignment.center,
                                    hint: Center(
                                      child: Text(
                                        '--Pilih Unit/Bagian Kerja--',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    isExpanded:
                                        true, // Ensures the dropdown takes up full width
                                    underline: SizedBox(),
                                    value: selectedValueUnitKerja,
                                    items: dropdownItemsUnitKerja
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedValueUnitKerja = newValue;
                                      });
                                    },
                                    focusColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Divisi',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: DropdownButton<String>(
                                    alignment: Alignment.center,
                                    hint: Center(
                                      child: Text(
                                        '--Pilih Divisi--',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    isExpanded:
                                        true, // Ensures the dropdown takes up full width
                                    underline: SizedBox(),
                                    value: selectedValueDivisi,
                                    items:
                                        dropdownItemsDivisi.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedValueDivisi = newValue;
                                      });
                                    },
                                    focusColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          _textfieldStaff(
                              'Nomor Telepon', nomortelponController),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: DropdownButton<String>(
                                    alignment: Alignment.center,
                                    hint: Center(
                                      child: Text(
                                        '--Pilih Status--',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    isExpanded:
                                        true, // Ensures the dropdown takes up full width
                                    underline: SizedBox(),
                                    value: selectedValueStatus,
                                    items:
                                        dropdownItemsStatus.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedValueStatus = newValue;
                                      });
                                    },
                                    focusColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          _inputFieldKonfirmasiPassword(
                            "Konfirmasi Password",
                            konfirmasiPasswordController,
                            isKonfirmasiPassword: true,
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _simpan();
                  },
                  child: SizedBox(
                    width: 100,
                    child: Center(
                      child: Text(
                        'Simpan',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _textfieldStaff(
      String informasiStaff, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          informasiStaff,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        SizedBox(
          width: 400,
          height: 50,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(width: 1))),
          ),
        ),
      ],
    );
  }

  Widget _inputFieldPassword(String labelText, TextEditingController controller,
      {bool isPassword = false, Color? backgroundColor}) {
    return SizedBox(
      width: 400,
      height: 100,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              style: const TextStyle(
                color: Color.fromARGB(255, 8, 8, 8),
                fontSize: 18,
              ),
              controller: controller,
              decoration: InputDecoration(
                fillColor: backgroundColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          obscureTextPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureTextPassword = !obscureTextPassword;
                          });
                        },
                      )
                    : null,
              ),
              obscureText: obscureTextPassword,
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputFieldKonfirmasiPassword(
      String labelText, TextEditingController controller,
      {bool isKonfirmasiPassword = false, Color? backgroundColor}) {
    return SizedBox(
      width: 400,
      height: 100,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              style: const TextStyle(
                color: Color.fromARGB(255, 8, 8, 8),
                fontSize: 18,
              ),
              controller: controller,
              decoration: InputDecoration(
                fillColor: backgroundColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          obscureTextKonfirmasiPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureTextKonfirmasiPassword =
                                !obscureTextKonfirmasiPassword;
                          });
                        },
                      )
                    : null,
              ),
              obscureText: obscureTextKonfirmasiPassword,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 244, 249, 255),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/logoreka.png',
                    height: 130,
                    width: 250,
                  ),
                ),
              ],
            ),
          ),
          _buildListTile('Dashboard', Icons.dashboard, 0, 35),
          _buildSubMenu(),
          _buildListTile('Report STTPP', Icons.receipt, 4, 35),
          _buildListTile('After Sales', Icons.headset_mic, 5, 35),
          _buildAdminMenu(),
          _buildListTile('Logout', Icons.logout, 8, 35),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, int index, int size) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        size: size.toDouble(),
        color: Color.fromARGB(255, 6, 37, 55),
      ),
      onTap: () {
        if (index == 8) {
          _showLogoutDialog();
        } else {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AdminDashboard(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ReportSTTPP(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AfterSales(data: widget.data, nip: widget.nip),
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildSubMenu({IconData? icon}) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            icon ?? Icons.input,
            size: 35,
            color: Color.fromARGB(255, 6, 37, 55),
          ),
          SizedBox(width: 12),
          Text('Input Data'),
        ],
      ),
      children: [
        _buildSubListTile('Perencanaan', Icons.calendar_today, 1, 35),
        _buildSubListTile('Input Kebutuhan Material', Icons.assignment, 2, 35),
        _buildSubListTile('Input Dokumen Pendukung', Icons.file_present, 3, 35),
      ],
    );
  }

  Widget _buildSubListTile(
    String title,
    IconData icon,
    int index,
    int size,
  ) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        size: size.toDouble(),
        color: Color.fromARGB(255, 6, 37, 55),
      ),
      onTap: () {
        if (index == 8) {
          _showLogoutDialog();
        } else {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Perencanaan(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InputMaterial(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InputDokumen(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 6) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TambahProject(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 7) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TambahStaff(data: widget.data, nip: widget.nip),
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildAdminMenu() {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(
            Icons.admin_panel_settings,
            size: 35,
            color: Color.fromARGB(255, 6, 37, 55),
          ),
          SizedBox(width: 12),
          Text('Menu Admin'),
        ],
      ),
      children: [
        _buildSubListTile('Tambah Project', Icons.assignment_add, 6, 35),
        _buildSubListTile('Tambah Staff', Icons.assignment_ind_rounded, 7, 35),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout", style: TextStyle(color: Colors.white)),
          content: Text("Apakah Anda yakin ingin logout?",
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage(data: widget.data, nip: widget.nip)),
                );
              },
              child: Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Simpan Data", style: TextStyle(color: Colors.white)),
          content: Text("Apakah Anda yakin ingin simpan data?",
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ListStaff(data: widget.data, nip: widget.nip)),
                );
              },
              child: Text("Ya", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

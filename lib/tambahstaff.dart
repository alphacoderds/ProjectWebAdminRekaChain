import 'dart:html';
import 'package:RekaChain/AfterSales/AfterSales.dart';
import 'package:RekaChain/dasboard.dart';
import 'package:RekaChain/inputdokumen.dart';
import 'package:RekaChain/inputkebutuhanmaterial.dart';
import 'package:RekaChain/liststaff.dart';
import 'package:RekaChain/login.dart';
import 'package:RekaChain/notification.dart';
import 'package:RekaChain/perencanaan.dart';
import 'package:RekaChain/profile.dart';
import 'package:RekaChain/reportsttpp.dart';
import 'package:RekaChain/tambahproject.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahStaff extends StatefulWidget {
  const TambahStaff({Key? key}) : super(key: key);

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
  bool isViewVisible = false;

  int _selectedIndex = 0;
  List<String> dropdownItemsJabatan = ['Jabatan 1', 'Jabatan 2'];
  String? selectedValueJabatan;

  List<String> dropdownItemsDepartemen = ['Departemen 1', 'Departemen 2'];
  String? selectedValueDepartemen;

  List<String> dropdownItemsUnitKerja = ['Unit Kerja 1', 'Unit Kerja 2'];
  String? selectedValueUNitKerja;

  List<String> dropdownItemsDivisi = ['Divisi 1', 'Divisi 2'];
  String? selectedValueDivisi;

  List<String> dropdownItemsStatus = ['Aktif', 'Tidak Aktif'];
  String? selectedValueStatus;

  Future<void> _simpan() async {
    final response = await http.post(
      Uri.parse(
        'http://192.168.8.165/ProjectWebAdminRekaChain/lib/Project/createproject.php',
      ),
      body: {
        "kode_staff": kodestaffController.text,
        "nama": namaController.text,
        "jabatan": jabatanController.text,
        "unit_kerja": unitkerjaController.text,
        "departemen": departemenController.text,
        "divisi": divisiController.text,
        "email": emailController.text,
        "no_telp": nomortelponController.text,
        "nip": nipController.text,
        "status": statusController.text,
        "password": passwordController.text,
        "konfirmasi_password": konfirmasiPasswordController.text,
      },
    );

    if (response.statusCode == 200) {
      final newStaffData = {
        "no": response.body,
        "kodeStaff": kodestaffController.text,
        "nama": namaController.text,
        "jabatan": jabatanController.text,
        "unit_kerja": unitkerjaController.text,
        "divisi": divisiController.text,
      };

      _showFinishDialog();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListStaff(newStaff: newStaffData),
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
                  builder: (context) => const TambahStaff(),
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
                            'Data Staff',
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
                                          builder: (context) => ListStaff()),
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
                                          builder: (context) => Notifikasi()),
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
                                          builder: (context) => Profile()),
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
              height: screenHeight * 0.90,
              decoration: BoxDecoration(
                border: Border.all(),
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
                            _textfieldStaff('Kode Staff'),
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
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: DropdownButton<String>(
                                      alignment: Alignment.center,
                                      hint: Text('--Pilih Jabatan--'),
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
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: DropdownButton<String>(
                                      alignment: Alignment.center,
                                      hint: Text('--Pilih Departemen--'),
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
                            _textfieldStaff('E-mail'),
                            SizedBox(height: 20),
                            _textfieldStaff('Username/NIP'),
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
                            _textfieldStaff('Nama Lengkap'),
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
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: DropdownButton<String>(
                                      alignment: Alignment.center,
                                      hint: Text('--Pilih Unit Kerja--'),
                                      underline: SizedBox(),
                                      value: selectedValueUNitKerja,
                                      items: dropdownItemsUnitKerja
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedValueUNitKerja = newValue;
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
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: DropdownButton<String>(
                                      alignment: Alignment.center,
                                      hint: Text('--Pilih Divisi--'),
                                      underline: SizedBox(),
                                      value: selectedValueDivisi,
                                      items: dropdownItemsDivisi
                                          .map((String value) {
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
                            _textfieldStaff('Nomor Telepon'),
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
                                      borderRadius: BorderRadius.circular(3)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: DropdownButton<String>(
                                      alignment: Alignment.center,
                                      hint: Text('--Pilih Status--'),
                                      underline: SizedBox(),
                                      value: selectedValueStatus,
                                      items: dropdownItemsStatus
                                          .map((String value) {
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
                    )),
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
                  child: Text(
                    'Simpan',
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

  Widget _inputFieldPassword(String labelText, TextEditingController controller,
      {bool isPassword = false, Color? backgroundColor}) {
    return SizedBox(
      width: screenWidth * 0.28,
      height: screenHeight * 0.1,
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
      width: screenWidth * 0.28,
      height: screenHeight * 0.1,
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
          _buildListTile('After Sales', Icons.headset_mic, 6, 35),
          _buildAdminMenu(),
          _buildListTile('Logout', Icons.logout, 9, 35),
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
        if (index == 9) {
          _showLogoutDialog();
        } else {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ),
            );
          } else if (index == 6) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AfterSales(),
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
        _buildSubListTile('Report STTPP', Icons.receipt, 2, 35),
        _buildSubListTile('Perencanaan', Icons.calendar_today, 3, 35),
        _buildSubListTile('Input Kebutuhan Material', Icons.assignment, 4, 35),
        _buildSubListTile('Input Dokumen Pendukung', Icons.file_present, 5, 35),
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
        if (index == 9) {
          _showLogoutDialog();
        } else {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportSTTPP(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Perencanaan(),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputMaterial(),
              ),
            );
          } else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputDokumen(),
              ),
            );
          } else if (index == 7) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahProject(),
              ),
            );
          } else if (index == 8) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahStaff(),
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
        _buildSubListTile('Tambah Project', Icons.assignment_add, 7, 35),
        _buildSubListTile('Tambah User', Icons.assignment_ind_rounded, 8, 35),
      ],
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
                  MaterialPageRoute(builder: (context) => ListStaff()),
                );
              },
              child: Text("Ya", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _textfieldStaff(String informasiStaff) {
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
}

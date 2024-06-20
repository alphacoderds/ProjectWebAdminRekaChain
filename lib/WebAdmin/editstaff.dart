import 'dart:convert';
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
import 'package:RekaChain/WebAdmin/tambahstaff.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:http/http.dart' as http;

class EditStaff extends StatefulWidget {
  final Map<String, dynamic> selectedStaff;
  final DataModel data;
  final String nip;

  const EditStaff(
      {Key? key,
      this.selectedStaff = const {},
      required this.data,
      required this.nip})
      : super(key: key);

  @override
  State<EditStaff> createState() => _EditStaffState();
}

class _EditStaffState extends State<EditStaff> {
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

  List<Map<String, dynamic>> _listdata = [];

  bool isPassword = true;
  bool isKonfirmasiPassword = true;
  bool obscureTextPassword = true;
  bool obscureTextKonfirmasiPassword = true;
  bool isViewVisible = true;

  int _selectedIndex = 0;
  String? selectValue1;
  String? selectValue2;

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.11.107/ProjectWebAdminRekaChain/lib/Project/edit_tambahstaff.php?kode_staff=${widget.selectedStaff['kode_staff']}&nip=${widget.selectedStaff['nip']}'),
      );
      if (response.statusCode == 200) {
        try {
          final responseData = json.decode(response.body);
          final kodeStaff = responseData['kode_staff'];
          setState(() {
            kodestaffController.text = kodeStaff;
          });
        } catch (e) {
          print('Error parsing JSON: $e');
          print('Response body: ${response.body}');
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    kodestaffController =
        TextEditingController(text: widget.selectedStaff['kode_staff'] ?? '');
    namaController =
        TextEditingController(text: widget.selectedStaff['nama'] ?? '');
    jabatanController =
        TextEditingController(text: widget.selectedStaff['jabatan'] ?? '');
    unitkerjaController =
        TextEditingController(text: widget.selectedStaff['unit_kerja'] ?? '');
    departemenController =
        TextEditingController(text: widget.selectedStaff['departemen'] ?? '');
    divisiController =
        TextEditingController(text: widget.selectedStaff['divisi'] ?? '');
    emailController =
        TextEditingController(text: widget.selectedStaff['email'] ?? '');
    nomortelponController =
        TextEditingController(text: widget.selectedStaff['no_telp'] ?? '');
    nipController =
        TextEditingController(text: widget.selectedStaff['nip'] ?? '');
    statusController =
        TextEditingController(text: widget.selectedStaff['status'] ?? '');
    passwordController =
        TextEditingController(text: widget.selectedStaff['password'] ?? '');
    konfirmasiPasswordController = TextEditingController(
        text: widget.selectedStaff['konfirmasi_password'] ?? '');
  }

  void _updateDataAndNavigateToListStaff() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.11.107/ProjectWebAdminRekaChain/lib/Project/edit_tambahstaff.php'),
        body: {
          'no': widget.selectedStaff['no'].toString(),
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
        await fetchData();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ListStaff(nip: widget.nip, data: widget.data),
          ),
        );
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
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
                      EditStaff(data: widget.data, nip: widget.nip),
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
                            'Detail Data Staff',
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
                                              nip: widget.nip,
                                              data: widget.data)),
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
                            _textfieldStaff('Kode Staff', kodestaffController),
                            SizedBox(height: 20),
                            _textfieldStaff('Jabatan', jabatanController),
                            SizedBox(height: 20),
                            _textfieldStaff('Departemen', departemenController),
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
                            _textfieldStaff('Unit Kerja', unitkerjaController),
                            SizedBox(height: 20),
                            _textfieldStaff('Divisi', divisiController),
                            SizedBox(height: 20),
                            _textfieldStaff(
                                'Nomor Telepon', nomortelponController),
                            SizedBox(height: 20),
                            _textfieldStaff('Status', statusController),
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
                    _updateDataAndNavigateToListStaff();
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
                builder: (context) =>
                    AdminDashboard(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 6) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AfterSales(nip: widget.nip, data: widget.data),
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
                builder: (context) =>
                    ReportSTTPP(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Perencanaan(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InputMaterial(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InputDokumen(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 7) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TambahProject(nip: widget.nip, data: widget.data),
              ),
            );
          } else if (index == 8) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TambahStaff(nip: widget.nip, data: widget.data),
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
        _buildSubListTile('Tambah Staff', Icons.assignment_ind_rounded, 8, 35),
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
                  MaterialPageRoute(
                      builder: (context) =>
                          ListStaff(nip: widget.nip, data: widget.data)),
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
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage(nip: widget.nip, data: widget.data)),
                );
              },
              child: Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

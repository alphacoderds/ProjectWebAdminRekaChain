import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebAdmin/inputdokumen.dart';
import 'package:RekaChain/WebAdmin/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebAdmin/notification.dart';
import 'package:RekaChain/WebAdmin/perencanaan.dart';
import 'package:RekaChain/WebAdmin/profile.dart';
import 'package:RekaChain/WebAdmin/reportsttpp.dart';
import 'package:RekaChain/WebAdmin/tambahproject.dart';
import 'package:RekaChain/WebAdmin/tambahstaff.dart';
import 'package:flutter/material.dart';

class Viewkm extends StatefulWidget {
  @override
  State<Viewkm> createState() => _ViewkmState();
}

class _ViewkmState extends State<Viewkm> {
  int _selectedIndex = 0;
  bool isViewVisible = false;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

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
                  builder: (context) => Viewkm(),
                );
              default:
                return null;
            }
          },
          home: Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDrawer(),
                Expanded(
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                      toolbarHeight: 65,
                      title: Padding(
                        padding:
                            EdgeInsets.only(left: screenHeight * 0.02, top: 2),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Kode Lot',
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        size: 30,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: screenHeight * 0.11),
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.005,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.file_download_outlined,
                                  size: 33,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () {},
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
                        child: _buildMainTable(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.only(right: 0.01, bottom: 8),
              child: SizedBox(
                width: 100.0,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InputMaterial()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(43, 56, 86, 1),
                  ),
                  child: Text(
                    'Kembali',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainTable() {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 50,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 200.0,
              horizontalMargin: 50.0,
              columns: [
                DataColumn(
                  label: Center(
                    child: Text(
                      'No',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Kode Material',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Deskripsi',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'SpecTech/Material',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'QTY',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Unit',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('1'),
                      ),
                    ),
                  ),
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('1'),
                      ),
                    ),
                  ),
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('1'),
                      ),
                    ),
                  ),
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('1'),
                      ),
                    ),
                  ),
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('1'),
                      ),
                    ),
                  ),
                  DataCell(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('1'),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
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
                builder: (context) => AdminDashboard(),
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
}

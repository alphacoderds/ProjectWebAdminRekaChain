import 'dart:convert';
import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebAdmin/editproject.dart';
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
import 'package:http/http.dart' as http;

class ListProject extends StatefulWidget {
  final Map<String, dynamic>? newProject;

  const ListProject({Key? key, this.newProject}) : super(key: key);
  @override
  State<ListProject> createState() => _ListProjectState();
}

class _ListProjectState extends State<ListProject> {
  int _selectedIndex = 0;
  bool isViewVisible = false;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  List _listdata = [];
  bool _isloading = true;

  String _searchQuery = '';

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future _getdata() async {
    try {
      final response = await http.get(
        Uri.parse(
<<<<<<< HEAD
          'http://192.168.9.3/ProjectWebAdminRekaChain/lib/Project/readproject.php',
=======
          'http://192.168.11.5/ProjectWebAdminRekaChain/lib/Project/readproject.php',
>>>>>>> fb7c7b17eb8cafd737d2c4090d5a7bc445479176
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    if (widget.newProject != null) {
      _listdata.add(widget.newProject!);
      updateData();
    }
    _getdata();
    super.initState();
  }

  Future<void> updateData() async {
    await _getdata();
    setState(() {});
  }

  Future<void> _hapusData(String id) async {
    try {
      final response = await http.post(
        Uri.parse(
<<<<<<< HEAD
          'http://192.168.9.3/ProjectWebAdminRekaChain/lib/Project/hapus.php',
=======
          'http://192.168.11.5/ProjectWebAdminRekaChain/lib/Project/hapus.php',
>>>>>>> fb7c7b17eb8cafd737d2c4090d5a7bc445479176
        ),
        body: {
          "kodeProject": id,
        },
      );

      print('Delete response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        await updateData();
      } else {
        print('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  List<String> dropdownItems = [];
  String? selectedValue;

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
                  builder: (context) => ListProject(),
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
                        padding: EdgeInsets.only(left: screenHeight * 0.01),
                        child: Text(
                          'List Project',
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
                          padding: EdgeInsets.only(right: screenHeight * 0.11),
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.005,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        onChanged: _updateSearchQuery,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Cari',
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
          ),
        );
      },
    );
  }

  Widget _buildMainTable() {
    List filteredData = _listdata.where((data) {
      String kodeProject = data['kodeProject'] ?? '';
      String namaProject = data['namaProject'] ?? '';
      return kodeProject.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          namaProject.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 50,
          ),
          child: DataTable(
            columnSpacing: 200.0,
            horizontalMargin: 50.0,
            columns: [
              DataColumn(
                label: Center(
                  child: Text(
                    'No',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Kode Project',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Nama Project',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Aksi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
            rows: filteredData
                .asMap()
                .map(
                  (index, data) => MapEntry(
                    index,
                    DataRow(
                      cells: [
                        DataCell(
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text((index + 1).toString()),
                            ),
                          ),
                        ),
                        DataCell(
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(data['kodeProject'] ?? ''),
                            ),
                          ),
                        ),
                        DataCell(
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(data['namaProject'] ?? ''),
                            ),
                          ),
                        ),
                        DataCell(
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditProject(
                                            selectedProject: {
                                              "no": filteredData[index]['no'],
                                              "kodeProject": filteredData[index]
                                                  ['kodeProject'],
                                              "namaProject": filteredData[index]
                                                  ['namaProject'],
                                            },
                                          ),
                                        ),
                                      ).then((result) {
                                        if (result != null && result) {
                                          updateData();
                                        }  
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      _showDeleteDialog(filteredData[index]
                                              ['kodeProject']
                                          .toString());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete", style: TextStyle(color: Colors.white)),
          content: Text("Apakah Anda yakin ingin menghapus data?",
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
              onPressed: () async {
                await _hapusData(id);
                Navigator.of(context).pop();
              },
              child: Text("Hapus", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
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

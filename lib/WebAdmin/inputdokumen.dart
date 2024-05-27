import 'dart:convert';

import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebAdmin/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebAdmin/notification.dart';
import 'package:RekaChain/WebAdmin/perencanaan.dart';
import 'package:RekaChain/WebAdmin/profile.dart';
import 'package:RekaChain/WebAdmin/reportsttpp.dart';
import 'package:RekaChain/WebAdmin/tambahproject.dart';
import 'package:RekaChain/WebAdmin/tambahstaff.dart';
import 'package:RekaChain/WebAdmin/viewupload.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class InputDokumen extends StatefulWidget {
  final DataModel data;
  final String nip;
  const InputDokumen({Key? key, required this.data, required this.nip})
      : super(key: key);

  @override
  State<InputDokumen> createState() => _InputDokumenState();
}

class _InputDokumenState extends State<InputDokumen> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  TextEditingController idprojectcontroller = TextEditingController();
  TextEditingController noProdukcontroller = TextEditingController();
  TextEditingController filecontroller = TextEditingController();
  TextEditingController tanggalcontroller = TextEditingController();

  int _selectedIndex = 0;
  late List<String> dropdownItemsIdProject = [];
  String? selectedValueIdProject;

  late List<String> dropdownItemsNoProduk = [];
  String? selectedValueNoProduk;

  List<PlatformFile> uploadFiles = [];
  Map<String, List<String>> projectMap = {};

  Future<void> _uploadDocument() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      List<PlatformFile> validFiles = [];
      for (var file in result.files) {
        if (file.size <= 5242880 && file.extension == 'pdf') {
          validFiles.add(file);
        } else {
          _showErrorDialog(file.name);
        }
      }
      setState(() {
        uploadFiles.addAll(validFiles);
      });
      if (validFiles.isNotEmpty) {
        print(
            'Dokumen berhasil diunggah: ${validFiles.map((file) => file.name)}');
      }
    } else {
      print('Pengguna membatalkan memilih file');
    }
  }

  void _showErrorDialog(String fileName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('File Gagal Diunggah'),
          content: Text('File $fileName terlalu besar atau bukan PDF.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _simpan() async {
    if (selectedValueIdProject != null && selectedValueNoProduk != null) {
      List<MultipartFile> filesToUpload = [];
      for (var file in uploadFiles) {
        filesToUpload.add(
          MultipartFile.fromBytes(
            file.bytes!,
            filename: file.name,
            contentType: MediaType('application', 'pdf'),
          ),
        );
      }

      var formData = FormData.fromMap({
        'id_project': selectedValueIdProject,
        'noProduk': selectedValueNoProduk,
        'tanggal': tanggalcontroller.text,
        'file': filesToUpload,
      });

      try {
        final response = await Dio().post(
          'http://192.168.8.152/ProjectWebAdminRekaChain/lib/Project/create_inputdokumen.php',
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
          ),
        );

        if (response.statusCode == 200) {
          final newProjectData = {
            'id_project': idprojectcontroller.text,
            'file': filecontroller.text,
            'noProduk': noProdukcontroller.text,
            'tanggal': tanggalcontroller.text,
          };

          _showFinishDialog();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ViewUpload(
                newProject: newProjectData,
                nip: widget.nip,
                data: widget.data,
              ),
            ),
          );
        } else {
          print('Gagal menyimpan data: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print('Mohon lengkapi nama project.');
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? _picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        final formattedDate = DateFormat('dd-MM-yyyy').format(_picked);
        controller.text = formattedDate;
      });
    }
  }

  Future<void> fetchProject() async {
    final response = await http.get(Uri.parse(
        'http://192.168.8.152/ProjectWebAdminRekaChain/lib/Project/readlot.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      Map<String, List<String>> projectMap = {};

      for (var project in data) {
        String nama = project['nama'].toString();
        String noProduk = project['noProduk'].toString();

        if (projectMap.containsKey(nama)) {
          projectMap[nama]!.add(noProduk);
        } else {
          projectMap[nama] = [noProduk];
        }
      }

      setState(() {
        dropdownItemsIdProject = ['--Pilih Nama/Kode Project--'];
        dropdownItemsIdProject.addAll(projectMap.keys);

        this.projectMap = projectMap;
        dropdownItemsNoProduk = ['--Pilih No Produk--'];
      });
    } else {
      throw Exception('Failed to load project names');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProject();
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
                      InputDokumen(data: widget.data, nip: widget.nip),
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
                            'Input Dokumen Pendukung',
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
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewUpload(
                                              data: widget.data,
                                              nip: widget.nip)),
                                    );
                                  },
                                  child: Text(
                                    'View',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Color.fromARGB(255, 89, 100, 122),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
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
                      body: Center(
                        child: _buildMainTable(),
                      ),
                    ),
                  ),
                ],
              ),
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
                    _simpan();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(43, 56, 86, 1),
                  ),
                  child: Text(
                    'Simpan',
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
          child: Row(
            children: [
              Center(
                child: Container(
                  width: screenWidth * 0.79,
                  height: screenHeight * 0.75,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.09,
                        horizontal: screenWidth * 0.05),
                    child: Row(
                      children: [
                        SizedBox(width: screenWidth * 0.05),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama Project',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedValueIdProject,
                                      hint: Text('--Pilih Nama Project--'),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedValueIdProject = newValue;
                                          if (projectMap
                                              .containsKey(newValue)) {
                                            dropdownItemsNoProduk = [
                                              '--Pilih No Produk--'
                                            ];
                                            dropdownItemsNoProduk
                                                .addAll(projectMap[newValue]!);
                                          } else {
                                            dropdownItemsNoProduk = [
                                              '--Pilih No Produk--'
                                            ];
                                          }

                                          selectedValueNoProduk = null;
                                        });
                                      },
                                      items: dropdownItemsIdProject
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Upload',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    width: 2000,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            SizedBox(width: 8),
                                            IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                size: 35,
                                              ),
                                              onPressed: () {
                                                _uploadDocument();
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: uploadFiles.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title:
                                                  Text(uploadFiles[index].name),
                                              trailing: IconButton(
                                                icon: Icon(Icons.remove_circle),
                                                onPressed: () {
                                                  setState(() {
                                                    uploadFiles.removeAt(index);
                                                  });
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Input Dokumen',
                                      ),
                                      TextSpan(
                                        style: TextStyle(
                                          color: Colors.blueAccent[700],
                                        ),
                                        text: ' Berupa Pdf',
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'No Produk',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: DropdownButton<String>(
                                      alignment: Alignment.center,
                                      hint: Text('--Pilih No Produk--'),
                                      value: selectedValueNoProduk,
                                      underline: SizedBox(),
                                      borderRadius: BorderRadius.circular(5),
                                      items: dropdownItemsNoProduk
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedValueNoProduk = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tanggal',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 90,
                                    width: 150,
                                    child: TextField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      textAlign: TextAlign.center,
                                      controller: tanggalcontroller,
                                      readOnly: true,
                                      onTap: () {
                                        _selectDate(tanggalcontroller);
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 2,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
                    ReportSTTPP(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Perencanaan(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InputMaterial(data: widget.data, nip: widget.nip),
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
                    TambahProject(data: widget.data, nip: widget.nip),
              ),
            );
          } else if (index == 8) {
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
                _simpan();
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
}

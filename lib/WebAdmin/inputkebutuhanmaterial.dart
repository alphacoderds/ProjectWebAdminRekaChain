import 'dart:convert';
import 'dart:io' as io;
import 'package:csv/csv.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:RekaChain/WebAdmin/AfterSales.dart';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebAdmin/inputdokumen.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebAdmin/notification.dart';
import 'package:RekaChain/WebAdmin/perencanaan.dart';
import 'package:RekaChain/WebAdmin/profile.dart';
import 'package:RekaChain/WebAdmin/reportsttpp.dart';
import 'package:RekaChain/WebAdmin/tambahproject.dart';
import 'package:RekaChain/WebAdmin/tambahstaff.dart';
import 'package:RekaChain/WebAdmin/viewmaterial.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:barcode_image/barcode_image.dart';

class InputMaterial extends StatefulWidget {
  final DataModel data;
  final String nip;
  const InputMaterial({super.key, required this.data, required this.nip});

  @override
  State<InputMaterial> createState() => _InputMaterialState();
}

class _InputMaterialState extends State<InputMaterial> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  TextEditingController idprojectcontroller = TextEditingController();
  TextEditingController kodelotcontroller = TextEditingController();
  TextEditingController filecontroller = TextEditingController();

  Widget? qrCodeWidget;
  String? savedKodeLot;

  int _selectedIndex = 0;
  late List<String> dropdownItemsIdProject = [];
  String? selectedValueIdProject;

  late List<String> dropdownItemsKodeLot = [];
  String? selectedValueKodeLot;

  List<PlatformFile> uploadFiles = [];

  Map<String, List<String>> projectMap = {};

  Future<bool> _isValidCSV(Uint8List fileBytes) async {
    try {
      final csvData = utf8.decode(fileBytes);
      final List<List<dynamic>> csvList =
          const CsvToListConverter().convert(csvData);
      return csvList.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> _uploadDocument() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      bool isValidCSV = await _isValidCSV(fileBytes);

      if (isValidCSV) {
        setState(() {
          uploadFiles.add(result.files.single);
        });
        print('Dokumen berhasil diunggah: ${result.files.single.name}');
      } else {
        _showErrorDialog(result.files.single.name);
      }
    }
  }

  void _showErrorDialog(String fileName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('File Gagal Diunggah',
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
          content: Text('File $fileName tidak valid atau bukan file CSV.',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<List<dynamic>>> parseCSV(io.File file) async {
    final input = file.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    return fields;
  }

  Future<void> _simpan() async {
    if (selectedValueIdProject != null && selectedValueKodeLot != null) {
      List<MultipartFile> filesToUpload = [];
      for (var file in uploadFiles) {
        filesToUpload.add(
          MultipartFile.fromBytes(
            file.bytes!,
            filename: file.name,
            contentType: MediaType('xls', 'csv'),
          ),
        );
      }

      var formData = FormData.fromMap({
        'id_project': selectedValueIdProject,
        'kodeLot': selectedValueKodeLot,
        'file': filesToUpload,
      });

      try {
        final response = await Dio().post(
          'http://192.168.9.31/ProjectWebAdminRekaChain/lib/Project/create_material.php',
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
          ),
        );

        if (response.statusCode == 200) {
          setState(() {
            savedKodeLot = selectedValueKodeLot;
          });
          _generateBarcode(savedKodeLot!);
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

  Future<void> fetchProject() async {
    final response = await http.get(Uri.parse(
        'http://192.168.9.31/ProjectWebAdminRekaChain/lib/Project/readlistproject.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      Map<String, List<String>> projectMap = {};

      for (var project in data) {
        String namaProject = project['nama'].toString();
        String kodeLot = project['kodeLot'].toString();

        if (projectMap.containsKey(namaProject)) {
          projectMap[namaProject]!.add(kodeLot);
        } else {
          projectMap[namaProject] = [kodeLot];
        }
      }

      setState(() {
        dropdownItemsIdProject = ['--Pilih Nama/Kode Project--'];
        dropdownItemsIdProject.addAll(projectMap.keys);

        this.projectMap = projectMap;

        dropdownItemsKodeLot = ['--Pilih Kode Lot--'];
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

  GlobalKey _qrCodeKey = GlobalKey();

  void _generateBarcode(String kodeLot) async {
    String kodeLot = selectedValueKodeLot ?? "";
    String id_project = selectedValueIdProject ?? "";

    setState(() {
      qrCodeWidget = Builder(
        builder: (context) => RepaintBoundary(
          key: _qrCodeKey,
          child: Column(
            children: [
              BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: kodeLot,
                color: Colors.black,
                height: 200,
                width: 200,
              ),
              SizedBox(height: 10),
              Text(
                '$id_project - $kodeLot',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      saveQRCodeAsImage(_qrCodeKey, kodeLot);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title:
              Text('QR Code Kode Lot', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
          content: Container(
            width: 245,
            height: 245,
            child: qrCodeWidget,
          ),
          actions: [
            TextButton(
              onPressed: () {
                saveQRCodeAsImage(_qrCodeKey, kodeLot);
              },
              child: Text("Download", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 40),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                final newProjectData = {
                  'id_project': idprojectcontroller.text,
                  'file': filecontroller.text,
                  'kodeLot': kodelotcontroller.text,
                };
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewMaterial(
                      newProject: newProjectData,
                      data: widget.data,
                      nip: widget.nip,
                    ),
                  ),
                );
              },
              child: Text("Selesai", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    });
  }

  Future<void> saveQRCodeAsImage(GlobalKey qrKey, String kodeLot) async {
    try {
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final blob = html.Blob([pngBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', '$kodeLot.png')
        ..click();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print("Error saving QR code: $e");
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
                      InputMaterial(data: widget.data, nip: widget.nip),
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
                            'Input Kebutuhan Material',
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
                                          builder: (context) => ViewMaterial(
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
                                              data: widget.data,
                                              nip: widget.nip)),
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
                    backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
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
                                      alignment: Alignment.center,
                                      hint: Text('--Pilih Nama Project--'),
                                      value: selectedValueIdProject,
                                      underline: SizedBox(),
                                      borderRadius: BorderRadius.circular(5),
                                      items: dropdownItemsIdProject
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedValueIdProject = newValue;
                                          if (projectMap
                                              .containsKey(newValue)) {
                                            dropdownItemsKodeLot = [
                                              '--Pilih Kode Lot--'
                                            ];
                                            dropdownItemsKodeLot
                                                .addAll(projectMap[newValue]!);
                                          } else {
                                            dropdownItemsKodeLot = [
                                              '--Pilih Kode Lot--'
                                            ];
                                          }

                                          selectedValueKodeLot = null;
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
                                        text: 'Download Template',
                                      ),
                                      TextSpan(
                                        style: TextStyle(
                                          color: Colors.blueAccent[700],
                                        ),
                                        text: ' Input Kebutuhan Material',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            final uri = Uri.parse(
                                                'https://drive.google.com/file/d/1XEKzACP3Nz19LDtquCcKahi1v02mMBXV/view?usp=sharing');
                                            if (uri != null &&
                                                await canLaunchUrl(uri)) {
                                              await launchUrl(uri);
                                            } else {
                                              throw 'Could not launch URL';
                                            }
                                          },
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
                                    'Kode Lot',
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
                                      hint: Text('--Pilih Kode Lot--'),
                                      value: selectedValueKodeLot,
                                      underline: SizedBox(),
                                      borderRadius: BorderRadius.circular(5),
                                      items: dropdownItemsKodeLot
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedValueKodeLot = newValue;
                                        });
                                      },
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
      barrierDismissible: false,
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
                          ViewMaterial(data: widget.data, nip: widget.nip)),
                );
              },
              child: Text("Ya", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _launchURL(Uri url) async {
    if (url != null && await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

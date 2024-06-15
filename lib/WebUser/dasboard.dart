import 'dart:convert';
import 'package:RekaChain/WebAdmin/data_model.dart';
import 'package:RekaChain/WebUser/AfterSales.dart';
import 'package:RekaChain/WebUser/inputdokumen.dart';
import 'package:RekaChain/WebUser/inputkebutuhanmaterial.dart';
import 'package:RekaChain/WebAdmin/login.dart';
import 'package:RekaChain/WebUser/notification.dart';
import 'package:RekaChain/WebUser/perencanaan.dart';
import 'package:RekaChain/WebUser/profile.dart';
import 'package:RekaChain/WebUser/reportsttpp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDashboard extends StatefulWidget {
  final DataModel data;
  final String nip;
  const UserDashboard({Key? key, required this.data, required this.nip})
      : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selectedIndex = 0;

  bool isViewVisible = false;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  List<LotData> _listdata = [];
  bool _isloading = true;

  String _searchQuery = '';

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
    if (query.isNotEmpty) {
      List<LotData> filteredList = _listdata
          .where((lotData) =>
              lotData.nama.toLowerCase().contains(query.toLowerCase()) ||
              lotData.noProduk.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        _listdata = filteredList;
      });
    } else {
      _getdata();
    }
  }

  TextEditingController idLotcontroller = TextEditingController();
  TextEditingController namaProjectcontroller = TextEditingController();
  TextEditingController noProdukcontroller = TextEditingController();
  TextEditingController noIndukProdukcontroller = TextEditingController();
  TextEditingController noSeriAwalcontroller = TextEditingController();
  TextEditingController namaProdukcontroller = TextEditingController();
  TextEditingController jumlahLotcontroller = TextEditingController();
  TextEditingController kodeLotcontroller = TextEditingController();
  TextEditingController noSeriAkhircontroller = TextEditingController();
  TextEditingController tglMulaicontroller = TextEditingController();
  TextEditingController tglSelesaicontroller = TextEditingController();

  TextEditingController alurProses1controller = TextEditingController();
  TextEditingController kategori1controller = TextEditingController();
  TextEditingController detail1controller = TextEditingController();

  TextEditingController alurProses2controller = TextEditingController();
  TextEditingController kategori2controller = TextEditingController();
  TextEditingController detail2controller = TextEditingController();

  TextEditingController alurProses3controller = TextEditingController();
  TextEditingController kategori3controller = TextEditingController();
  TextEditingController detail3controller = TextEditingController();

  TextEditingController alurProses4controller = TextEditingController();
  TextEditingController kategori4controller = TextEditingController();
  TextEditingController detail4controller = TextEditingController();

  TextEditingController alurProses5controller = TextEditingController();
  TextEditingController kategori5controller = TextEditingController();
  TextEditingController detail5controller = TextEditingController();

  TextEditingController alurProses6controller = TextEditingController();
  TextEditingController kategori6controller = TextEditingController();
  TextEditingController detail6controller = TextEditingController();

  TextEditingController alurProses7controller = TextEditingController();
  TextEditingController kategori7controller = TextEditingController();
  TextEditingController detail7controller = TextEditingController();

  TextEditingController alurProses8controller = TextEditingController();
  TextEditingController kategori8controller = TextEditingController();
  TextEditingController detail8controller = TextEditingController();

  TextEditingController alurProses9controller = TextEditingController();
  TextEditingController kategori9controller = TextEditingController();
  TextEditingController detail9controller = TextEditingController();

  TextEditingController alurProses10controller = TextEditingController();
  TextEditingController kategori10controller = TextEditingController();
  TextEditingController detail10controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  Future<void> _getdata() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://rekachain.000webhostapp.com/Project/read_dashboard.php',
        ),
      );
      if (response.statusCode == 200) {
        final String responseBody = response.body;

        print('Response Body: $responseBody');

        final List<dynamic> rawData = jsonDecode(responseBody);

        print('Raw Data: $rawData');

        List<LotData> lotDataList =
            rawData.map((item) => LotData.fromJson(item)).toList();

        setState(() {
          _listdata = lotDataList.reversed.toList();
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isloading = false;
      });
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
                  UserDashboard(nip: widget.nip, data: widget.data),
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
                                  builder: (context) => Notifikasi(
                                      nip: widget.nip, data: widget.data),
                                ),
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
                                      data: widget.data, nip: widget.nip),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                body: _isloading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemCount: _listdata.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          LotData data = _listdata[index];

                          return Column(
                            children: [
                              Text(
                                '${data.nama} | ${data.kodeLot} | ${data.noProduk}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: _buildHorizontalSteps(data),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }

  List<Widget> _buildHorizontalSteps(LotData data) {
    List<String> steps = [
      data.ap1,
      data.ap2,
      data.ap3,
      data.ap4,
      data.ap5,
      data.ap6,
      data.ap7,
      data.ap8,
      data.ap9,
      data.ap10,
    ];

    List<String> statuses = [
      data.status1,
      data.status2,
      data.status3,
      data.status4,
      data.status5,
      data.status6,
      data.status7,
      data.status8,
      data.status9,
      data.status10,
    ];

    List<Widget> stepWidgets = [];

    for (int index = 0; index < steps.length; index++) {
      if (steps[index].isNotEmpty) {
        stepWidgets.add(
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Tooltip(
                  message: statuses[index] == 'sudah dikerjakan'
                      ? 'Sudah dikerjakan'
                      : statuses[index] == 'sedang dikerjakan'
                          ? 'Sedang dikerjakan'
                          : '',
                  child: Icon(
                    statuses[index] == 'sudah dikerjakan'
                        ? Icons.check_circle
                        : statuses[index] == 'sedang dikerjakan'
                            ? Icons.radio_button_unchecked
                            : Icons.radio_button_unchecked_rounded,
                    color: statuses[index] == 'sudah dikerjakan'
                        ? const Color.fromRGBO(43, 56, 86, 1)
                        : statuses[index] == 'sedang dikerjakan'
                            ? const Color.fromRGBO(43, 56, 86, 1)
                            : Colors.grey,
                    size: 40,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  steps[index].length > 15
                      ? steps[index].substring(0, 15) + '...'
                      : steps[index],
                ),
              ],
            ),
          ),
        );
      }
    }

    return stepWidgets;
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
                    UserDashboard(nip: widget.nip, data: widget.data),
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
          }
        }
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

class LotData {
  final String nama;
  final String kodeLot;
  final String noProduk;
  final int currentStep;
  final String ap1;
  final String ap2;
  final String ap3;
  final String ap4;
  final String ap5;
  final String ap6;
  final String ap7;
  final String ap8;
  final String ap9;
  final String ap10;
  final String status1;
  final String status2;
  final String status3;
  final String status4;
  final String status5;
  final String status6;
  final String status7;
  final String status8;
  final String status9;
  final String status10;

  LotData({
    required this.nama,
    required this.kodeLot,
    required this.noProduk,
    required this.currentStep,
    required this.ap1,
    required this.ap2,
    required this.ap3,
    required this.ap4,
    required this.ap5,
    required this.ap6,
    required this.ap7,
    required this.ap8,
    required this.ap9,
    required this.ap10,
    required this.status1,
    required this.status2,
    required this.status3,
    required this.status4,
    required this.status5,
    required this.status6,
    required this.status7,
    required this.status8,
    required this.status9,
    required this.status10,
  });

  factory LotData.fromJson(Map<String, dynamic> json) {
    return LotData(
      nama: json['nama'],
      kodeLot: json['kodeLot'],
      noProduk: json['noProduk'],
      currentStep: json['currentStep'] ?? 0,
      ap1: json['ap1'].toString(),
      ap2: json['ap2'].toString(),
      ap3: json['ap3'].toString(),
      ap4: json['ap4'].toString(),
      ap5: json['ap5'].toString(),
      ap6: json['ap6'].toString(),
      ap7: json['ap7'].toString(),
      ap8: json['ap8'].toString(),
      ap9: json['ap9'].toString(),
      ap10: json['ap10'].toString(),
      status1: json['status1'].toString(),
      status2: json['status2'].toString(),
      status3: json['status3'].toString(),
      status4: json['status4'].toString(),
      status5: json['status5'].toString(),
      status6: json['status6'].toString(),
      status7: json['status7'].toString(),
      status8: json['status8'].toString(),
      status9: json['status9'].toString(),
      status10: json['status10'].toString(),
    );
  }
}

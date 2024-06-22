import 'dart:convert';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebAdmin/provider/user_provider.dart';
import 'package:RekaChain/WebUser/dasboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:RekaChain/WebAdmin/data_model.dart';

class LoginPage extends StatefulWidget {
  final DataModel data;
  final String nip;
  const LoginPage({Key? key, required this.data, required this.nip})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _selectedIndex = 0;
  double hintTextSize = 14;
  bool obscureText = true;
  bool isViewVisible = false;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  TextEditingController nipController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<dynamic> _additionalStaffData = [];
  bool visible = false;

  @override
  void initState() {
    super.initState();
    nipController = TextEditingController();
    passwordController = TextEditingController();
  }

  String hashPassword(String password) {
    var bytes =
        utf8.encode(password); // Mengonversi string password ke bytes UTF-8
    var digest =
        sha1.convert(bytes); // Menghitung hash SHA-1 dari bytes password
    return digest.toString(); // Mengembalikan hash sebagai string
  }

  @override
  void dispose() {
    nipController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> validateLogin(String nip, String password) async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.10.102/ProjectWebAdminRekaChain/lib/Project/validate_login.php'),
      body: {
        'nip': nip,
        'password': hashPassword(password),
      },
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return responseData['status'] == 'Sukses';
    } else {
      print('Failed to validate login: ${response.statusCode}');
      return false;
    }
  }

  Future<String?> getUserRole(String nip) async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.10.102/ProjectWebAdminRekaChain/lib/Project/test.php'),
      body: {
        'nip': nip,
      },
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return responseData['role'];
    } else {
      print('Failed to get user role: ${response.statusCode}');
      return null;
    }
  }

  Future<void> _login() async {
    String nip = nipController.text;
    String password = passwordController.text;

    if (nip.isEmpty || password.isEmpty) {
      _showAlertDialog(
          'Login Failed', 'Please enter both username and password.');
      return;
    }

    final response = await http.post(
      Uri.parse(
          'http://192.168.10.102/ProjectWebAdminRekaChain/lib/Project/test.php'),
      body: {
        'nip': nip,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      _showAlertDialog('Login Failed', 'Username or password is incorrect.');
    } else {
      var jsonData = json.decode(response.body);
      dynamic data = (jsonData as Map<String, dynamic>);
      String role = data['role'];
      context
          .read<UserProvider>()
          .saveNip(nipController.text.toString(), passwordController.text);

      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AdminDashboard(nip: widget.nip, data: widget.data)),
        );
      } else if (role == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UserDashboard(data: widget.data, nip: widget.nip)),
        );
      } else {
        _showAlertDialog('Login Failed', 'Invalid user role.');
      }
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

//batas
  Future loginbtn() async {
    final hashedPassword = hashPassword(passwordController.text);
    var response = await http.post(
        Uri.parse(
            'http://192.168.10.102/ProjectWebAdminRekaChain/lib/Project/create_login.php'),
        body: {"nip": nipController.text, "password": hashedPassword});
    var jsonData = jsonDecode(response.body);
    dynamic data = (jsonData as Map<String, dynamic>);
    DataModel dataStaff = DataModel.getDataFromJson(data['data']);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == "Success") {
        String role = data['role']; // Mengambil peran pengguna dari respons
        context
            .read<UserProvider>()
            .saveNip(nipController.text.toString(), passwordController.text);

        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AdminDashboard(nip: nipController.text, data: widget.data)),
          );
        } else if (role == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    UserDashboard(nip: widget.nip, data: widget.data)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Username atau password salah'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal melakukan login. Silakan coba lagi.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) =>
                  LoginPage(data: widget.data, nip: widget.nip),
            );
          default:
            return null;
        }
      },
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: _page(),
        ),
      ),
    );
  }

  Widget _page() {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.010,
              left: screenWidth * 0,
              right: screenWidth * 0.025,
            ),
            child: Image(
              image: const AssetImage('assets/images/bolder31.png'),
              width: screenWidth * 1.9,
              height: screenHeight * 0.17,
              alignment: Alignment.centerLeft,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              SizedBox(
                width: screenWidth * 0.001,
              ),
              Image.asset(
                'assets/images/gudang.png',
                width: screenWidth * 0.4,
              ),
              SizedBox(
                width: screenWidth * 0.08,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.20),
                  Image.asset(
                    'assets/images/logoREKA.png',
                    width: screenWidth * 0.2,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "REKA CHAIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "PT. REKAINDO GLOBAL JASA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  Text(
                    "Username :",
                    style: TextStyle(fontSize: screenHeight * 0.023),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  _inputField("Username", nipController,
                      backgroundColor: Colors.white),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    "Password :",
                    style: TextStyle(fontSize: screenHeight * 0.023),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  _inputFieldPassword("Password", passwordController,
                      isPassword: true, backgroundColor: Colors.white),
                  SizedBox(height: screenHeight * 0.03),
                  _loginBtn(),
                  Expanded(child: Container())
                ],
              ),
            ]),
          ),
          Positioned(
            bottom: -screenHeight * 0.001,
            left: 0,
            child: Image(
              image: const AssetImage('assets/images/icon.png'),
              width: screenWidth * 1.89,
              height: screenHeight * 0.17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false, Color? backgroundColor}) {
    return SizedBox(
      width: screenWidth * 0.35,
      height: screenHeight * 0.06,
      child: Center(
        child: TextField(
          style: const TextStyle(
              color: Color.fromARGB(255, 8, 8, 8), fontSize: 18),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color.fromARGB(255, 73, 72, 72),
              fontSize: hintTextSize * screenHeight / 700,
            ),
            fillColor: backgroundColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ),
    );
  }

  Widget _inputFieldPassword(String hintText, TextEditingController controller,
      {bool isPassword = false, Color? backgroundColor}) {
    return SizedBox(
      width: screenWidth * 0.35,
      height: screenHeight * 0.06,
      child: Center(
        child: TextField(
          style: const TextStyle(
              color: Color.fromARGB(255, 8, 8, 8), fontSize: 18),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color.fromARGB(255, 73, 72, 72),
              fontSize: hintTextSize * screenHeight / 700,
            ),
            fillColor: backgroundColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null,
          ),
          obscureText: obscureText,
        ),
      ),
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: _login, // Call login function when button is pressed
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: SizedBox(
        width: screenWidth * 0.317,
        height: screenHeight * 0.05,
        child: Center(
          child: Text(
            "LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenHeight * 0.021,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:RekaChain/WebAdmin/dasboard.dart';
import 'package:RekaChain/WebUser/dasboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'package:RekaChain/WebAdmin/liststaff.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
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

  @override
  void dispose() {
    nipController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> validateLogin(String nip, String password) async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.11.60/ProjectWebAdminRekaChain/lib/Project/validate_login.php'),
      body: {
        'nip': nip,
        'password': password,
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
          'http://192.168.11.60/ProjectWebAdminRekaChain/lib/Project/validate_login.php'),
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

    bool isValid = await validateLogin(nip, password);

    if (isValid) {
      String? userRole = await getUserRole(nip);
      if (userRole == null) {
        _showAlertDialog('Login Failed', 'Failed to retrieve user role.');
        return;
      }

      if (userRole == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else if (userRole == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserDashboard()),
        );
      } else {
        _showAlertDialog('Login Failed', 'Invalid user role.');
      }
    } else {
      _showAlertDialog('Login Failed', 'Invalid username or password.');
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

//   Future<void> _ceklogin() async {
//     setState(() {
//       visible = true;
//     });

//     final prefs = await SharedPreferences.getInstance();
//     var params = "create_login.php?nip=" +
//         nipController.text +
//         "&password=" +
//         passwordController.text;

//     try {
//       var res = await http.get(Uri.parse(sUrl + params));
//       if (res.statusCode == 200) {
//         var response = json.decode(res.body);
//         if (response['response_status'] == "OK") {
//           prefs.setBool('create_login', true);
//           setState(() {
//             visible = false;
//           });

//           Navigator.of(context).pushNamedAndRemoveUntil(
//               '/landing', (Route<dynamic> route) => false);
//         } else {
//           setState(() {
//             visible = false;
//           });
//           _showAlertDialog(context as String, response['response_message']);
//         }
//       }
//     } catch (e) {
//       setState(() {
//         visible = false;
//       });
//     }
//   }

//   void _showAlertDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Color.fromRGBO(43, 56, 86, 1),
//           title: Text(
//             title,
//             style: TextStyle(color: Colors.white),
//           ),
//           content: Text(
//             message,
//             style: TextStyle(color: Colors.white),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'OK',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   String? _validateUsername(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Username h arus diisi';
//     }
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password harus diisi';
//     }
//     return null;
//   }

//   String hashPassword(String password) {
//     var bytes =
//         utf8.encode(password); // Mengonversi string password ke bytes UTF-8
//     var digest =
//         sha1.convert(bytes); // Menghitung hash SHA-1 dari bytes password
//     return digest.toString(); // Mengembalikan hash sebagai string
//   }

//   Future<void> _login() async {
//     String nip = nipController.text;
//     String password = passwordController.text;
//     String hashedPassword = hashPassword(passwordController.text);

//     // var url =
//     //     'http://192.168.11.60/ProjectWebAdminRekaChain/lib/Project/create_login.php';
//     // var response = await http.post(Uri.parse(url), body: {
//     //   'nip': nip,
//     //   'password': password,
//     // });

//     // var requestBody = {
//     //   'nip': nip,
//     //   'password': password,
//     // };

//     // var jsonResponse = json.decode(response.body);

//     if (nip.isEmpty || password.isEmpty) {
//       _showAlertDialog(
//           'Login Failed', 'Please enter both username and password.');
//       return;
//     }

//     bool isValid = await validateLogin(nip, password);

//     Future<bool> validateLogin(String nip, String password) async {
//   // Lakukan pengiriman permintaan HTTP untuk memeriksa validitas login ke server
//   final response = await http.post(
//     Uri.parse(
//         'http://192.168.11.60/ProjectWebAdminRekaChain/lib/Project/validate_login.php'), // Ganti dengan URL endpoint untuk validasi login
//     body: {
//       'nip': nip,
//       'password': password,
//     },
//   );

//   if (response.statusCode == 200) {
//     // Jika koneksi berhasil dan mendapat respons dari server
//     var responseData = json.decode(response.body);
//     // Lakukan pengecekan terhadap respons dari server
//     // Misalnya, jika server mengembalikan 'Sukses', maka login valid
//     // Jika tidak, login tidak valid
//     return responseData['status'] == 'Sukses';
//   } else {
//     // Tangani kesalahan jika gagal terhubung ke server atau server tidak merespons
//     // Misalnya, tampilkan pesan kesalahan atau log kesalahan
//     print('Failed to validate login: ${response.statusCode}');
//     return false;
//   }
// }

//     if (hashedPassword == null) {
//       _showAlertDialog(
//           'Login Failed', 'Failed to hash the password. Please try again.');
//       return;
//     }

//     final Map<String, dynamic> requestData = {
//       'username': nip,
//       'password': password
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(
//             'http://192.168.11.60/ProjectWebAdminRekaChain/lib/Project/create_login.php'),
//         body: jsonEncode(requestData),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.body);
//         String? message = responseData['pesan'];
//         String? token = responseData['token'];
//         String? role = responseData['peran'];

//         if (message == 'Sukses') {
//           if (token != null && role != null) {
//             if (role == 'admin') {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AdminDashboard()),
//               );
//             } else if (role == 'staff') {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => UserDashboard()),
//               );
//             } else {
//               _showAlertDialog('Login Failed', 'Invalid role.');
//             }
//           } else {
//             _showAlertDialog(
//                 'Error', 'Server response is missing required data.');
//           }
//         } else {
//           _showAlertDialog(
//               'Login Failed', message ?? 'Invalid username or password.');
//         }
//       } else {
//         _showAlertDialog('Error', 'Failed to connect to the server.');
//       }
//     } catch (e) {
//       _showAlertDialog('Error', 'An error occurred: $e');
//     }
//   }

//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse(
//         'http://192.168.11.60/ProjectWebAdminRekaChain/lib/Project/readlogin.php'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _additionalStaffData = json.decode(response.body);
//       });
//     } else {
//       // Tangani kesalahan jika terjadi
//       print('Failed to load data: ${response.statusCode}');
//     }
//   }

//batas

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
              builder: (context) => LoginPage(),
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
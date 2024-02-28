import 'package:RekaChain/dasboard.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _selectedIndex = 0;
  late TextEditingController nipController;
  late TextEditingController passwordController;
  double hintTextSize = 14;
  bool obscureText = true;
  bool isViewVisible = false;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    nipController = TextEditingController();
    passwordController = TextEditingController();
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
              fontSize: hintTextSize * screenWidth / 1200,
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
              fontSize: hintTextSize * screenWidth / 1200,
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ),
        );
      },
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

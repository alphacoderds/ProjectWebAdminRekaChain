import 'package:flutter/material.dart';

class logoutPage extends StatefulWidget {
  const logoutPage({super.key});

  @override
  State<logoutPage> createState() => _logoutPageState();
}

class _logoutPageState extends State<logoutPage> {
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.4,
                width: screenWidth * 0.3,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(43, 56, 86, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Apakah Anda Yakin Logout?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromRGBO(43, 56, 86, 1),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.012,
                              horizontal: screenWidth * 0.015,
                            ),
                            child: Text(
                              "Tidak",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromRGBO(43, 56, 86, 1),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.012,
                              horizontal: screenWidth * 0.015,
                            ),
                            child: Text(
                              "Ya",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.15,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Image.asset(
              'assets/images/icon.png',
              height: screenHeight * 0.25,
            ),
          ])
        ],
      ),
    );
  }
}

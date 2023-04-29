import 'package:flutter/material.dart';
import 'package:flutter_login_arp/utils/responsive.dart';

import 'package:flutter_login_arp/components/circle.dart';
import 'package:flutter_login_arp/components/icon_container.dart';
import 'package:flutter_login_arp/components/login_form.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    Size deviceSize = MediaQuery.of(context).size; // esto me da el tama*o
    // del dispositivo que visualiza el apk
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              width: responsive.widht,
              height: responsive.height,
              color: const Color.fromARGB(255, 237, 243, 241),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      right: -50,
                      top: -120,
                      child: CircleComponet(
                        size: deviceSize.width * 0.8,
                        colors: const [
                          Color.fromARGB(255, 243, 63, 57),
                          Color.fromARGB(255, 221, 23, 23)
                        ],
                      )),
                  Positioned(
                      left: -50,
                      top: -120,
                      child: CircleComponet(
                        size: deviceSize.width * 0.6,
                        colors: const [Colors.orange, Colors.deepOrange],
                      )),
                  Positioned(
                      top: 130,
                      child: Column(
                        children: [
                          iconConrainer(),
                          SizedBox(height: 30),
                          Text(
                            'Hello Again\nWelcome Back!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      )),
                  LoginFrom()
                ],
              ),
            ),
          )),
    );
  }
}

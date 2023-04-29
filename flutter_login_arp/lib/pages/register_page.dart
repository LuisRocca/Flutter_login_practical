import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_arp/components/avatar_icon.dart';
import 'package:flutter_login_arp/components/register_form.dart';
import 'package:flutter_login_arp/utils/responsive.dart';

import 'package:flutter_login_arp/components/circle.dart';
import 'package:flutter_login_arp/components/icon_container.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                      right: -70,
                      top: -100,
                      child: CircleComponet(
                        size: deviceSize.width * 0.8,
                        colors: const [
                          Color.fromARGB(255, 243, 63, 57),
                          Color.fromARGB(255, 221, 23, 23)
                        ],
                      )),
                  Positioned(
                      left: -50,
                      top: -100,
                      child: CircleComponet(
                        size: deviceSize.width * 0.6,
                        colors: const [Colors.orange, Colors.deepOrange],
                      )),
                  Positioned(
                      top: 70,
                      child: Column(
                        children: [
                          // iconConrainer(),
                          // SizedBox(height: 30),
                          Text(
                            'Hello!\nSign up to get started!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          AvatarIcon()
                        ],
                      )),
                  RegisterForm(),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: SafeArea(
                      child: CupertinoButton(
                          color: Colors.black26,
                          padding: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(30),
                          child: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context)),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

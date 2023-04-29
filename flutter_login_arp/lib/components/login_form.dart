import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_login_arp/api/authentication_api.dart';
import 'package:flutter_login_arp/components/input_text.dart';
import 'package:flutter_login_arp/utils/dialogs.dart';
import 'package:flutter_login_arp/utils/responsive.dart';
import 'package:get_it/get_it.dart';

import '../data/authentication_client.dart';

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  String _email = '', _password = '';
  Future<void> _onSubmit() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk == true) {
      ProgressDialog.show(context);

      final response =
          await _authenticationApi.login(email: _email, password: _password);
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data!);
        Navigator.pushNamedAndRemoveUntil(context, 'home', (_) => false);
      } else {
        //  _logger.e('register data code ${response.error.data}');
        String message = '';
        switch (response.error?.statusCode) {
          case 403:
            message = 'Invalid password';
            break;
          case 404:
            message = 'Invalid User';
            break;
          case -1:
            message = 'network connection error';
            break;
          default:
        }
        Dialogs.alert(context, title: 'ERROR', description: message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Container(
          constraints: BoxConstraints(
            maxWidth: responsive.isTablet ? 430 : 360,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputText(
                  onChanged: (text) => _email = text,
                  validator: (text) {
                    if (!text.toString().contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  label: 'EMAIL ADDRESS',
                  keyboardType: TextInputType.emailAddress,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  child: Row(
                    children: [
                      Expanded(
                        child: InputText(
                          onChanged: (text) => _password = text,
                          validator: (text) {
                            if (text.toString().length <= 5) {
                              return 'the Password must be at least 6 characters long ';
                            }
                            return null;
                          },
                          label: 'PASSWORD',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          borderEnabled: false,
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _onSubmit,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color.fromARGB(255, 248, 145, 28),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New to Friendly Desi?'),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, 'register'),
                        child: Text(
                          'Sing up',
                          style: TextStyle(color: Colors.orange),
                        ))
                  ],
                )
              ],
            ),
          )),
    );
  }
}

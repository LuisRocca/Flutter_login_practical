import 'package:flutter/material.dart';
import 'package:flutter_login_arp/api/authentication_api.dart';
import 'package:flutter_login_arp/components/input_text.dart';
import 'package:flutter_login_arp/utils/dialogs.dart';
import 'package:flutter_login_arp/utils/responsive.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../data/authentication_client.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  final _authenticationApi = GetIt.instance<AuthenticationApi>();
  final Logger _logger = Logger();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username = '';
  // final AuthenticationApi _authenticationApi = AuthenticationApi();
  Future<void> _onSubmit() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk == true) {
      ProgressDialog.show(context);
      // _authenticationApi.validatorReaquest();

      final response = await _authenticationApi.register(
          username: _username, email: _email, password: _password);
      ProgressDialog.dissmiss(context);
      if (response.data != null && response.error == null) {
        await _authenticationClient.saveSession(response.data!);
        // _logger.i('register ok');
        Navigator.pushNamedAndRemoveUntil(context, 'home', (_) => false);
      } else {
        // _logger.e('register status code ${response.error.statusCode}');
        // _logger.e('register message ${response.error.message}');
        _logger.e('register data code ${response.error?.data}');
        String message = '';
        switch (response.error?.statusCode) {
          case 409:
            message =
                'try again with another user ${response.error?.data['duplicatedFields']} address as one of these already exists in the database.';
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
                  onChanged: (text) => _username = text,
                  validator: (text) {
                    if (text.toString().length < 2) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  label: 'USER NAME',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
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
                SizedBox(
                  width: 30,
                ),
                InputText(
                  obscureText: true,
                  onChanged: (text) => _password = text,
                  validator: (text) {
                    if (text.toString().length < 1) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  label: 'PASSWORD',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  width: 30,
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
                      'Sign Up',
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
                    Text('Already have an account?'),
                    TextButton(
                        onPressed: () => Navigator.pushNamed(context, 'login'),
                        child: Text(
                          'Sing in',
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

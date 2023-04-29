import 'dart:async';
import 'dart:convert';

import 'package:flutter_login_arp/api/authentication_api.dart';
import 'package:flutter_login_arp/models/authentication_response.dart';
import 'package:flutter_login_arp/models/session.dart';
import 'package:flutter_login_arp/utils/logs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationClient {
  final FlutterSecureStorage _secureStorage;
  final AuthenticationApi _authenticationApi;
  dynamic _completer;
  AuthenticationClient(this._secureStorage, this._authenticationApi);

  void _complete() {
    if (_completer != null && !_completer.isCompleted) {
      _completer.complete();
    }
  }

  Future<String?> get accessToken async {
    if (_completer != null) {
      await _completer.future;
    }

    // Logs.p.i("este es mi log ${DateTime.now()}");

    _completer = Completer();
    final data = await _secureStorage.read(key: 'SESSION');
    if (data != null) {
      final session = Session.fromJson(jsonDecode(data));
      final DateTime currentDate = DateTime.now();
      final DateTime createdAt = session.createdAt;
      final int expiresIn = session.expiresIn;
      final diff = currentDate.difference(createdAt).inSeconds;

      Logs.p.i('session Life time ${expiresIn - diff}');

      if (expiresIn - diff > 60) {
        _complete();

        return session.token;
      }
      final response = await _authenticationApi.refreshToken(session.token);
      if (response.data != null) {
        await saveSession(response.data!);
        _complete();

        return response.data!.token;
      }
      _complete();
      Logs.p.i("fin");

      return null;
    }
    _complete();
    return null;
  }

  Future<void> saveSession(
      AuthenticationResponse authenticationResponse) async {
    final Session session = Session(
      token: authenticationResponse.token,
      expiresIn: authenticationResponse.expiresIn,
      createdAt: DateTime.now(),
    );

    final data = jsonEncode(session.toJson());
    await _secureStorage.write(key: 'SESSION', value: data);
  }

  Future<void> signOut() async {
    await _secureStorage.deleteAll();
  }
}

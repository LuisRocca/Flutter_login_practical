import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_login_arp/data/authentication_client.dart';
import 'package:flutter_login_arp/helpers/http_response.dart';
import 'package:flutter_login_arp/models/user.dart';
import '../helpers/http.dart';

class AccountAPI {
  final Http _http;
  final AuthenticationClient _authenticationClient;

  AccountAPI(this._http, this._authenticationClient);

  Future<HttpResponse<User>> getUserInfo() async {
    final token = await _authenticationClient.accessToken;
    return _http.request<User>(
      '/api/v1/user-info',
      headers: {"token": token},
      parser: (data) => User.fromJson(data),
    );
  }

  Future<HttpResponse<String>> updateAvatarImage(
      Uint8List bytes, String fileName) async {
    final token = await _authenticationClient.accessToken;
    return _http.request<String>('/api/v1/update-avatar',
        method: 'POST',
        headers: {
          "token": token
        },
        formData: {
          "attachment": MultipartFile.fromBytes(bytes, filename: fileName)
        });
  }
}

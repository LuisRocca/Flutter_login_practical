import 'package:flutter_login_arp/helpers/http.dart';
import 'package:flutter_login_arp/helpers/http_response.dart';
import 'package:flutter_login_arp/models/authentication_response.dart';

class AuthenticationApi {
  final Http _http;
  AuthenticationApi(this._http);

  Future<HttpResponse<AuthenticationResponse>> register(
      {required String username,
      required String email,
      required String password}) {
    return _http.request<AuthenticationResponse>("/api/v1/register",
        method: "POST",
        data: {"username": username, "email": email, "password": password},
        parser: (data) => AuthenticationResponse.fromJson(data));
  }

  Future<HttpResponse<AuthenticationResponse>> login(
      {required String email, required String password}) async {
    return _http.request<AuthenticationResponse>("/api/v1/login",
        method: "POST",
        data: {"email": email, "password": password},
        parser: (data) => AuthenticationResponse.fromJson(data));
  }

  Future<HttpResponse<AuthenticationResponse>> refreshToken(
      String expiredToken) {
    return _http.request<AuthenticationResponse>("/api/v1/refresh-token",
        method: "POST",
        headers: {"token": expiredToken},
        parser: (data) => AuthenticationResponse.fromJson(data));
  }

  // Future<void> register(
  //     {required String username,
  //     required String email,
  //     required String password}) async {
  //   final Map<String, dynamic> data = {
  //     'username': username,
  //     'email': email,
  //     'password': password,
  //   };
  //   final String apiUrl =
  //       'http://192.168.20.13:9000/api/v1/register'; // URL de la API

  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode(data),
  //   );

  //   if (response.statusCode == 200) {
  //     // Si la respuesta es exitosa (código de respuesta 200)
  //     final jsonData = json.decode(response.body);
  //     // Decodifica la respuesta JSON a un Map
  //     print(jsonData); // Imprime el Map con los datos recibidos
  //   } else {
  //     print('Error en la solicitud: ${response.statusCode}');
  //   }
  // }

  // Future<void> validatorReaquest() async {
  //   try {
  //     final Response<String> response = await _dio.get<String>(
  //         "http://192.168.20.13:9000/",
  //         options: Options(headers: {"Content-Type": "application/json"}));
  //     // print(response.data);
  //     _logger.i(response.data);
  //     // response.data;
  //   } catch (e) {
  //     _logger.e(e);
  //   }
  // }
}

import 'package:dio/dio.dart';
import 'package:flutter_login_arp/api/account_api.dart';
import 'package:flutter_login_arp/api/authentication_api.dart';
import 'package:flutter_login_arp/data/authentication_client.dart';
import 'package:flutter_login_arp/helpers/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(BaseOptions(baseUrl: "http://182.178.23.13:9000"));
    Http http = Http(
      dio: dio,
      logsEnabled: true,
    );
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final autheticationApi = AuthenticationApi(http);
    final authenticationClient =
        AuthenticationClient(secureStorage, autheticationApi);
    final accountAPI = AccountAPI(http, authenticationClient);

    GetIt.instance.registerSingleton<AuthenticationApi>(autheticationApi);
    GetIt.instance
        .registerSingleton<AuthenticationClient>(authenticationClient);
    GetIt.instance.registerSingleton<AccountAPI>(accountAPI);
  }
}

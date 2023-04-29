import 'package:dio/dio.dart';
import 'package:flutter_login_arp/helpers/http_response.dart';
import 'package:flutter_login_arp/utils/logs.dart';

class Http {
  late Dio _dio;

  late bool _logsEnabled;
  Http({required Dio dio, required bool logsEnabled}) {
    _dio = dio;
    _logsEnabled = logsEnabled;
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    method = "GET",
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  }) async {
    try {
      // FormData formData = FormData.fromMap({});
      final response = await _dio.request(
        path,
        options: Options(method: method, headers: headers),
        queryParameters: queryParameters,
        data: formData != null ? FormData.fromMap(formData) : data,
      );
      Logs.p.i(response.data);
      if (parser != null) {
        return HttpResponse.success(parser(response.data));
      }
      return HttpResponse.success(response.data);
    } catch (e) {
      Logs.p.e(e);
      int statusCode = 0;
      String message = 'unknown error';
      dynamic data;
      if (e is DioError) {
        statusCode = -1;
        if (e.response != null) {
          statusCode = e.response!.statusCode!.toInt();
          message = e.response!.statusMessage.toString();
          data = e.response!.data;
        }
      }

      return HttpResponse.fail(
          statusCode: statusCode, message: message, data: data);
    }
  }
}

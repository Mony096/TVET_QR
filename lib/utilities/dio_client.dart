import 'dart:convert';
import 'dart:developer';

import 'package:npit_qr/utilities/storage/locale_storage.dart';
import 'package:dio/dio.dart';
import '../core/error/failure.dart';

class DioClient {
  Dio _dio = Dio();

  // Create a new CancelToken
  final cancelToken = CancelToken();

  DioClient() {
    _dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        // connectTimeout: const Duration(seconds: 5),
        // receiveTimeout: const Duration(seconds: 5),
      ),
    );
  }
  Future<Response> get(String uri,
      {Options? options, Map<String, dynamic>? query}) async {
    try {

      final res = await _dio.get(
        'https://bit-g1.npit-edu.com/api/student$uri',
        queryParameters: query,
        // options: Options(
        //   headers: {
        //     'Content-Type': "application/json",
        //     "Authorization": 'Bearer $token',
        //     'sapUrl': uri
        //   },
        // ),
        cancelToken: cancelToken,
      );
      return res;
    } on DioException catch (e) {
    log(e.requestOptions.method);
    log(e.requestOptions.uri.toString());
    log(jsonEncode(e.requestOptions.data));
    log('dio ${e.response?.statusCode}');
    log(jsonEncode(e.requestOptions.headers));

    if (e.response?.statusCode == null) {
      throw const ConnectionRefuse(
        message: "Invalid Server Configuration",
      );
    }

    if (e.type == DioExceptionType.connectionError) {
      throw const ConnectionRefuse(
        message: "Invalid server host name.",
      );
    }

    if (e.type == DioExceptionType.connectionTimeout) {
      throw const ConnectionRefuse(
        message:
            "Sorry, our server is currently unavailable. Please contact our support.",
      );
    }

    if (e.response?.statusCode == 401) {
      throw const UnauthorizeFailure(message: 'Session already timeout');
    }

    if (e.response?.statusCode == 404) {
      // 🔹 Return backend error instead of generic
      final message = e.response?.data is Map<String, dynamic>
          ? e.response?.data["error"] ?? "Not found"
          : "Not found";
      throw ServerFailure(message: message);
    }

    throw ServerFailure(
      message: e.response?.data is String
          ? e.response?.data
          : "An unexpected error occurred.",
    );
  } catch (e) {
    rethrow;
  }
}

  Future<Response> post(dynamic uri,
      {Options? options,
      Object? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final token = await LocalStorageManger.getString('SessionId');
      _dio.options.headers['Content-Type'] = "application/json";
      final host = await LocalStorageManger.getString('host');
      final port = await LocalStorageManger.getString('port');

      final response = await _dio.post(
        'https://$host:$port/b1s/v1$uri',
        data: data,
        options: Options(
          headers: {
            'Content-Type': "application/json",
            'Cookie': 'B1SESSION=$token; ROUTEID=.node9',
            // ...options,
          },
        ),
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      log(e.requestOptions.method);
      log(e.requestOptions.uri.toString());
      log(jsonEncode(e.requestOptions.data));
      log('dio ${e.response?.statusCode}');
      if (e.response?.statusCode == null) {
        throw const ConnectionRefuse(
          message: "Invalid Server Configuration",
        );
      }
      if (e.type == DioExceptionType.connectionError) {
        throw const ConnectionRefuse(
          message: "Invalid server host name.",
        );
      }

      if (e.type == DioExceptionType.connectionTimeout) {
        throw const ConnectionRefuse(
          message:
              "Sorry, our server is currently unavailable. Please contact our support.",
        );
      }

      if (e.response?.statusCode == 401) {
        throw const UnauthorizeFailure(
            message: 'Opps. Invalid Request or Time Out.');
      }

      throw ServerFailure(
        message: e.response?.data['error']['message']['value'] ??
            "An unexpected error occurred.",
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch(String uri,
      {Options? options,
      Object? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final token = await LocalStorageManger.getString('SessionId');
      _dio.options.headers['Content-Type'] = "application/json";
      final host = await LocalStorageManger.getString('host');
      final port = await LocalStorageManger.getString('port');

      final response = await _dio.patch(
        'https://$host:$port/b1s/v1$uri',
        data: data,
        options: Options(
          headers: {
            'Content-Type': "application/json",
            'Cookie': 'B1SESSION=$token; ROUTEID=.node9',
          },
        ),
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      log(e.requestOptions.method);
      log(e.requestOptions.uri.toString());
      log(jsonEncode(e.requestOptions.data));
      log('dio ${e.response?.statusCode}');

      if (e.response?.statusCode == null) {
        throw const ConnectionRefuse(
          message: "Invalid Server Configuration",
        );
      }
      if (e.type == DioExceptionType.connectionError) {
        throw const ConnectionRefuse(
          message: "Invalid server host name.",
        );
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw const ConnectionRefuse(
          message:
              "Sorry, our server is currently unavailable. Please contact our support.",
        );
      }
      if (e.response?.statusCode == 401) {
        throw const UnauthorizeFailure(
            message: 'Opps. Invalid Request or Time Out.');
      }

      throw ServerFailure(
        message: e.response?.data['error']['message']['value'] ??
            "An unexpected error occurred.",
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String uri,
      {Options? options,
      Object? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final token = await LocalStorageManger.getString('SessionId');
      _dio.options.headers['Content-Type'] = "application/json";
      final host = await LocalStorageManger.getString('host');
      final port = await LocalStorageManger.getString('port');

      final response = await _dio.put(
        'https://$host:$port/b1s/v1$uri',
        data: data,
        options: Options(
          headers: {
            'Content-Type': "application/json",
            'Cookie': 'B1SESSION=$token; ROUTEID=.node9',
          },
        ),
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      log(e.requestOptions.method);
      log(e.requestOptions.uri.toString());
      log(jsonEncode(e.requestOptions.data));
      log('dio ${e.response?.statusCode}');

      if (e.response?.statusCode == null) {
        throw const ConnectionRefuse(
          message: "Invalid Server Configuration",
        );
      }
      if (e.type == DioExceptionType.connectionError) {
        throw const ConnectionRefuse(
          message: "Invalid server host name.",
        );
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw const ConnectionRefuse(
          message:
              "Sorry, our server is currently unavailable. Please contact our support.",
        );
      }
      if (e.response?.statusCode == 401) {
        throw const UnauthorizeFailure(
            message: 'Opps. Invalid Request or Time Out.');
      }

      throw ServerFailure(
        message: e.response?.data['error']['message']['value'] ??
            "An unexpected error occurred.",
      );
    } catch (e) {
      rethrow;
    }
  }
}

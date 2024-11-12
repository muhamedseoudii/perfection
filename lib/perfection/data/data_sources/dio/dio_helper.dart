import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'end_points.dart';

abstract class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      followRedirects: false,

      // will not throw errors
      validateStatus: (status) => true,
    ));
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 70));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        "Accept": "application/json",
        "lang": lang,
      };
      return await dio.get(Uri.parse(url).toString(),
          queryParameters: query,
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
    } catch (error) {
      print("Errorrrr: ${error.toString()}");
      // if (error == DioExceptionType.connectionError) {
      //   AppFunctions.namedNavigateTo(
      //       context: context,
      //       navigatedScreen: RouteConstants.lostInternetConnection);
      // }
      rethrow;
    }
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      dynamic data,
      String lang = 'en',
      String? token,
      Map<String, dynamic>? headers,
      CancelToken? cancelToken}) async {
    try {
      dio.options.headers = headers ??
          {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-Type": "application/json",
          };
      return await dio.post(url,
          queryParameters: query,
          data: data,
          cancelToken: cancelToken,
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> putData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: query,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': '$token',
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      final response =
          await dio.delete(url, queryParameters: query, data: data);

      return response;
    } catch (error) {
      rethrow;
    }
  }
}

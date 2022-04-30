import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:urrevs_ui_mobile/app/exceptions.dart';

Dio get getDio {
  Dio dio = Dio();
  const int timeOut = 60 * 1000;
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    // HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  dio.options = BaseOptions(
    connectTimeout: timeOut,
    receiveTimeout: timeOut,
    headers: headers,
  );

  // check internet connection on each request
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        bool hasConnection = await InternetConnectionChecker().hasConnection;
        if (!hasConnection) throw NoInternetConnection();
        handler.next(options);
      },
    ),
  );

  // if (kDebugMode) {
  //   dio.interceptors.add(
  //     PrettyDioLogger(
  //         // requestHeader: true,
  //         // requestBody: true,
  //         // responseHeader: true,
  //         ),
  //   );
  // }

  return dio;
}

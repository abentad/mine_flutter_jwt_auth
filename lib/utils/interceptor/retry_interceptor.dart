import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_node_auth/utils/interceptor/dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      print(err.error);
      // if (err.error != null) {
      try {
        print('this got called');
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        return e;
      }
    }
    return err;
  }

  bool _shouldRetry(DioError error) {
    return error.type == DioErrorType.other && error.error != null && error.error == SocketException;
  }
}

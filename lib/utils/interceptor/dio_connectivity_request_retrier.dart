import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  late final Dio dio;
  late final Connectivity connectivity;

  DioConnectivityRequestRetrier({required this.dio, required this.connectivity});

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();

    StreamSubscription? streamSubscription;

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        print('streaming');

        if (connectivityResult != ConnectivityResult.none) {
          print('requesting again');
          streamSubscription!.cancel();
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(),
            ),
          );
        }
      },
    );
    return responseCompleter.future;
  }
}

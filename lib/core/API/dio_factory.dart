import 'package:dio/dio.dart';
import 'package:heal_meals/core/helper/shared_pref.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? dio;

  static Dio getDio() {
    Duration timeout = const Duration(minutes: 1);
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = timeout;
      dio!.options.receiveTimeout = timeout;
      dio!.options.headers = {'Content-Type': 'application/json'};
      addDioInterceptors(); // Add auth interceptor
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptors() {
    // Auth interceptor - runs before EVERY request
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Fetch token for each request
          final token = await SharedPrefHelper.getSecuredString('token');
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    // Logger interceptor
    dio?.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
    );
  }
}

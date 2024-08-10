import 'package:dio/dio.dart';
import 'package:tmdb_ek/utils/api_constants.dart';

class DioUtils {
  const DioUtils._();

  static Future<Dio> client() async {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {'Content-Type': 'application/json'},
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters['api_key'] = ApiConstants.apiKey;
        return handler.next(options);
      },
    ));

    return dio;
  }
}

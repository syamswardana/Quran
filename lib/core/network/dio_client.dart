import 'package:dio/dio.dart';
import 'package:quran/core/constants/api_url.dart';

class DioClient {
  DioClient._();

  static final DioClient _instance = DioClient._();
  static DioClient get instance => _instance;

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}

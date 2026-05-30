import 'package:dio/dio.dart';
import 'package:quran/core/constants/api_url.dart';
import 'package:quran/data/models/surah_model.dart';

abstract class SurahRemoteDataSource {
  Future<List<SurahModel>> getAllSurah();
}

class SurahRemoteDataSourceImpl implements SurahRemoteDataSource {
  final Dio dio;

  const SurahRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<SurahModel>> getAllSurah() async {
    final response = await dio.get(ApiUrl.surahs);
    final data = response.data['data'] as List;
    return data.map((json) => SurahModel.fromJson(json)).toList();
  }
}

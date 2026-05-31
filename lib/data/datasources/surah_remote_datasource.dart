import 'package:dio/dio.dart';
import 'package:quran/core/constants/api_url.dart';
import 'package:quran/data/models/surah_model.dart';
import 'package:quran/data/models/surah_detail_model.dart';

abstract class SurahRemoteDataSource {
  Future<List<SurahModel>> getAllSurah();
  Future<SurahDetailModel> getSurahDetail(int surahNumber);
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

  @override
  Future<SurahDetailModel> getSurahDetail(int surahNumber) async {
    final response = await dio.get(
      '/surah/$surahNumber/editions/"quran-uthmani-quran-academy,en.transliteration,en.walk,ar.alafasy',
    );
    final data = response.data['data'] as List;
    return SurahDetailModel.fromDataList(data);
  }
}

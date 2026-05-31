import 'package:quran/domain/entities/surah.dart';
import 'package:quran/domain/entities/surah_detail.dart';
abstract class SurahRepository {
  Future<List<Surah>> getAllSurah();
  Future<SurahDetail> getSurahDetail(int surahNumber);
}

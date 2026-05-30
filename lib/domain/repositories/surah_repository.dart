import 'package:quran/domain/entities/surah.dart';

abstract class SurahRepository {
  Future<List<Surah>> getAllSurah();
}

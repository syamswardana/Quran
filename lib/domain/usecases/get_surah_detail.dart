import 'package:quran/domain/entities/surah_detail.dart';
import 'package:quran/domain/repositories/surah_repository.dart';

class GetSurahDetail {
  final SurahRepository repository;

  GetSurahDetail(this.repository);

  Future<SurahDetail> call(int surahNumber) async {
    return await repository.getSurahDetail(surahNumber);
  }
}

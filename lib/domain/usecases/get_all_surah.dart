import 'package:quran/domain/entities/surah.dart';
import 'package:quran/domain/repositories/surah_repository.dart';

class GetAllSurah {
  final SurahRepository repository;

  const GetAllSurah(this.repository);

  Future<List<Surah>> call() async {
    return await repository.getAllSurah();
  }
}

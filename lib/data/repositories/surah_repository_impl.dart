import 'package:quran/data/datasources/surah_remote_datasource.dart';
import 'package:quran/domain/entities/surah.dart';
import 'package:quran/domain/repositories/surah_repository.dart';

class SurahRepositoryImpl implements SurahRepository {
  final SurahRemoteDataSource remoteDataSource;

  const SurahRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Surah>> getAllSurah() async {
    return await remoteDataSource.getAllSurah();
  }
}

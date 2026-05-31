import 'package:get_it/get_it.dart';
import 'package:quran/core/network/dio_client.dart';
import 'package:quran/data/datasources/surah_remote_datasource.dart';
import 'package:quran/data/repositories/surah_repository_impl.dart';
import 'package:quran/domain/repositories/surah_repository.dart';
import 'package:quran/domain/usecases/get_all_surah.dart';
import 'package:quran/domain/usecases/get_surah_detail.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_bloc.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_bloc.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Core
  sl.registerLazySingleton(() => DioClient.instance.dio);

  // Data sources
  sl.registerLazySingleton<SurahRemoteDataSource>(
    () => SurahRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<SurahRepository>(
    () => SurahRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllSurah(sl()));
  sl.registerLazySingleton(() => GetSurahDetail(sl()));

  // Blocs
  sl.registerFactory(() => SurahBloc(getAllSurah: sl()));
  sl.registerFactory(() => AyahBloc(getSurahDetail: sl()));
}


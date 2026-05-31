import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quran/domain/entities/surah.dart';
import 'package:quran/domain/usecases/get_all_surah.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_bloc.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_event.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_state.dart';

import 'surah_bloc_test.mocks.dart';

@GenerateMocks([GetAllSurah])
void main() {
  late SurahBloc surahBloc;
  late MockGetAllSurah mockGetAllSurah;

  setUp(() {
    mockGetAllSurah = MockGetAllSurah();
    surahBloc = SurahBloc(getAllSurah: mockGetAllSurah);
  });

  tearDown(() {
    surahBloc.close();
  });

  final tSurahs = [
    const Surah(
      number: 1,
      name: 'Al-Fatihah',
      englishName: 'Al-Fatihah',
      englishNameTranslation: 'The Opening',
      numberOfAyahs: 7,
      revelationType: RevelationType.meccan,
    ),
    const Surah(
      number: 2,
      name: 'Al-Baqarah',
      englishName: 'Al-Baqarah',
      englishNameTranslation: 'The Cow',
      numberOfAyahs: 286,
      revelationType: RevelationType.medinan,
    ),
  ];

  test('initial state should be SurahInitial', () {
    expect(surahBloc.state, SurahInitial());
  });

  blocTest<SurahBloc, SurahState>(
    'emits [SurahLoading, SurahLoaded] when GetAllSurahEvent is added and usecase succeeds',
    build: () {
      when(mockGetAllSurah.call()).thenAnswer((_) async => tSurahs);
      return surahBloc;
    },
    act: (bloc) => bloc.add(GetAllSurahEvent()),
    expect: () => [
      SurahLoading(),
      SurahLoaded(allSurahs: tSurahs, filteredSurahs: tSurahs),
    ],
    verify: (_) {
      verify(mockGetAllSurah.call());
    },
  );

  blocTest<SurahBloc, SurahState>(
    'emits [SurahLoading, SurahError] when GetAllSurahEvent is added and usecase fails',
    build: () {
      when(mockGetAllSurah.call()).thenThrow(Exception());
      return surahBloc;
    },
    act: (bloc) => bloc.add(GetAllSurahEvent()),
    expect: () => [
      SurahLoading(),
      const SurahError('Failed to load surahs. Please try again.'),
    ],
    verify: (_) {
      verify(mockGetAllSurah.call());
    },
  );

  blocTest<SurahBloc, SurahState>(
    'emits updated SurahLoaded with filtered results when SearchSurahEvent is added',
    build: () {
      // Setup the bloc with initial loaded state
      return SurahBloc(getAllSurah: mockGetAllSurah);
    },
    seed: () => SurahLoaded(allSurahs: tSurahs, filteredSurahs: tSurahs),
    act: (bloc) => bloc.add(const SearchSurahEvent('Baqarah')),
    expect: () => [
      SurahLoaded(
        allSurahs: tSurahs,
        filteredSurahs: [tSurahs[1]],
        searchQuery: 'Baqarah',
      ),
    ],
  );

  blocTest<SurahBloc, SurahState>(
    'emits updated SurahLoaded with filtered results when FilterSurahByCategoryEvent is added',
    build: () {
      return SurahBloc(getAllSurah: mockGetAllSurah);
    },
    seed: () => SurahLoaded(allSurahs: tSurahs, filteredSurahs: tSurahs),
    act: (bloc) => bloc.add(const FilterSurahByCategoryEvent(2)), // 2 = Madaniyah
    expect: () => [
      SurahLoaded(
        allSurahs: tSurahs,
        filteredSurahs: [tSurahs[1]],
        selectedTab: 2,
      ),
    ],
  );
}

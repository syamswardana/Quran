import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran/domain/entities/surah.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_bloc.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_event.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_state.dart';
import 'package:quran/presentation/pages/surah_list_page.dart';
import 'package:quran/presentation/widgets/surah_list_tile.dart';

class MockSurahBloc extends MockBloc<SurahEvent, SurahState>
    implements SurahBloc {}

void main() {
  late MockSurahBloc mockSurahBloc;

  setUp(() {
    mockSurahBloc = MockSurahBloc();
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          home: BlocProvider<SurahBloc>.value(
            value: mockSurahBloc,
            child: const SurahListPage(),
          ),
        );
      },
    );
  }

  testWidgets(
    'displays Skeletonizer with dummy items when state is SurahLoading',
    (WidgetTester tester) async {
      whenListen(
        mockSurahBloc,
        Stream<SurahState>.fromIterable([SurahLoading()]),
        initialState: SurahLoading(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Because Skeletonizer is enabled, the actual SurahListTiles are in the tree
      expect(find.byType(SurahListTile), findsWidgets);
    },
  );

  testWidgets(
    'displays list of surahs when state is SurahLoaded',
    (WidgetTester tester) async {
      final tSurahs = [
        const Surah(
          number: 1,
          name: 'Al-Fatihah',
          englishName: 'Al-Fatihah',
          englishNameTranslation: 'The Opening',
          numberOfAyahs: 7,
          revelationType: RevelationType.meccan,
        ),
      ];

      whenListen(
        mockSurahBloc,
        Stream<SurahState>.fromIterable([
          SurahLoaded(allSurahs: tSurahs, filteredSurahs: tSurahs)
        ]),
        initialState: SurahLoaded(allSurahs: tSurahs, filteredSurahs: tSurahs),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(SurahListTile), findsOneWidget);
      expect(find.text('Al-Fatihah'), findsWidgets);
    },
  );

  testWidgets(
    'displays error message and retry button when state is SurahError',
    (WidgetTester tester) async {
      whenListen(
        mockSurahBloc,
        Stream<SurahState>.fromIterable([const SurahError('Test error')]),
        initialState: const SurahError('Test error'),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Test error'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byIcon(Icons.cloud_off), findsOneWidget);
    },
  );
}

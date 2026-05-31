import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quran/core/audio/audio_player_service.dart';
import 'package:quran/domain/entities/ayah.dart';
import 'package:quran/domain/entities/surah.dart';
import 'package:quran/domain/entities/surah_detail.dart';
import 'package:quran/domain/usecases/get_surah_detail.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_bloc.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_event.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_state.dart';

import 'ayah_bloc_test.mocks.dart';

@GenerateMocks([GetSurahDetail, AudioPlayerService, AudioPlayer])
void main() {
  late AyahBloc ayahBloc;
  late MockGetSurahDetail mockGetSurahDetail;
  late MockAudioPlayerService mockAudioPlayerService;
  late MockAudioPlayer mockAudioPlayer;

  late StreamController<bool> playingStreamController;
  late StreamController<int?> currentIndexStreamController;
  late StreamController<Duration> positionStreamController;
  late StreamController<Duration?> durationStreamController;

  setUp(() {
    mockGetSurahDetail = MockGetSurahDetail();
    mockAudioPlayerService = MockAudioPlayerService();
    mockAudioPlayer = MockAudioPlayer();

    playingStreamController = StreamController<bool>.broadcast();
    currentIndexStreamController = StreamController<int?>.broadcast();
    positionStreamController = StreamController<Duration>.broadcast();
    durationStreamController = StreamController<Duration?>.broadcast();

    when(mockAudioPlayerService.player).thenReturn(mockAudioPlayer);

    when(mockAudioPlayer.playingStream)
        .thenAnswer((_) => playingStreamController.stream);
    when(mockAudioPlayer.currentIndexStream)
        .thenAnswer((_) => currentIndexStreamController.stream);
    when(mockAudioPlayer.positionStream)
        .thenAnswer((_) => positionStreamController.stream);
    when(mockAudioPlayer.durationStream)
        .thenAnswer((_) => durationStreamController.stream);

    when(mockAudioPlayer.playing).thenReturn(false);
    when(mockAudioPlayer.position).thenReturn(Duration.zero);
    when(mockAudioPlayer.duration).thenReturn(Duration.zero);
    when(mockAudioPlayer.sequenceState).thenReturn(null);

    ayahBloc = AyahBloc(
      getSurahDetail: mockGetSurahDetail,
      audioPlayerService: mockAudioPlayerService,
    );
  });

  tearDown(() {
    ayahBloc.close();
    playingStreamController.close();
    currentIndexStreamController.close();
    positionStreamController.close();
    durationStreamController.close();
  });

  final tAyahList = [
    const Ayah(
      number: 1,
      numberInSurah: 1,
      text: 'Text 1',
      transliteration: 'Trans 1',
      translation: 'Trans 1',
      audioUrl: 'url1',
    ),
  ];

  final tSurahDetail = SurahDetail(
    number: 1,
    name: 'Al-Fatihah',
    englishName: 'Al-Fatihah',
    englishNameTranslation: 'The Opening',
    numberOfAyahs: 7,
    revelationType: RevelationType.meccan,
    ayahs: tAyahList,
  );

  test('initial state should be AyahInitial', () {
    expect(ayahBloc.state, AyahInitial());
  });

  blocTest<AyahBloc, AyahState>(
    'emits [AyahLoading, AyahLoaded] when GetSurahDetailEvent is added and usecase succeeds',
    build: () {
      when(mockGetSurahDetail.call(any)).thenAnswer((_) async => tSurahDetail);
      return ayahBloc;
    },
    act: (bloc) => bloc.add(const GetSurahDetailEvent(1)),
    expect: () => [
      AyahLoading(),
      AyahLoaded(tSurahDetail),
    ],
    verify: (_) {
      verify(mockGetSurahDetail.call(1));
    },
  );

  blocTest<AyahBloc, AyahState>(
    'emits [AyahLoading, AyahError] when GetSurahDetailEvent is added and usecase fails',
    build: () {
      when(mockGetSurahDetail.call(any)).thenThrow(Exception());
      return ayahBloc;
    },
    act: (bloc) => bloc.add(const GetSurahDetailEvent(1)),
    expect: () => [
      AyahLoading(),
      const AyahError('Failed to load surah detail. Please try again.'),
    ],
    verify: (_) {
      verify(mockGetSurahDetail.call(1));
    },
  );

  blocTest<AyahBloc, AyahState>(
    'verifies audio service interactions when PlaySurahEvent is added',
    build: () {
      when(mockAudioPlayerService.initSurahPlaylist(any)).thenAnswer((_) async {});
      when(mockAudioPlayerService.play()).thenAnswer((_) async {});
      return ayahBloc;
    },
    act: (bloc) => bloc.add(PlaySurahEvent(tAyahList)),
    verify: (_) {
      verify(mockAudioPlayerService.initSurahPlaylist(tAyahList));
      verify(mockAudioPlayerService.play());
    },
  );

  blocTest<AyahBloc, AyahState>(
    'verifies audio service interactions when PlayAyahEvent is added',
    build: () {
      when(mockAudioPlayerService.initSingleAyah(any)).thenAnswer((_) async {});
      when(mockAudioPlayerService.play()).thenAnswer((_) async {});
      return ayahBloc;
    },
    act: (bloc) => bloc.add(PlayAyahEvent(0, tAyahList)),
    verify: (_) {
      verify(mockAudioPlayerService.initSingleAyah(tAyahList[0]));
      verify(mockAudioPlayerService.play());
    },
  );
  
  blocTest<AyahBloc, AyahState>(
    'verifies audio service interactions when PauseAudioEvent is added',
    build: () {
      when(mockAudioPlayerService.pause()).thenAnswer((_) async {});
      return ayahBloc;
    },
    act: (bloc) => bloc.add(PauseAudioEvent()),
    verify: (_) {
      verify(mockAudioPlayerService.pause());
    },
  );
}

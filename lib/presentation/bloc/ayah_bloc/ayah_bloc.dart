import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/audio/audio_player_service.dart';
import 'package:quran/domain/usecases/get_surah_detail.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_event.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_state.dart';

class AyahBloc extends Bloc<AyahEvent, AyahState> {
  final GetSurahDetail getSurahDetail;
  final AudioPlayerService audioPlayerService;
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _currentIndexSubscription;

  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;

  AyahBloc({
    required this.getSurahDetail,
    required this.audioPlayerService,
  }) : super(AyahInitial()) {
    on<GetSurahDetailEvent>(_onGetSurahDetail);
    on<PlaySurahEvent>(_onPlaySurah);
    on<PlayAyahEvent>(_onPlayAyah);
    on<PauseAudioEvent>(_onPauseAudio);
    on<UpdateAudioStateEvent>(_onUpdateAudioState);
    
    _listenToAudioStreams();
  }
  
  void _listenToAudioStreams() {
    _playerStateSubscription = audioPlayerService.player.playingStream.listen((_) => _emitAudioState());
    _currentIndexSubscription = audioPlayerService.player.currentIndexStream.listen((_) => _emitAudioState());
    _positionSubscription = audioPlayerService.player.positionStream.listen((_) => _emitAudioState());
    _durationSubscription = audioPlayerService.player.durationStream.listen((_) => _emitAudioState());
  }

  void _emitAudioState() {
    add(UpdateAudioStateEvent(
      isPlaying: audioPlayerService.player.playing,
      currentIndex: audioPlayerService.player.currentIndex,
      position: audioPlayerService.player.position,
      duration: audioPlayerService.player.duration ?? Duration.zero,
    ));
  }

  Future<void> _onGetSurahDetail(
    GetSurahDetailEvent event,
    Emitter<AyahState> emit,
  ) async {
    emit(AyahLoading());
    try {
      final surahDetail = await getSurahDetail(event.surahNumber);
      emit(AyahLoaded(surahDetail));
    } catch (e) {
      emit(const AyahError('Failed to load surah detail. Please try again.'));
    }
  }
  
  Future<void> _onPlaySurah(PlaySurahEvent event, Emitter<AyahState> emit) async {
    await audioPlayerService.initSurahPlaylist(event.ayahs);
    await audioPlayerService.play();
  }
  
  Future<void> _onPlayAyah(PlayAyahEvent event, Emitter<AyahState> emit) async {
    await audioPlayerService.initSurahPlaylist(event.ayahs);
    await audioPlayerService.seekToAyah(event.index);
    await audioPlayerService.play();
  }
  
  Future<void> _onPauseAudio(PauseAudioEvent event, Emitter<AyahState> emit) async {
    await audioPlayerService.pause();
  }
  
  void _onUpdateAudioState(UpdateAudioStateEvent event, Emitter<AyahState> emit) {
    if (state is AyahLoaded) {
      final currentState = state as AyahLoaded;
      emit(currentState.copyWith(
        isPlaying: event.isPlaying,
        currentPlayingAyahIndex: event.currentIndex,
        position: event.position,
        duration: event.duration,
      ));
    }
  }
  
  @override
  Future<void> close() {
    _playerStateSubscription?.cancel();
    _currentIndexSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    return super.close();
  }
}

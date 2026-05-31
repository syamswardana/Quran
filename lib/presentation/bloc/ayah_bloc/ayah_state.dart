import 'package:equatable/equatable.dart';
import 'package:quran/domain/entities/surah_detail.dart';

abstract class AyahState extends Equatable {
  const AyahState();

  @override
  List<Object?> get props => [];
}

class AyahInitial extends AyahState {}

class AyahLoading extends AyahState {}

class AyahLoaded extends AyahState {
  final SurahDetail surahDetail;
  final bool isPlaying;
  final int? currentPlayingAyahIndex;
  final Duration position;
  final Duration duration;

  const AyahLoaded(
    this.surahDetail, {
    this.isPlaying = false,
    this.currentPlayingAyahIndex,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });
  
  AyahLoaded copyWith({
    SurahDetail? surahDetail,
    bool? isPlaying,
    int? currentPlayingAyahIndex,
    Duration? position,
    Duration? duration,
  }) {
    return AyahLoaded(
      surahDetail ?? this.surahDetail,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPlayingAyahIndex: currentPlayingAyahIndex ?? this.currentPlayingAyahIndex,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [surahDetail, isPlaying, currentPlayingAyahIndex, position, duration];
}

class AyahError extends AyahState {
  final String message;

  const AyahError(this.message);

  @override
  List<Object?> get props => [message];
}

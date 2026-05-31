import 'package:equatable/equatable.dart';
import 'package:quran/domain/entities/ayah.dart';

abstract class AyahEvent extends Equatable {
  const AyahEvent();

  @override
  List<Object?> get props => [];
}

class GetSurahDetailEvent extends AyahEvent {
  final int surahNumber;

  const GetSurahDetailEvent(this.surahNumber);

  @override
  List<Object?> get props => [surahNumber];
}

class PlaySurahEvent extends AyahEvent {
  final List<Ayah> ayahs;
  const PlaySurahEvent(this.ayahs);
  @override
  List<Object?> get props => [ayahs];
}

class PlayAyahEvent extends AyahEvent {
  final int index;
  final List<Ayah> ayahs;
  const PlayAyahEvent(this.index, this.ayahs);
  @override
  List<Object?> get props => [index, ayahs];
}

class PauseAudioEvent extends AyahEvent {}

class ResumeAudioEvent extends AyahEvent {}

class UpdateAudioStateEvent extends AyahEvent {
  final bool isPlaying;
  final int? currentIndex;
  final Duration position;
  final Duration duration;
  
  const UpdateAudioStateEvent({
    required this.isPlaying,
    this.currentIndex,
    required this.position,
    required this.duration,
  });
  
  @override
  List<Object?> get props => [isPlaying, currentIndex, position, duration];
}

class SeekAudioEvent extends AyahEvent {
  final Duration position;
  const SeekAudioEvent(this.position);
  @override
  List<Object?> get props => [position];
}

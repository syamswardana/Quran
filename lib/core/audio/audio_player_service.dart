import 'package:just_audio/just_audio.dart';
import 'package:quran/domain/entities/ayah.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get player => _audioPlayer;

  Future<void> initSurahPlaylist(List<Ayah> ayahs) async {
    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: ayahs.map((ayah) {
        return AudioSource.uri(
          Uri.parse(ayah.audioUrl),
          tag: ayah.numberInSurah, 
        );
      }).toList(),
    );
    await _audioPlayer.setAudioSource(playlist);
  }

  Future<void> initSingleAyah(Ayah ayah) async {
    final source = AudioSource.uri(
      Uri.parse(ayah.audioUrl),
      tag: ayah.numberInSurah,
    );
    await _audioPlayer.setAudioSource(source);
  }

  Future<void> play() async => await _audioPlayer.play();
  Future<void> pause() async => await _audioPlayer.pause();
  Future<void> stop() async => await _audioPlayer.stop();
  Future<void> seekToAyah(int index) async {
    await _audioPlayer.seek(Duration.zero, index: index);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

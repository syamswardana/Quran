import 'package:equatable/equatable.dart';

class Ayah extends Equatable {
  final int number;
  final int numberInSurah;
  final String text;
  final String transliteration;
  final String translation;
  final String audioUrl;

  const Ayah({
    required this.number,
    required this.numberInSurah,
    required this.text,
    required this.transliteration,
    required this.translation,
    required this.audioUrl,
  });

  @override
  List<Object?> get props => [
        number,
        numberInSurah,
        text,
        transliteration,
        translation,
        audioUrl,
      ];
}

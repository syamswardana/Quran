import 'package:equatable/equatable.dart';

class Ayah extends Equatable {
  final int number;
  final int numberInSurah;
  final String text;
  final String transliteration;
  final String translation;

  const Ayah({
    required this.number,
    required this.numberInSurah,
    required this.text,
    required this.transliteration,
    required this.translation,
  });

  @override
  List<Object?> get props => [
        number,
        numberInSurah,
        text,
        transliteration,
        translation,
      ];
}

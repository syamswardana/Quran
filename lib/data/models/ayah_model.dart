import 'package:quran/domain/entities/ayah.dart';

class AyahModel extends Ayah {
  const AyahModel({
    required super.number,
    required super.numberInSurah,
    required super.text,
    required super.transliteration,
    required super.translation,
  });

  factory AyahModel.fromJsons({
    required Map<String, dynamic> tajweedJson,
    required Map<String, dynamic> transliterationJson,
    required Map<String, dynamic> translationJson,
  }) {
    return AyahModel(
      number: tajweedJson['number'] as int,
      numberInSurah: tajweedJson['numberInSurah'] as int,
      text: tajweedJson['text'] as String,
      transliteration: transliterationJson['text'] as String,
      translation: translationJson['text'] as String,
    );
  }
}

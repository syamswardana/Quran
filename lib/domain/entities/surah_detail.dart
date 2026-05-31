import 'package:quran/domain/entities/ayah.dart';
import 'package:quran/domain/entities/surah.dart';

class SurahDetail extends Surah {
  final List<Ayah> ayahs;

  const SurahDetail({
    required super.number,
    required super.name,
    required super.englishName,
    required super.englishNameTranslation,
    required super.numberOfAyahs,
    required super.revelationType,
    required this.ayahs,
  });
}

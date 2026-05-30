enum SurahCategory { makkiyah, madaniyah }

class Surah {
  final int number;
  final String nameEn;
  final String nameAr;
  final SurahCategory category;
  final int ayahCount;

  const Surah({
    required this.number,
    required this.nameEn,
    required this.nameAr,
    required this.category,
    required this.ayahCount,
  });

  String get categoryLabel =>
      category == SurahCategory.makkiyah ? 'Makkiyah' : 'Madaniyah';
}

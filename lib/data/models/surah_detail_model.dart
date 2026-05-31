import 'package:quran/domain/entities/surah.dart';
import 'package:quran/domain/entities/surah_detail.dart';
import 'package:quran/data/models/ayah_model.dart';

class SurahDetailModel extends SurahDetail {
  const SurahDetailModel({
    required super.number,
    required super.name,
    required super.englishName,
    required super.englishNameTranslation,
    required super.numberOfAyahs,
    required super.revelationType,
    required super.ayahs,
  });

  factory SurahDetailModel.fromDataList(List<dynamic> dataList) {
    final tajweedSurah = dataList[0] as Map<String, dynamic>;
    final transliterationSurah = dataList[1] as Map<String, dynamic>;
    final translationSurah = dataList[2] as Map<String, dynamic>;

    final tajweedAyahs = tajweedSurah['ayahs'] as List;
    final transliterationAyahs = transliterationSurah['ayahs'] as List;
    final translationAyahs = translationSurah['ayahs'] as List;

    List<AyahModel> ayahs = [];
    for (int i = 0; i < tajweedAyahs.length; i++) {
      ayahs.add(AyahModel.fromJsons(
        tajweedJson: tajweedAyahs[i] as Map<String, dynamic>,
        transliterationJson: transliterationAyahs[i] as Map<String, dynamic>,
        translationJson: translationAyahs[i] as Map<String, dynamic>,
      ));
    }

    return SurahDetailModel(
      number: tajweedSurah['number'] as int,
      name: tajweedSurah['name'] as String,
      englishName: tajweedSurah['englishName'] as String,
      englishNameTranslation: tajweedSurah['englishNameTranslation'] as String,
      numberOfAyahs: tajweedSurah['numberOfAyahs'] as int,
      revelationType: (tajweedSurah['revelationType'] as String) == 'Meccan'
          ? RevelationType.meccan
          : RevelationType.medinan,
      ayahs: ayahs,
    );
  }
}

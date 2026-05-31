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

    final tajweedAyahs = dataList[0]['ayahs'] as List;
    final transliterationAyahs = dataList[1]['ayahs'] as List;
    final translationAyahs = dataList[2]['ayahs'] as List;
    final audioAyahs = dataList[3]['ayahs'] as List;

    final ayahs = <AyahModel>[];
    for (int i = 0; i < tajweedAyahs.length; i++) {
      ayahs.add(AyahModel.fromJsons(
        tajweedJson: tajweedAyahs[i] as Map<String, dynamic>,
        transliterationJson: transliterationAyahs[i] as Map<String, dynamic>,
        translationJson: translationAyahs[i] as Map<String, dynamic>,
        audioJson: audioAyahs[i] as Map<String, dynamic>,
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

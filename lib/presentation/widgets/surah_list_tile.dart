import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_theme.dart';
import 'package:quran/domain/surah.dart';

class SurahListTile extends StatelessWidget {
  final Surah surah;
  final VoidCallback? onTap;

  const SurahListTile({
    super.key,
    required this.surah,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
        child: Row(
          children: [
            // Number badge
            Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: Text(
                '${surah.number}',
                style: AppTextStyles.surahNumber,
              ),
            ),
            SizedBox(width: 14.w),
            // Name + metadata
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surah.nameEn, style: AppTextStyles.surahName),
                  SizedBox(height: 3.h),
                  Text(
                    '${surah.categoryLabel} • ${surah.ayahCount} Ayahs',
                    style: AppTextStyles.surahMeta,
                  ),
                ],
              ),
            ),
            SizedBox(width: 14.w),
            // Arabic name
            Text(
              surah.nameAr,
              style: AppTextStyles.arabicName,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_theme.dart';
import 'package:quran/domain/entities/surah.dart';

class SurahDetailPage extends StatelessWidget {
  final Surah surah;

  const SurahDetailPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    // Mock data based on the design
    final List<Map<String, String>> ayahs = [
      {
        'arabic': 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
        'translation': 'All praise is due to Allah, Lord of the worlds.',
      },
      {
        'arabic': 'الرَّحْمَٰنِ الرَّحِيمِ',
        'translation': 'The Most Gracious, the Most Merciful.',
      },
      {
        'arabic': 'مَالِكِ يَوْمِ الدِّينِ',
        'translation': 'Master of the Day of Judgment.',
      },
      {
        'arabic': 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
        'translation': 'You alone we worship, and You alone we ask for help.',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.secondaryText, size: 22.sp),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  Column(
                    children: [
                      Text(
                        surah.englishName,
                        style: AppTextStyles.title.copyWith(fontSize: 16.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        surah.englishNameTranslation.toUpperCase(),
                        style: AppTextStyles.surahMeta.copyWith(fontSize: 11.sp),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.play_arrow, color: AppColors.secondaryText, size: 24.sp),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                child: Column(
                  children: [
                    // Surah Info Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            surah.name,
                            style: AppTextStyles.arabicName.copyWith(fontSize: 28.sp),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            surah.englishNameTranslation.toUpperCase(),
                            style: AppTextStyles.surahMeta.copyWith(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Bismillah
                          Container(
                            height: 1.h,
                            width: 60.w,
                            color: const Color(0xFF2A3A4D),
                            margin: EdgeInsets.only(bottom: 16.h),
                          ),
                          Text(
                            'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                            style: AppTextStyles.arabicName.copyWith(
                              fontSize: 22.sp,
                              color: const Color(0xFFE8D5A3),
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    
                    // Ayahs List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ayahs.length,
                      separatorBuilder: (context, index) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final ayah = ayahs[index];
                        return Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Top bar with ayah number
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 28.w,
                                    height: 28.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.activeTab,
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  Icon(Icons.play_arrow_outlined, color: AppColors.gold, size: 20.sp),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              
                              // Arabic Text
                              Text(
                                ayah['arabic']!,
                                style: AppTextStyles.arabicName.copyWith(
                                  color: AppColors.primaryText,
                                  fontSize: 26.sp,
                                  height: 2,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(height: 12.h),
                              
                              // Divider
                              Container(
                                height: 1.h,
                                color: const Color(0xFF2A3A4D).withValues(alpha: 0.3),
                              ),
                              SizedBox(height: 12.h),
                              
                              // Translation Text
                              Text(
                                ayah['translation']!,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.secondaryText,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

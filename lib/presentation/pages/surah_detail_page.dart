import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_theme.dart';
import 'package:quran/domain/entities/surah.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/core/injection/service_locator.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_bloc.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_event.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_state.dart';

class SurahDetailPage extends StatelessWidget {
  final Surah surah;

  const SurahDetailPage({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AyahBloc>()..add(GetSurahDetailEvent(surah.number)),
      child: Scaffold(
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
                          // Pills
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildInfoPill('${surah.numberOfAyahs} Ayahs'),
                              SizedBox(width: 16.w),
                              _buildInfoPill(surah.categoryLabel),
                            ],
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
                    BlocBuilder<AyahBloc, AyahState>(
                      builder: (context, state) {
                        if (state is AyahLoading) {
                          return Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        } else if (state is AyahError) {
                          return Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: Center(
                              child: Text(
                                state.message,
                                style: TextStyle(color: Colors.red, fontSize: 14.sp),
                              ),
                            ),
                          );
                        } else if (state is AyahLoaded) {
                          final ayahs = state.surahDetail.ayahs;
                          return ListView.separated(
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
                                ayah.text,
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
                                ayah.transliteration,
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
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ));
}

  Widget _buildInfoPill(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.gold,
        ),
      ),
    );
  }
}

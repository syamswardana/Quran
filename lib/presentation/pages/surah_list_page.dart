import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_theme.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_bloc.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_event.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_state.dart';
import 'package:quran/presentation/pages/surah_detail_page.dart';
import 'package:quran/presentation/widgets/category_tabs.dart';
import 'package:quran/presentation/widgets/surah_list_tile.dart';
import 'package:quran/presentation/widgets/surah_search_bar.dart';

class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text('Surah', style: AppTextStyles.title),
              SizedBox(height: 16.h),

              // Search bar
              SurahSearchBar(
                onChanged: (query) =>
                    context.read<SurahBloc>().add(SearchSurahEvent(query)),
              ),
              SizedBox(height: 16.h),

              // Category tabs
              BlocBuilder<SurahBloc, SurahState>(
                buildWhen: (prev, curr) =>
                    curr is SurahLoaded &&
                    (prev is! SurahLoaded ||
                        prev.selectedTab != curr.selectedTab),
                builder: (context, state) {
                  final selectedTab = state is SurahLoaded
                      ? state.selectedTab
                      : 0;
                  return CategoryTabs(
                    selectedIndex: selectedTab,
                    onChanged: (index) => context.read<SurahBloc>().add(
                      FilterSurahByCategoryEvent(index),
                    ),
                  );
                },
              ),
              SizedBox(height: 8.h),

              // Content
              Expanded(
                child: BlocBuilder<SurahBloc, SurahState>(
                  builder: (context, state) {
                    if (state is SurahLoading || state is SurahInitial) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.gold),
                      );
                    }

                    if (state is SurahError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_off,
                              color: AppColors.secondaryText,
                              size: 48.sp,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              state.message,
                              style: AppTextStyles.surahMeta,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            TextButton(
                              onPressed: () => context.read<SurahBloc>().add(
                                GetAllSurahEvent(),
                              ),
                              child: Text(
                                'Retry',
                                style: AppTextStyles.surahName.copyWith(
                                  color: AppColors.gold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is SurahLoaded) {
                      final surahs = state.filteredSurahs;

                      if (surahs.isEmpty) {
                        return Center(
                          child: Text(
                            'No surahs found',
                            style: AppTextStyles.surahMeta,
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: surahs.length,
                        itemBuilder: (context, index) {
                          return SurahListTile(
                            surah: surahs[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SurahDetailPage(surah: surahs[index]),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

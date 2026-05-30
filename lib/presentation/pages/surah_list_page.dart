import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_theme.dart';
import 'package:quran/domain/entities/surah.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_bloc.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_event.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_state.dart';
import 'package:quran/presentation/widgets/category_tabs.dart';
import 'package:quran/presentation/widgets/surah_list_tile.dart';
import 'package:quran/presentation/widgets/surah_search_bar.dart';

class SurahListPage extends StatefulWidget {
  const SurahListPage({super.key});

  @override
  State<SurahListPage> createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage> {
  int _selectedTab = 0;
  String _searchQuery = '';

  List<Surah> _filterSurahs(List<Surah> surahs) {
    var filtered = surahs;

    // Filter by category
    if (_selectedTab == 1) {
      filtered = filtered
          .where((s) => s.revelationType == RevelationType.meccan)
          .toList();
    } else if (_selectedTab == 2) {
      filtered = filtered
          .where((s) => s.revelationType == RevelationType.medinan)
          .toList();
    }

    // Filter by search
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered
          .where((s) =>
              s.englishName.toLowerCase().contains(query) ||
              s.name.contains(_searchQuery))
          .toList();
    }

    return filtered;
  }

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
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              SizedBox(height: 16.h),

              // Category tabs
              CategoryTabs(
                selectedIndex: _selectedTab,
                onChanged: (index) => setState(() => _selectedTab = index),
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
                            Icon(Icons.cloud_off,
                                color: AppColors.secondaryText, size: 48.sp),
                            SizedBox(height: 16.h),
                            Text(
                              state.message,
                              style: AppTextStyles.surahMeta,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            TextButton(
                              onPressed: () => context
                                  .read<SurahBloc>()
                                  .add(GetAllSurahEvent()),
                              child: Text(
                                'Retry',
                                style: AppTextStyles.surahName
                                    .copyWith(color: AppColors.gold),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is SurahLoaded) {
                      final surahs = _filterSurahs(state.surahs);

                      if (surahs.isEmpty) {
                        return Center(
                          child: Text('No surahs found',
                              style: AppTextStyles.surahMeta),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: surahs.length,
                        itemBuilder: (context, index) {
                          return SurahListTile(surah: surahs[index]);
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

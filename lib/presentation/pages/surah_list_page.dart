import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_theme.dart';
import 'package:quran/data/surah_data.dart';
import 'package:quran/domain/surah.dart';
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

  List<Surah> get _filteredSurahs {
    var surahs = SurahData.allSurahs;

    // Filter by category
    if (_selectedTab == 1) {
      surahs = surahs
          .where((s) => s.category == SurahCategory.makkiyah)
          .toList();
    } else if (_selectedTab == 2) {
      surahs = surahs
          .where((s) => s.category == SurahCategory.madaniyah)
          .toList();
    }

    // Filter by search
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      surahs = surahs
          .where((s) =>
              s.nameEn.toLowerCase().contains(query) ||
              s.nameAr.contains(_searchQuery))
          .toList();
    }

    return surahs;
  }

  @override
  Widget build(BuildContext context) {
    final surahs = _filteredSurahs;

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

              // Surah list
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: surahs.length,
                  itemBuilder: (context, index) {
                    return SurahListTile(surah: surahs[index]);
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

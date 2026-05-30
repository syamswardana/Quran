import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_theme.dart';

class SurahSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SurahSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: AppColors.secondaryText,
            size: 18.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: AppTextStyles.searchHint.copyWith(
                color: AppColors.primaryText,
              ),
              decoration: InputDecoration(
                hintText: 'Search surah name...',
                hintStyle: AppTextStyles.searchHint,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

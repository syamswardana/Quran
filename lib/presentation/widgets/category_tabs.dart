import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_theme.dart';

class CategoryTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const CategoryTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  static const _labels = ['All', 'Makkiyah', 'Madaniyah'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(3.r),
      child: Row(
        children: List.generate(_labels.length, (i) {
          final isActive = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.activeTab : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  _labels[i],
                  style: AppTextStyles.tabLabel.copyWith(
                    color: isActive ? Colors.white : AppColors.secondaryText,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

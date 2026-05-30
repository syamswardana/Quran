import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_theme.dart';
import 'package:quran/core/injection/service_locator.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_bloc.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_event.dart';
import 'package:quran/presentation/pages/surah_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SurahBloc>(
              create: (_) => sl<SurahBloc>()..add(GetAllSurahEvent()),
            ),
          ],
          child: MaterialApp(
            title: 'Quran',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.dark,
            home: const SurahListPage(),
          ),
        );
      },
    );
  }
}

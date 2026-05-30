import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/domain/entities/surah.dart';
import 'package:quran/domain/usecases/get_all_surah.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_event.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final GetAllSurah getAllSurah;

  SurahBloc({required this.getAllSurah}) : super(SurahInitial()) {
    on<GetAllSurahEvent>(_onGetAllSurah);
    on<SearchSurahEvent>(_onSearch);
    on<FilterSurahByCategoryEvent>(_onFilterByCategory);
  }

  Future<void> _onGetAllSurah(
    GetAllSurahEvent event,
    Emitter<SurahState> emit,
  ) async {
    emit(SurahLoading());
    try {
      final surahs = await getAllSurah();
      emit(SurahLoaded(allSurahs: surahs, filteredSurahs: surahs));
    } catch (e) {
      emit(const SurahError('Failed to load surahs. Please try again.'));
    }
  }

  void _onSearch(SearchSurahEvent event, Emitter<SurahState> emit) {
    final currentState = state;
    if (currentState is SurahLoaded) {
      final filtered = _applyFilters(
        currentState.allSurahs,
        event.query,
        currentState.selectedTab,
      );
      emit(SurahLoaded(
        allSurahs: currentState.allSurahs,
        filteredSurahs: filtered,
        searchQuery: event.query,
        selectedTab: currentState.selectedTab,
      ));
    }
  }

  void _onFilterByCategory(
    FilterSurahByCategoryEvent event,
    Emitter<SurahState> emit,
  ) {
    final currentState = state;
    if (currentState is SurahLoaded) {
      final filtered = _applyFilters(
        currentState.allSurahs,
        currentState.searchQuery,
        event.tabIndex,
      );
      emit(SurahLoaded(
        allSurahs: currentState.allSurahs,
        filteredSurahs: filtered,
        searchQuery: currentState.searchQuery,
        selectedTab: event.tabIndex,
      ));
    }
  }

  List<Surah> _applyFilters(
    List<Surah> surahs,
    String query,
    int tabIndex,
  ) {
    var filtered = surahs;

    if (tabIndex == 1) {
      filtered = filtered
          .where((s) => s.revelationType == RevelationType.meccan)
          .toList();
    } else if (tabIndex == 2) {
      filtered = filtered
          .where((s) => s.revelationType == RevelationType.medinan)
          .toList();
    }

    if (query.isNotEmpty) {
      final lowerQuery = query.toLowerCase();
      filtered = filtered
          .where((s) =>
              s.englishName.toLowerCase().contains(lowerQuery) ||
              s.name.contains(query))
          .toList();
    }

    return filtered;
  }
}

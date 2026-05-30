import 'package:equatable/equatable.dart';
import 'package:quran/domain/entities/surah.dart';

abstract class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object?> get props => [];
}

class SurahInitial extends SurahState {}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final List<Surah> allSurahs;
  final List<Surah> filteredSurahs;
  final String searchQuery;
  final int selectedTab;

  const SurahLoaded({
    required this.allSurahs,
    required this.filteredSurahs,
    this.searchQuery = '',
    this.selectedTab = 0,
  });

  @override
  List<Object?> get props => [allSurahs, filteredSurahs, searchQuery, selectedTab];
}

class SurahError extends SurahState {
  final String message;

  const SurahError(this.message);

  @override
  List<Object?> get props => [message];
}

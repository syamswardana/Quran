import 'package:equatable/equatable.dart';

abstract class SurahEvent extends Equatable {
  const SurahEvent();

  @override
  List<Object?> get props => [];
}

class GetAllSurahEvent extends SurahEvent {}

class SearchSurahEvent extends SurahEvent {
  final String query;

  const SearchSurahEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterSurahByCategoryEvent extends SurahEvent {
  final int tabIndex;

  const FilterSurahByCategoryEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

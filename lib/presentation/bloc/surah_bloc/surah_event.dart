import 'package:equatable/equatable.dart';

abstract class SurahEvent extends Equatable {
  const SurahEvent();

  @override
  List<Object?> get props => [];
}

class GetAllSurahEvent extends SurahEvent {}

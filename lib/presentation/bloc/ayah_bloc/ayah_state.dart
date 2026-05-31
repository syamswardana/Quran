import 'package:equatable/equatable.dart';
import 'package:quran/domain/entities/surah_detail.dart';

abstract class AyahState extends Equatable {
  const AyahState();

  @override
  List<Object> get props => [];
}

class AyahInitial extends AyahState {}

class AyahLoading extends AyahState {}

class AyahLoaded extends AyahState {
  final SurahDetail surahDetail;

  const AyahLoaded(this.surahDetail);

  @override
  List<Object> get props => [surahDetail];
}

class AyahError extends AyahState {
  final String message;

  const AyahError(this.message);

  @override
  List<Object> get props => [message];
}

import 'package:equatable/equatable.dart';

abstract class AyahEvent extends Equatable {
  const AyahEvent();

  @override
  List<Object> get props => [];
}

class GetSurahDetailEvent extends AyahEvent {
  final int surahNumber;

  const GetSurahDetailEvent(this.surahNumber);

  @override
  List<Object> get props => [surahNumber];
}

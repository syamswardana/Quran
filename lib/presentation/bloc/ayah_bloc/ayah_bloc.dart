import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/domain/usecases/get_surah_detail.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_event.dart';
import 'package:quran/presentation/bloc/ayah_bloc/ayah_state.dart';

class AyahBloc extends Bloc<AyahEvent, AyahState> {
  final GetSurahDetail getSurahDetail;

  AyahBloc({required this.getSurahDetail}) : super(AyahInitial()) {
    on<GetSurahDetailEvent>(_onGetSurahDetail);
  }

  Future<void> _onGetSurahDetail(
    GetSurahDetailEvent event,
    Emitter<AyahState> emit,
  ) async {
    emit(AyahLoading());
    try {
      final surahDetail = await getSurahDetail(event.surahNumber);
      emit(AyahLoaded(surahDetail));
    } catch (e) {
      emit(const AyahError('Failed to load surah detail. Please try again.'));
    }
  }
}

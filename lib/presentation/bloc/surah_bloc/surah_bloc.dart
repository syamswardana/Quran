import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/domain/usecases/get_all_surah.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_event.dart';
import 'package:quran/presentation/bloc/surah_bloc/surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final GetAllSurah getAllSurah;

  SurahBloc({required this.getAllSurah}) : super(SurahInitial()) {
    on<GetAllSurahEvent>(_onGetAllSurah);
  }

  Future<void> _onGetAllSurah(
    GetAllSurahEvent event,
    Emitter<SurahState> emit,
  ) async {
    emit(SurahLoading());
    try {
      final surahs = await getAllSurah();
      emit(SurahLoaded(surahs));
    } catch (e) {
      emit(SurahError('Failed to load surahs. Please try again.'));
    }
  }
}

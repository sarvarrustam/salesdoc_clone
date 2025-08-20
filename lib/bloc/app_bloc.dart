// lib/app_bloc/app_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppStateWithPage('Dashboard')) {
    on<NavigateToPage>((event, emit) {
      emit(AppStateWithPage(event.pageName));
    });
  }
}

// lib/app_bloc/app_state.dart
import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppStateWithPage extends AppState {
  final String activePage;
  const AppStateWithPage(this.activePage);

  @override
  List<Object> get props => [activePage];
}

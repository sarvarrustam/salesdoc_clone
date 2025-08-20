// lib/app_bloc/app_event.dart
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class NavigateToPage extends AppEvent {
  final String pageName;
  const NavigateToPage(this.pageName);

  @override
  List<Object> get props => [pageName];
}

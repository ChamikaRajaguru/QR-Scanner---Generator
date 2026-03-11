import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/datasources/storage_service.dart';

// Events
abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleTheme extends ThemeEvent {}

// States
class ThemeState extends Equatable {
  final bool isDarkMode;
  const ThemeState(this.isDarkMode);
  @override
  List<Object?> get props => [isDarkMode];
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final StorageService storageService;

  ThemeBloc(this.storageService) : super(ThemeState(storageService.isDarkMode())) {
    on<ToggleTheme>((event, emit) async {
      final newValue = !state.isDarkMode;
      await storageService.setDarkMode(newValue);
      emit(ThemeState(newValue));
    });
  }
}

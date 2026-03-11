import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/qr_model.dart';
import '../../data/datasources/storage_service.dart';

// Events
abstract class QREvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHistory extends QREvent {}

class SaveQR extends QREvent {
  final QRModel qr;
  SaveQR(this.qr);
  @override
  List<Object?> get props => [qr];
}

class DeleteQR extends QREvent {
  final String id;
  DeleteQR(this.id);
  @override
  List<Object?> get props => [id];
}

class ClearHistory extends QREvent {}

// States
abstract class QRState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QRInitial extends QRState {}

class QRLoading extends QRState {}

class QRHistoryLoaded extends QRState {
  final List<QRModel> history;
  QRHistoryLoaded(this.history);
  @override
  List<Object?> get props => [history];
}

class QRError extends QRState {
  final String message;
  QRError(this.message);
  @override
  List<Object?> get props => [message];
}

// BLoC
class QRBloc extends Bloc<QREvent, QRState> {
  final StorageService storageService;

  QRBloc(this.storageService) : super(QRInitial()) {
    on<LoadHistory>((event, emit) {
      emit(QRLoading());
      try {
        final history = storageService.getHistory();
        emit(QRHistoryLoaded(history));
      } catch (e) {
        emit(QRError(e.toString()));
      }
    });

    on<SaveQR>((event, emit) async {
      try {
        await storageService.saveQR(event.qr);
        add(LoadHistory());
      } catch (e) {
        emit(QRError(e.toString()));
      }
    });

    on<DeleteQR>((event, emit) async {
      try {
        await storageService.deleteQR(event.id);
        add(LoadHistory());
      } catch (e) {
        emit(QRError(e.toString()));
      }
    });

    on<ClearHistory>((event, emit) async {
      try {
        await storageService.clearHistory();
        emit(QRHistoryLoaded([]));
      } catch (e) {
        emit(QRError(e.toString()));
      }
    });
  }
}

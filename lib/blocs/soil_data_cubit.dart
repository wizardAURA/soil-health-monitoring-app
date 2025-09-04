import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/soil_reading.dart';
import '../services/bluetooth_service.dart';
import '../services/firebase_service.dart';

abstract class SoilDataState {}

class SoilDataInitial extends SoilDataState {}

class SoilDataLoading extends SoilDataState {}

class SoilDataLoaded extends SoilDataState {
  final List<SoilReading> readings;
  SoilDataLoaded(this.readings);
}

class SoilDataError extends SoilDataState {
  final String message;
  SoilDataError(this.message);
}

class SoilDataCubit extends Cubit<SoilDataState> {
  final BluetoothService _bluetoothService = BluetoothService();
  final FirebaseService _firebaseService = FirebaseService();
  StreamSubscription? _readingsSubscription;

  SoilDataCubit() : super(SoilDataInitial());

  Future<void> fetchAndSaveNewReading() async {
    try {
      final newReading = await _bluetoothService.getMockReading();
      await _firebaseService.addReading(newReading);
    } catch (e) {
      emit(SoilDataError("Failed to save new reading."));
    }
  }

  void subscribeToReadings() {
    emit(SoilDataLoading());
    _readingsSubscription?.cancel();
    _readingsSubscription = _firebaseService.getReadings().listen(
      (readings) {
        emit(SoilDataLoaded(readings));
      },
      onError: (error) {
        emit(SoilDataError("Failed to load historical data."));
      },
    );
  }

  Future<void> deleteReading(String readingId) async {
    try {
      await _firebaseService.deleteReading(readingId);
    } catch (e) {
      print("Failed to delete reading: $e");
    }
  }

  @override
  Future<void> close() {
    _readingsSubscription?.cancel();
    return super.close();
  }
}

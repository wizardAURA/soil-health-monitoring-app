import 'dart:math';
import '../models/soil_reading.dart';

class BluetoothService {
  Future<SoilReading> getMockReading() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final random = Random();
    final temp = 18.0 + random.nextDouble() * 10;
    final moist = 30.0 + random.nextDouble() * 40;

    return SoilReading(
      timestamp: DateTime.now(),
      temperature: temp,
      moisture: moist,
    );
  }
}

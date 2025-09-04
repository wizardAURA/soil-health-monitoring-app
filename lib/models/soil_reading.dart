class SoilReading {
  final String? id;
  final DateTime timestamp;
  final double temperature;
  final double moisture;

  SoilReading({
    this.id,
    required this.timestamp,
    required this.temperature,
    required this.moisture,
  });
}

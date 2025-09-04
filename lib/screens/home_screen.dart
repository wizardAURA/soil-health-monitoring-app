import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../blocs/soil_data_cubit.dart';
import '../models/soil_reading.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SoilDataCubit>().subscribeToReadings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Soil Health Monitor")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<SoilDataCubit, SoilDataState>(
                builder: (context, state) {
                  if (state is SoilDataLoaded) {
                    if (state.readings.isEmpty) {
                      return const Center(
                        child: Text(
                          "Press 'Test' to capture the first reading.",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final readings = state.readings;

                    return SfCartesianChart(
                      primaryXAxis: const DateTimeAxis(),
                      title: const ChartTitle(text: 'Live Soil Health Trends'),
                      legend: const Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<SoilReading, DateTime>>[
                        LineSeries<SoilReading, DateTime>(
                          dataSource: readings,
                          xValueMapper: (SoilReading r, _) => r.timestamp,
                          yValueMapper: (SoilReading r, _) => r.temperature,
                          name: 'Temperature (°C)',
                          color: Colors.orange,
                          markerSettings: const MarkerSettings(isVisible: true),
                        ),
                        LineSeries<SoilReading, DateTime>(
                          dataSource: readings,
                          xValueMapper: (SoilReading r, _) => r.timestamp,
                          yValueMapper: (SoilReading r, _) => r.moisture,
                          name: 'Moisture (%)',
                          color: Colors.blue,
                          markerSettings: const MarkerSettings(isVisible: true),
                        ),
                      ],
                    );
                  }
                  if (state is SoilDataError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            // The buttons are at the bottom
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.science),
                    label: const Text("Test"),
                    onPressed: () {
                      context.read<SoilDataCubit>().fetchAndSaveNewReading();
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.list_alt),
                    label: const Text("Reports"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const HistoryScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

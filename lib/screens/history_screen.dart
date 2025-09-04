import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/soil_data_cubit.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SoilDataCubit>().subscribeToReadings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historical Data")),
      body: BlocBuilder<SoilDataCubit, SoilDataState>(
        builder: (context, state) {
          if (state is SoilDataLoaded) {
            if (state.readings.isEmpty) {
              return const Center(
                child: Text(
                  "No readings yet. Press 'Test' on the home screen.",
                ),
              );
            }
            return ListView.builder(
              itemCount: state.readings.length,
              itemBuilder: (context, index) {
                final reading = state.readings[index];
                return Dismissible(
                  key: Key(reading.id!),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<SoilDataCubit>().deleteReading(reading.id!);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text("Report deleted")),
                      );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.notes, color: Colors.grey),
                    title: Text(
                      'Temp: ${reading.temperature.toStringAsFixed(1)}°C',
                    ),
                    trailing: Text(
                      'Moisture: ${reading.moisture.toStringAsFixed(1)}%',
                    ),
                    subtitle: Text(reading.timestamp.toString()),
                  ),
                );
              },
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
    );
  }
}

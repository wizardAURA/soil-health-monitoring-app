import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soilhealthmonitor/blocs/auth_cubit.dart';
import 'package:soilhealthmonitor/blocs/soil_data_cubit.dart';
import 'package:soilhealthmonitor/screens/auth_screen.dart';
import 'package:soilhealthmonitor/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(FirebaseService())),
        BlocProvider(create: (context) => SoilDataCubit()),
      ],
      child: MaterialApp(
        title: 'Soil Health Monitor',
        theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
        home: AuthScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quantified_user_behavior_and_risk_intelligence_xpert/Screens/ConnectivityTestScreen/connectivity_test_screen.dart';

void main() {
  runApp(const QubrixApp());
}

class QubrixApp extends StatelessWidget {
  const QubrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qubrix',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const ConnectivityTestScreen(),
    );
  }
}

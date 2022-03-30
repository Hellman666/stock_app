import 'package:flutter/material.dart';
import 'package:stock_sim/screens/portfolio.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STOCK-SIM',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: const Portfolio(),
    );
  }
}
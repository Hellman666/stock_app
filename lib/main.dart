import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_sim/screens/portfolio.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STOCK-SIM',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: Portfolio(),
    );
  }
}